#include "../stdafx.h"


double PLA_array[] = { //Power lever angle
	20.4,
	24.7,
	30.5,
	32.5,
	38.7,
	43.9,
	48.9,
	55.1,
	60.2,
	67.6,
	72.8,
	83.6,
	85.2 };

double thrust_array[] = { // Thrust at 0 alt
	466,
	1028,
	2753,
	3079,
	4537,
	5498,
	6302,
	7426,
	8478,
	9732,
	11049,
	12626,
	12696 };

double input_array[] = {
	1 * 100 / 13,
	2 * 100 / 13,
	3 * 100 / 13,
	4 * 100 / 13,
	5 * 100 / 13,
	6 * 100 / 13,
	7 * 100 / 13,
	8 * 100 / 13,
	9 * 100 / 13,
	10 * 100 / 13,
	11 * 100 / 13,
	12 * 100 / 13,
	13 * 100 / 13 };


namespace PlaneFM
{
	// Coded from the simulator study document
	namespace ENGINE
	{	
		double percentPower = 0.0;
		double power3 = 0;
		double dt;
		double throttlePosition = 0;
		double throttlePositionLastTime = 0;
		double engine_damage;
		double fuel; 


		
	
		double engine_dynamics(double throttleInput, double mach, double alt, double frameTime)
		{

			double thrust_lb = lerp(input_array, thrust_array, sizeof(thrust_array) / sizeof(double), throttleInput);
			double thrust = thrust_lb * 4.4482189159;	// convert lb to N

			/*
			if (throttleInput < 90.0)
			{
				percentPower = throttleInput * 0.6923;
			}
			else
			{
				percentPower = throttleInput * 4.5455 - 354.55;
			}

				EDPARAM cockpitAPI;

				percentPower = limit(percentPower, 0.0, 100.0);
				double power1 = percentPower;
				double power2 = 0.0;
				double power3rate = 0.0;

				//if(!(PlaneFM::simInitialized))
				//{
				//	power3 = power1;
				//}
				if (power1 < 50.0)
				{
					if (power3 < 50.0)
					{
						power2 = power1;
						if ((power2 - power3) < 40.0)
						{
							power3rate = 1.0 * (power2 - power3);
						}
						else
						{
							power3rate = 0.1 * (power2 - power3);
						}
					}
					else
					{
						power2 = 40.0;
						power3rate = 5.0 * (power2 - power3);
					}
				}
				else
				{
					if (power3 < 50.0)
					{
						power2 = 60.0;
						if ((power2 - power3) < 40.0)
						{
							power3rate = 1.0 * (power2 - power3);
						}
						else
						{
							power3rate = 0.1 * (power2 - power3);
						}
					}
					else
					{
						power2 = power1;
						power3rate = 5.0 * (power2 - power3);
					}
				}

				power3 += (power3rate * frameTime);
				power3 = limit(power3, 0.0, 100.0);

				//From Simulator Study document (use 0 altitude values for now)
				//TODO: This should really be a look-up table per the document reference but this is sufficient for now...
				double machLimited = limit(mach, 0.2, 1.0);
				double Tidle = (-24976.0 * machLimited + 9091.5) + ((alt / 55000) * 12000.0);
				double Tmil = (-25958.0 * pow(machLimited, 3.0) + 34336.0 * pow(machLimited, 2.0) - 14575.0 * machLimited + 58137.0) + ((alt / 50000.0) * -42000.0);
				double Tmax = (26702.0 * pow(machLimited, 2.0) + 8661.4 * machLimited + 92756.0) + ((alt / 50000.0) * -100000.0);

				double thrust = 0.0;
				if (power3 < 50.0)
				{
					thrust = Tidle + (Tmil - Tidle) * (power3 / 50.0);
				}
				else
				{
					thrust = Tmil + (Tmax - Tmil) * (power3 - 50.0) / 50.0;
				}
				//thrust = limit(thrust, 0.0, 129000.0);
				*/

				thrust = limit(thrust, 0.0, 150000.0)/ (1 + engine_damage * 100);

				return thrust;
		}
	}
}
