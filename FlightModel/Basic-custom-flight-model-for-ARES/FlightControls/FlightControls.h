#ifndef __PlaneFMFLIGHTCONTROLS__
#define __PlaneFMFLIGHTCONTROLS__

#include "../stdafx.h"
#include <stdio.h>
#include <string>
#include <math.h>
#include "../UtilityFunctions.h"
#include "../include/general_filter.h"

namespace PlaneFM
{
	namespace FLIGHTCONTROLS
	{
		bool		simInitialized = false;

		double		leading_edge_flap_integral					= 0.0;
		double		leading_edge_flap_integrated				= 0.0;
		double		leading_edge_flap_rate						= 0.0;
		double		leading_edge_flap_integrated_gained			= 0.0;
		double		leading_edge_flap_integrated_gained_biased	= 0.0;

		// Control filters (general filters to easily code up when compared to report block diagrams)
		GeneralFilter	pitchRateWashout;
		GeneralFilter	pitchIntegrator;
		GeneralFilter	pitchPreActuatorFilter;
		GeneralFilter	pitchActuatorDynamicsFilter;
		GeneralFilter	accelFilter;
		GeneralFilter	latStickForceFilter;
		GeneralFilter	rollCommandFilter;
		GeneralFilter	rollActuatorDynamicsFilter;
		GeneralFilter	rollRateFilter1;
		GeneralFilter	rollRateFilter2;
		GeneralFilter	rudderCommandFilter;
		GeneralFilter	yawRateWashout;
		GeneralFilter	yawRateFilter;
		GeneralFilter	yawServoFilter;

		// Pitch controller variables
		double		longStickInput			= 0.0;
		double		stickCommandPosFiltered = 0.0;
		double		azFiltered				= 0.0;
		double		alphaFiltered			= 0.0;
		double		longStickForce			= 0.0;
		double		latStickInput			= 0.0;

		
		double PitchCommand_DEG = 0;
		double PitchCommand_norm = 0.0;
		double stickCommandPos = 0;
		double FinalStickCommand = 0;
		double PrevFinalStickCommand = 0;



		// Controller for the leading edge flaps
		double leading_edge_flap_controller(double alpha_DEG, double dynamicPressure_FTLB, double staticPressure_FTLB, double frameTime)
		{
			double qbarOverPs = dynamicPressure_FTLB/staticPressure_FTLB;

			if(!(simInitialized))
			{
				leading_edge_flap_integral = -alpha_DEG;
				leading_edge_flap_integrated = leading_edge_flap_integral + 2*alpha_DEG;
				return leading_edge_flap_integral;
			}

			leading_edge_flap_rate = (alpha_DEG - leading_edge_flap_integrated) * 7.25;
			leading_edge_flap_integral += (leading_edge_flap_rate * frameTime);

			leading_edge_flap_integrated = leading_edge_flap_integral + alpha_DEG * 2.0;
			leading_edge_flap_integrated_gained = leading_edge_flap_integrated * 1.38;
			leading_edge_flap_integrated_gained_biased = leading_edge_flap_integrated_gained + 1.45 - (9.05 * qbarOverPs);	

			return leading_edge_flap_integrated_gained_biased; 
		}

		// Controller for yaw
		double fcs_yaw_controller(double pedInput, double pedTrim)
		{
			double rudderCommand = pedInput;

			double finalRudderCommand = rudderCommand;

			return finalRudderCommand;
		}

		// Stick force schedule for pitch control
		double pitchTrim = 0.0;
		double fcs_pitch_controller_force_command(double longStickInput, double pitchTrim, double dt)
		{
			double longStickInputForce = 0.0;
			if(longStickInput > 0.0)
			{
				longStickInputForce = longStickInput * 80.0 + pitchTrim;
			}
			else
			{
				longStickInputForce = longStickInput * 180.0;
			}
			longStickInputForce = limit(longStickInputForce,-180.0,80.0);
			longStickForce = longStickInputForce;

			double longStickCommand_G = 0.0;
			if(abs(longStickInputForce) <=  8.0)
			{
				longStickCommand_G = 0.0;
			}
			else if((longStickInputForce < -8) && (longStickInputForce > -33.0))
			{
				longStickCommand_G = (0.016 * longStickInputForce) + 0.128;
			}
			else if(longStickInputForce <= -33.0)
			{
				longStickCommand_G = (0.067 * longStickInputForce) + 1.8112;
			}
			else if((longStickInputForce > 8.0) && (longStickInputForce < 33.0))
			{
				longStickCommand_G = (0.032 * longStickInputForce) - 0.256;
			}
			else if(longStickInputForce >= 33.0)
			{
				longStickCommand_G = 0.0681*longStickInputForce - 1.4468;
			}

			double longStickCommandWithTrim_G = pitchTrim - longStickCommand_G;

			double longStickCommandWithTrimLimited_G = limit(longStickCommandWithTrim_G, -4.0, 8.0);

			double longStickCommandWithTrimLimited_G_Rate = 4.0 * (longStickCommandWithTrimLimited_G - stickCommandPosFiltered);
			stickCommandPosFiltered += (longStickCommandWithTrimLimited_G_Rate * dt);

			return stickCommandPosFiltered;
		}

		// Schedule gain component due to dynamic pressure
		double dynamic_pressure_schedule(double dynPressure_LBFT2)
		{
			double dynamicPressure_kNM2 = dynPressure_LBFT2 * 1.4881639/1000.0; //for kN/m^2
			double scheduleOutput = 0.0;

			if(dynamicPressure_kNM2 < 9.576)
			{
				scheduleOutput = 1.0;
			}
			else if((dynamicPressure_kNM2 >= 9.576) && (dynamicPressure_kNM2 <= 43.0))
			{
				scheduleOutput =  (-0.018 * dynamicPressure_kNM2) + 1.1719;
				//scheduleOutput =  (-0.0239 * dynamicPressure_kNM2) + 1.2292;
			}
			else if(dynamicPressure_kNM2 > 43.0)
			{
				scheduleOutput = -0.003 * dynamicPressure_kNM2 + 0.5277;
				//scheduleOutput = -0.001 * dynamicPressure_kNM2 + 0.2422;
			}

			scheduleOutput = limit(scheduleOutput,0.5,1.0);

			return scheduleOutput;
		}

		double fcs_pitch_limiter(double stickcommand, double pitchTrim, double aoa, double Nz, double airspeed) {
			double aoaPLimit = 10;
			double aoaNLimit = -3;
			double aoaP_PGain = 0.1;
			double aoaN_PGain = 0.1;
			double NzPLimit = 6;
			double NzNLimit = -0.5;
			double NzP_PGain = 0.1;
			double NzN_PGain = 0.5;

			PrevFinalStickCommand = FinalStickCommand;

			if (airspeed > 150) {
				stickcommand = limit(stickcommand / pow(airspeed/150,2), -1, 1);
			}

			NzP_PGain = limit(NzP_PGain / (airspeed / 150), 0, NzP_PGain);
			NzN_PGain = limit(NzN_PGain / (airspeed / 150), 0, NzN_PGain);

			

			//fprintf(stderr, "stickcommand: %f   ", stickcommand);

			if (airspeed <= 150) {
				fprintf(stderr, "Airspeed <= 200  ");
				//FinalStickCommand = stickcommand;
				if (aoa <= aoaPLimit && aoa >= aoaNLimit)
				{
					//fprintf(stderr, "aoa <= aoaPLimit && aoa >= aoaNLimit  ");
					FinalStickCommand = stickcommand;
				} else if (aoa > aoaPLimit) {
					//fprintf(stderr, "aoa > aoaPLimit  ");
					FinalStickCommand = stickcommand + aoaP_PGain * (aoa - aoaPLimit);
				} else if (aoa < aoaNLimit) {
					//fprintf(stderr, "aoa < aoaNLimit  ");
					FinalStickCommand = stickcommand - aoaN_PGain * (aoaNLimit - aoa);
				}
			}
			else {
				//fprintf(stderr, "Airspeed > 200  ");
				
				//FinalStickCommand = stickcommand;
				if (Nz <= NzPLimit && Nz >= NzNLimit)
				{
					//fprintf(stderr, "Nz <= NzPLimit && Nz >= NzNLimit  ");
					FinalStickCommand = stickcommand;
				} else if (Nz > NzPLimit) {
					//fprintf(stderr, "Nz > NzPLimit  ");
					FinalStickCommand = stickcommand + NzP_PGain * (Nz - NzPLimit);
				} else if (Nz < NzNLimit) {
					//fprintf(stderr, "Nz < NzNLimit  ");
					FinalStickCommand = stickcommand - NzN_PGain * (NzNLimit - Nz);
				}
			}
			

			FinalStickCommand = limit(FinalStickCommand + pitchTrim, -1, 1);
			//fprintf(stderr, "FinalStickCommand: %f\n", FinalStickCommand);
			return FinalStickCommand;

		}

		// Controller for pitch
		double fcs_pitch_controller(double longStickInput, double pitchTrim, double elevatorPosition_Limits[], double angle_of_attack_ind, double g_force, double ind_airspeed, double dt)
		{
			if (!(simInitialized)) {
				stickCommandPos = 0;
				PitchCommand_DEG = 0;
			}
			


			stickCommandPos = longStickInput;

			stickCommandPos = fcs_pitch_limiter(stickCommandPos, pitchTrim, angle_of_attack_ind, g_force, ind_airspeed);


			if (stickCommandPos >= 0) {
				PitchCommand_DEG = stickCommandPos * abs(elevatorPosition_Limits[1]);
			}
			else {
				PitchCommand_DEG = stickCommandPos * abs(elevatorPosition_Limits[0]);
			}
			
			PitchCommand_DEG = limit(PitchCommand_DEG, elevatorPosition_Limits[0], elevatorPosition_Limits[1]);

			return PitchCommand_DEG;
		}

		// Controller for roll
		double fcs_roll_controller(double latStickInput, double longStickForce, double ay, double roll_rate, double roll_rate_trim,double dynPressure_LBFT2, double dt)
		{
			/*
			if (!(simInitialized))
			{
				double numerators[2] = {0.0,60.0};
				double denominators[2] = {1.0,60.0};
				latStickForceFilter.InitFilter(numerators,denominators,1,dt);

				double numerators1[2] = {0.0,10.0};
				double denominators1[2] = {1.0,10.0};
				rollCommandFilter.InitFilter(numerators1,denominators1,1,dt);

				double numerators2[3] = { 0.0, 0.0, pow(52.0,2.0)};
				double denomiantors2[3] = { 1.0, 2.0*0.7*52.0, pow(52.0,2.0)};
				rollActuatorDynamicsFilter.InitFilter(numerators2,denomiantors2,2,dt);

				double numerators3[2] = {0.0,50.0};
				double denominators3[2] = {1.0,50.0};
				rollRateFilter1.InitFilter(numerators3,denominators3,1,dt);

				double numerators4[3] = { 4.0, 64.0, 6400.0};
				double denomiantors4[3] = { 1.0, 80.0, 6400.0};
				rollRateFilter2.InitFilter(numerators4,denomiantors4,2,dt);
			}

			double latStickForceCmd = latStickInput * 75.0;
			double latStickForce = latStickForceFilter.Filter(!(simInitialized),dt,latStickForceCmd);

			double latStickForceBiased = latStickForce - (ay * 8.9);  // CJS: remove side acceleration bias?

			double longStickForceGained = longStickForce * 0.0667;
			double rollFeelGain = 0.0;
			if(abs(longStickForce) > 25.0)
			{
				rollFeelGain = 0.7;
			}
			else if(longStickForce >= 0.0)
			{
				rollFeelGain = -0.012 * longStickForceGained + 1.0;
			}
			else if(longStickForce < 0.0)
			{
				rollFeelGain = 0.012 * longStickForceGained + 1.0;
			}

			double latStickForceFinal = latStickForceBiased * rollFeelGain;

			double rollRateCommand = 0.0;
			if(abs(latStickForceFinal) < 3.0)
			{
				rollRateCommand = 0.0;
			}
			else if((latStickForceFinal >= 3.0) && (latStickForceFinal <= 25.0))
			{
				rollRateCommand = 0.9091 * latStickForceFinal - 2.7273;
			}
			else if((latStickForceFinal > 25.0) && (latStickForceFinal <= 46.0))
			{
				rollRateCommand = 2.8571 * latStickForceFinal - 51.429;
			}
			else if((latStickForceFinal > 46.0))
			{
				rollRateCommand = 7.5862 * latStickForceFinal - 268.97;
			}
			else if((latStickForceFinal <= -3.0) && (latStickForceFinal >= -25.0))
			{
				rollRateCommand = 0.9091 * latStickForceFinal + 2.7273;
			}
			else if((latStickForceFinal < -25.0) && (latStickForceFinal >= -46.0))
			{
				rollRateCommand = 2.8571 * latStickForceFinal + 51.429;
			}
			else if((latStickForceFinal < -46.0))
			{
				rollRateCommand = 7.5862 * latStickForceFinal + 268.97;
			}

			double rollRateCommandFilterd = rollCommandFilter.Filter(!(simInitialized),dt,rollRateCommand);

			double rollRateFiltered1 = rollRateFilter1.Filter(!(simInitialized),dt,roll_rate);

			double rollRateFiltered2 = (rollRateFilter2.Filter(!(simInitialized),dt,rollRateFiltered1));

			double rollRateCommandCombined = rollRateFiltered2 - rollRateCommandFilterd - roll_rate_trim;

			double dynamicPressure_NM2 = dynPressure_LBFT2 * 47.880258889;

			double pressureGain = 0.0;
			if(dynamicPressure_NM2 < 19153.0)
			{
				pressureGain = 0.2;
			}
			else if((dynamicPressure_NM2 >= 19153.0) && (dynamicPressure_NM2 <= 23941.0))
			{
				pressureGain = -0.00002089 * dynamicPressure_NM2 + 0.6;
			}
			else
			{
				pressureGain = 0.1;
			}
			
			double rollCommandGained = limit(rollRateCommandCombined * pressureGain, -21.5, 21.5);
			*/
			// Mechanical servo dynamics
			double rollRange = 25.0;
			
			double rollActuatorCommand = -latStickInput * rollRange; //= rollActuatorDynamicsFilter.Filter(!(simInitialized),dt,rollCommandGained);	
			return rollActuatorCommand;
		}		

		// Passive flap schedule for the F-16...nominal for now from flight manual comments
		double fcs_flap_controller(double airspeed_FPS)
		{
			double airspeed_KTS = 0.5924838012958964 * airspeed_FPS;
			double trailing_edge_flap_deflection = 0.0;

			if(airspeed_KTS < 240.0)
			{
				trailing_edge_flap_deflection = 20.0;
			}
			else if((airspeed_KTS >= 240.0) && (airspeed_KTS <= 370.0))
			{
				trailing_edge_flap_deflection = (1.0 - ((airspeed_KTS - 240.0)/(370.0-240.0))) * 20.0;
			}
			else
			{
				trailing_edge_flap_deflection = (1.0 - ((airspeed_KTS - 240.0)/(370.0-240.0))) * 20.0;
			}

			trailing_edge_flap_deflection = limit(trailing_edge_flap_deflection,0.0,20.0);

			return trailing_edge_flap_deflection;
		}
	}
}
#endif