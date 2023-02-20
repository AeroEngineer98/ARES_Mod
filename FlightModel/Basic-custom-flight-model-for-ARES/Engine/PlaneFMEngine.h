#include "../stdafx.h"


double limitedThrottleInput = 0;

double PLA_array[] = { //Power lever angle
	0,
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
	0,
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

double N2_array[] = {
	0,
	49.4,
	53.5,
	57.5,
	61.6,
	65.7,
	69.7,
	73.8,
	77.9,
	81.9,
	86.0,
	90.1,
	94.1,
	98.2 };

double N1_array[] = {
	0,
	22.9,
	29.5,
	36.0,
	42.6,
	49.1,
	55.7,
	62.2,
	68.8,
	75.4,
	81.9,
	88.5,
	95.0,
	101.6 };

double input_array[] = {
	0,
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
		double N1 = 0;
		double N2 = 0;


		
		double Get_N2(double throttleInput, double frameTime, double engineCutoff)
		{	
			double N2_rate = 1;

			if (!engineCutoff) {
				throttleInput = limit(throttleInput, 100 / 13, 100);
			}
			else {
				throttleInput = 0; //limit(throttleInput, 0, 100);
			}
			
			double N2_table_val = lerp(input_array, N2_array, sizeof(N2_array) / sizeof(double), throttleInput);

			N2 += (N2_table_val - N2) * N2_rate * frameTime;

			return N2;
		}

		double Get_N1(double N2, double frameTime, double engineCutoff)
		{	
			double N1_rate = 2;

			if (!engineCutoff) {
				N2 = limit(N2, 100 / 13, 100);
			}
			else {
				N2 = 0; //limit(throttleInput, 0, 100);
			}

			double N1_table_val = lerp(N2_array, N1_array, sizeof(N1_array) / sizeof(double), N2);

			N1 += (N1_table_val - N1) * N1_rate * frameTime;

			if (N1 > 99.5 && N2 == 100) {
				N1 = 100;
			}
			else if (N1 < 0.05 && N2 == 0) {
				N1 = 0;
			}

			return N1;
		}


		double engine_dynamics(double N1, double mach, double alt, double frameTime, double engineCutoff)
		{
			double thrust_lb = lerp(N1_array, thrust_array, sizeof(thrust_array) / sizeof(double), N1);
			double thrust = thrust_lb * 4.4482189159;	// convert lb to N

			thrust = limit(thrust, 0.0, 150000.0)/ (1 + engine_damage * 100);

			return thrust;
		}
	}
}
