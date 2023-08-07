#ifndef __PlaneFMCOCKPITIO__
#define __PlaneFMCOCKPITIO__

#include "../stdafx.h"
#include <stdio.h>
#include <string>
#include <math.h>
#include "../UtilityFunctions.h"

namespace PlaneFM
{
	namespace COCKPITIO
	{
		bool		simInitialized = false;

		bool Dimmer_SW = 1;
		bool Master_Arm = 0;
		bool Master_Warn = 0;
		bool Engine_Fire = 0;

		
	}
}
#endif