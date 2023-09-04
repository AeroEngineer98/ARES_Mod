shape_name   	   = "ARES_Cockpit"
is_EDM			   = true
new_model_format   = true
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}
-- fc3_cockpit_draw_args = true
-- ed_fm_set_fc3_cockpit_draw_args_v2
--use_external_shape=true
local ft_to_meter = 0.3048



dusk_border					 = 0.4
draw_pilot					 = false

external_model_canopy_arg	 = 38

--use_external_views = true -- Must be set to false or removed for HUD collimation to work

day_texture_set_value   = 0.0
night_texture_set_value = 0.1



local controllers = LoRegisterPanelControls()
local RADIANS_TO_DEGREES = 57.2958




-- Throttle Lever
ThrottleLever					= CreateGauge("parameter")
ThrottleLever.arg_number		= 5
ThrottleLever.input				= {0, 100}
ThrottleLever.output			= {-1, 1}
ThrottleLever.parameter_name	= "THROTTLE_AXIS_POS"


-- Gear Handle
GearHandle						= CreateGauge("parameter")
GearHandle.arg_number			= 8
GearHandle.input				= {0, 1}
GearHandle.output				= {0, 1}
GearHandle.parameter_name		= "GEAR_HANDLE_POS"


-- Splaps Lever
SplapsLever						= CreateGauge("parameter")
SplapsLever.arg_number			= 9
SplapsLever.input				= {0, 1}
SplapsLever.output				= {0, 1}
SplapsLever.parameter_name		= "SPLAPS_HANDLE_POS"



-- FDAI
Roll_FDAI						= CreateGauge("parameter")
Roll_FDAI.arg_number			= 32
Roll_FDAI.input					= {-180, 180}
Roll_FDAI.output				= {-1, 1}
Roll_FDAI.parameter_name		= "ROLL_DEG_FDAI"

Pitch_FDAI						= CreateGauge("parameter")
Pitch_FDAI.arg_number			= 31
Pitch_FDAI.input				= {-90, 90}
Pitch_FDAI.output				= {1, -1}
Pitch_FDAI.parameter_name		= "PITCH_DEG_FDAI"

Heading_FDAI					= CreateGauge("parameter")
Heading_FDAI.arg_number			= 30
Heading_FDAI.input				= {0, 360}
Heading_FDAI.output				= {-1, 1}
Heading_FDAI.parameter_name		= "HEADING_DEG_FDAI"


-- Airspeed Indicator
Airspeed_Ind					= CreateGauge("parameter")
Airspeed_Ind.arg_number			= 48
Airspeed_Ind.input				= {0, 600}
Airspeed_Ind.output				= {-1, 1}
Airspeed_Ind.parameter_name		= "AIRSPEED_IND"

Mach_Ind						= CreateGauge("parameter")
Mach_Ind.arg_number				= 49
Mach_Ind.input					= {0, 1.2}
Mach_Ind.output					= {-1, 1}
Mach_Ind.parameter_name			= "MACH_NUM"


-- Alpha/AoA Indicator
Alpha_Ind						= CreateGauge("parameter")
Alpha_Ind.arg_number			= 53
Alpha_Ind.input					= {-2, 20}
Alpha_Ind.output				= {-1, 1}
Alpha_Ind.parameter_name		= "AOA_DEG"


-- Altimeter
Altitude_Ones					= CreateGauge("parameter")
Altitude_Ones.arg_number		= 40
Altitude_Ones.input				= {0, 1000}
Altitude_Ones.output			= {-1, 1}
Altitude_Ones.parameter_name	= "ALTITUDE_FT_ONES"

Altitude_Thou					= CreateGauge("parameter")
Altitude_Thou.arg_number		= 41
Altitude_Thou.input				= {0, 10000}
Altitude_Thou.output			= {-1, 1}
Altitude_Thou.parameter_name	= "ALTITUDE_FT_THOU"

Altitude_Tens					= CreateGauge("parameter")
Altitude_Tens.arg_number		= 42
Altitude_Tens.input				= {0, 100000}
Altitude_Tens.output			= {-1, 1}
Altitude_Tens.parameter_name	= "ALTITUDE_FT_TENS"


-- G Meter
Nz_Gee							= CreateGauge("parameter")
Nz_Gee.arg_number				= 51
Nz_Gee.input					= {-4, 10}
Nz_Gee.output					= {-1, 1}
Nz_Gee.parameter_name			= "NZ_GEE"


-- Vertical Speed Indicator
VSI_gauge						= CreateGauge("parameter")
VSI_gauge.arg_number			= 46
VSI_gauge.input					= {-6000, 6000}
VSI_gauge.output				= {-1, 1}
VSI_gauge.parameter_name		= "VERT_SPEED"


-- Engine N1 and N2 Gauges
N1_gauge						= CreateGauge("parameter")
N1_gauge.arg_number				= 67
N1_gauge.input					= {0, 110}
N1_gauge.output					= {-1, 1}
N1_gauge.parameter_name			= "FM_ENG_N1"

N2_gauge						= CreateGauge("parameter")
N2_gauge.arg_number				= 69
N2_gauge.input					= {0, 110}
N2_gauge.output					= {-1, 1}
N2_gauge.parameter_name			= "FM_ENG_N2"


-- Heading Indicator
Heading_Ind						= CreateGauge("parameter")
Heading_Ind.arg_number			= 55
Heading_Ind.input				= {0, 360}
Heading_Ind.output				= {-1, 1}
Heading_Ind.parameter_name		= "HEADING_DEG_FDAI"


-- Gear Lamps
NGLamp							= CreateGauge("parameter")
NGLamp.arg_number				= 100
NGLamp.input					= {-1, 1}
NGLamp.output					= {-1, 1}
NGLamp.parameter_name			= "GEAR_N_LAMP"

MLLamp							= CreateGauge("parameter")
MLLamp.arg_number				= 101
MLLamp.input					= {-1, 1}
MLLamp.output					= {-1, 1}
MLLamp.parameter_name			= "GEAR_ML_LAMP"

MRLamp							= CreateGauge("parameter")
MRLamp.arg_number				= 102
MRLamp.input					= {-1, 1}
MRLamp.output					= {-1, 1}
MRLamp.parameter_name			= "GEAR_MR_LAMP"

Gear_U_Lamp						= CreateGauge("parameter")
Gear_U_Lamp.arg_number			= 103
Gear_U_Lamp.input				= {-1, 1}
Gear_U_Lamp.output				= {-1, 1}
Gear_U_Lamp.parameter_name		= "GEAR_U_LAMP"

NGLamp_Day						= CreateGauge("parameter")
NGLamp_Day.arg_number			= 104
NGLamp_Day.input				= {-1, 1}
NGLamp_Day.output				= {-1, 1}
NGLamp_Day.parameter_name		= "GEAR_N_LAMP_DAY"

MLLamp_Day						= CreateGauge("parameter")
MLLamp_Day.arg_number			= 105
MLLamp_Day.input				= {-1, 1}
MLLamp_Day.output				= {-1, 1}
MLLamp_Day.parameter_name		= "GEAR_ML_LAMP_DAY"

MRLamp_Day						= CreateGauge("parameter")
MRLamp_Day.arg_number			= 106
MRLamp_Day.input				= {-1, 1}
MRLamp_Day.output				= {-1, 1}
MRLamp_Day.parameter_name		= "GEAR_MR_LAMP_DAY"

Gear_U_Lamp_Day					= CreateGauge("parameter")
Gear_U_Lamp_Day.arg_number		= 107
Gear_U_Lamp_Day.input			= {-1, 1}
Gear_U_Lamp_Day.output			= {-1, 1}
Gear_U_Lamp_Day.parameter_name	= "GEAR_U_LAMP_DAY"


-- Warning Lights
Canopy_Lamp						= CreateGauge("parameter")
Canopy_Lamp.arg_number			= 200
Canopy_Lamp.input				= {-1, 1}
Canopy_Lamp.output				= {-1, 1}
Canopy_Lamp.parameter_name		= "Canopy_Ind"

Bingo_Lamp						= CreateGauge("parameter")
Bingo_Lamp.arg_number			= 201
Bingo_Lamp.input				= {-1, 1}
Bingo_Lamp.output				= {-1, 1}
Bingo_Lamp.parameter_name		= "Bingo_Ind"

Hydro_Lamp						= CreateGauge("parameter")
Hydro_Lamp.arg_number			= 202
Hydro_Lamp.input				= {-1, 1}
Hydro_Lamp.output				= {-1, 1}
Hydro_Lamp.parameter_name		= "Hyd_Press_Ind"

Generator_Lamp					= CreateGauge("parameter")
Generator_Lamp.arg_number		= 203
Generator_Lamp.input			= {-1, 1}
Generator_Lamp.output			= {-1, 1}
Generator_Lamp.parameter_name	= "Generator_Ind"

L_Fuel_Lamp						= CreateGauge("parameter")
L_Fuel_Lamp.arg_number			= 204
L_Fuel_Lamp.input				= {-1, 1}
L_Fuel_Lamp.output				= {-1, 1}
L_Fuel_Lamp.parameter_name		= "L_Fuel_Low_Ind"

R_Fuel_Lamp						= CreateGauge("parameter")
R_Fuel_Lamp.arg_number			= 205
R_Fuel_Lamp.input				= {-1, 1}
R_Fuel_Lamp.output				= {-1, 1}
R_Fuel_Lamp.parameter_name		= "R_Fuel_Low_Ind"

Motive_Lamp						= CreateGauge("parameter")
Motive_Lamp.arg_number			= 206
Motive_Lamp.input				= {-1, 1}
Motive_Lamp.output				= {-1, 1}
Motive_Lamp.parameter_name		= "Motive_Ind"

Oil_Temp_Lamp					= CreateGauge("parameter")
Oil_Temp_Lamp.arg_number		= 207
Oil_Temp_Lamp.input				= {-1, 1}
Oil_Temp_Lamp.output			= {-1, 1}
Oil_Temp_Lamp.parameter_name	= "Oil_Temp_Ind"

Oil_Press_Lamp					= CreateGauge("parameter")
Oil_Press_Lamp.arg_number		= 208
Oil_Press_Lamp.input			= {-1, 1}
Oil_Press_Lamp.output			= {-1, 1}
Oil_Press_Lamp.parameter_name	= "Oil_Pressure_Ind"

Batt_Low_Lamp					= CreateGauge("parameter")
Batt_Low_Lamp.arg_number		= 209
Batt_Low_Lamp.input				= {-1, 1}
Batt_Low_Lamp.output			= {-1, 1}
Batt_Low_Lamp.parameter_name	= "Batt_Ind"

Chemtrail_Lamp					= CreateGauge("parameter")
Chemtrail_Lamp.arg_number		= 210
Chemtrail_Lamp.input			= {-1, 1}
Chemtrail_Lamp.output			= {-1, 1}
Chemtrail_Lamp.parameter_name	= "Chem_Ind"

Splaps_Lamp						= CreateGauge("parameter")
Splaps_Lamp.arg_number			= 211
Splaps_Lamp.input				= {-1, 1}
Splaps_Lamp.output				= {-1, 1}
Splaps_Lamp.parameter_name		= "Splaps_Ind"

Autopilot_Lamp					= CreateGauge("parameter")
Autopilot_Lamp.arg_number		= 212
Autopilot_Lamp.input			= {-1, 1}
Autopilot_Lamp.output			= {-1, 1}
Autopilot_Lamp.parameter_name	= "Autopilot_Ind"

Hook_Lamp						= CreateGauge("parameter")
Hook_Lamp.arg_number			= 213
Hook_Lamp.input					= {-1, 1}
Hook_Lamp.output				= {-1, 1}
Hook_Lamp.parameter_name		= "Hook_Ind"


-- Cockpit Switches
MasterWarn						= CreateGauge("parameter")
MasterWarn.arg_number			= 81
MasterWarn.input				= {-1, 1}
MasterWarn.output				= {-1, 1}
MasterWarn.parameter_name		= "MasterWarn_Sw"

MasterWarn_Lamp					= CreateGauge("parameter")
MasterWarn_Lamp.arg_number		= 82
MasterWarn_Lamp.input			= {-1, 1}
MasterWarn_Lamp.output			= {-1, 1}
MasterWarn_Lamp.parameter_name	= "MasterWarn_Ind"

EngineFire						= CreateGauge("parameter")
EngineFire.arg_number			= 83
EngineFire.input				= {-1, 1}
EngineFire.output				= {-1, 1}
EngineFire.parameter_name		= "EngineFire_Sw"

EngineFire_Lamp					= CreateGauge("parameter")
EngineFire_Lamp.arg_number		= 84
EngineFire_Lamp.input			= {-1, 1}
EngineFire_Lamp.output			= {-1, 1}
EngineFire_Lamp.parameter_name	= "EngineFire_Ind"

DayNightDimmer					= CreateGauge("parameter")
DayNightDimmer.arg_number		= 300
DayNightDimmer.input			= {0, 1}
DayNightDimmer.output			= {0, 1}
DayNightDimmer.parameter_name	= "DIMMER_DAY"

Guns_Amount_Ones				= CreateGauge("parameter")
Guns_Amount_Ones.arg_number		= 94
Guns_Amount_Ones.input			= {0, 10}
Guns_Amount_Ones.output			= {1, 0}
Guns_Amount_Ones.parameter_name	= "GUN_AMT_ONES"

Guns_Amount_Tens				= CreateGauge("parameter")
Guns_Amount_Tens.arg_number		= 95
Guns_Amount_Tens.input			= {0, 10}
Guns_Amount_Tens.output			= {1, 0}
Guns_Amount_Tens.parameter_name	= "GUN_AMT_TENS"

Guns_Amount_Hund				= CreateGauge("parameter")
Guns_Amount_Hund.arg_number		= 96
Guns_Amount_Hund.input			= {0, 10}
Guns_Amount_Hund.output			= {1, 0}
Guns_Amount_Hund.parameter_name	= "GUN_AMT_HUND"

Guns_Amount_Thou				= CreateGauge("parameter")
Guns_Amount_Thou.arg_number		= 97
Guns_Amount_Thou.input			= {0, 10}
Guns_Amount_Thou.output			= {1, 0}
Guns_Amount_Thou.parameter_name	= "GUN_AMT_THOU"




need_to_be_closed = true -- close lua state after initialization





--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[[ available functions

 --base_gauge_RadarAltitude
 --base_gauge_BarometricAltitude
 --base_gauge_AngleOfAttack
 --base_gauge_AngleOfSlide
 --base_gauge_VerticalVelocity
 --base_gauge_TrueAirSpeed
 --base_gauge_IndicatedAirSpeed
 --base_gauge_MachNumber
 --base_gauge_VerticalAcceleration --Ny
 --base_gauge_HorizontalAcceleration --Nx
 --base_gauge_LateralAcceleration --Nz
 --base_gauge_RateOfRoll
 --base_gauge_RateOfYaw
 --base_gauge_RateOfPitch
 --base_gauge_Roll
 --base_gauge_MagneticHeading
 --base_gauge_Pitch
 --base_gauge_Heading
 --base_gauge_EngineLeftFuelConsumption
 --base_gauge_EngineRightFuelConsumption
 --base_gauge_EngineLeftTemperatureBeforeTurbine
 --base_gauge_EngineRightTemperatureBeforeTurbine
 --base_gauge_EngineLeftRPM
 --base_gauge_EngineRightRPM
 --base_gauge_WOW_RightMainLandingGear
 --base_gauge_WOW_LeftMainLandingGear
 --base_gauge_WOW_NoseLandingGear
 --base_gauge_RightMainLandingGearDown
 --base_gauge_LeftMainLandingGearDown
 --base_gauge_NoseLandingGearDown
 --base_gauge_RightMainLandingGearUp
 --base_gauge_LeftMainLandingGearUp
 --base_gauge_NoseLandingGearUp
 --base_gauge_LandingGearHandlePos
 --base_gauge_StickRollPosition
 --base_gauge_StickPitchPosition
 --base_gauge_RudderPosition
 --base_gauge_ThrottleLeftPosition
 --base_gauge_ThrottleRightPosition
 --base_gauge_HelicopterCollective
 --base_gauge_HelicopterCorrection
 --base_gauge_CanopyPos
 --base_gauge_CanopyState
 --base_gauge_FlapsRetracted
 --base_gauge_SpeedBrakePos
 --base_gauge_FlapsPos
 --base_gauge_TotalFuelWeight




/* protected: virtual void __cdecl cockpit::ccMainPanel::register_gauge_controllers(struct lua_State * __ptr64,int) __ptr64 */

void __thiscall cockpit::ccMainPanel::register_gauge_controllers(ccMainPanel *this,lua_State *param_1,int param_2)

{
                    /* 0x1b8e20  4479  ?register_gauge_controllers@ccMainPanel@cockpit@@MEAAXPEAUlua_State@@H@Z */
  lua_pushstring(param_1,"day_night_texture_switcher");
  lua_pushlightuserdata(param_1,&l_day_night_texture_switcher);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"mirrors_draw");
  lua_pushlightuserdata(param_1,l_mirrors_draw);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"pilot_draw");
  lua_pushlightuserdata(param_1,&_pilot_draw);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"Panel_Shake_Y");
  lua_pushlightuserdata(param_1,&l_Panel_Shake_Y);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"Panel_Shake_Z");
  lua_pushlightuserdata(param_1,l_Panel_Shake_Z);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"Panel_Rot_X");
  lua_pushlightuserdata(param_1,&l_Panel_Rot_X);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"head_shift_X");
  lua_pushlightuserdata(param_1,&l_head_shift_X);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"head_shift_Y");
  lua_pushlightuserdata(param_1,&l_head_shift_Y);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"head_shift_Z");
  lua_pushlightuserdata(param_1,&l_head_shift_Z);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"canopy");
  lua_pushlightuserdata(param_1,l_canopy);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RadarAltitude");
  lua_pushlightuserdata(param_1,l_base_gauge_RadarAltitude);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_BarometricAltitude");
  lua_pushlightuserdata(param_1,l_base_gauge_BarometricAltitude);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_AngleOfAttack");
  lua_pushlightuserdata(param_1,&l_base_gauge_AngleOfAttack);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_AngleOfSlide");
  lua_pushlightuserdata(param_1,FUN_1801b3a10);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_VerticalVelocity");
  lua_pushlightuserdata(param_1,FUN_1801b4c70);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_TrueAirSpeed");
  lua_pushlightuserdata(param_1,FUN_1801b4b90);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_IndicatedAirSpeed");
  lua_pushlightuserdata(param_1,FUN_1801b4110);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_MachNumber");
  lua_pushlightuserdata(param_1,FUN_1801b4340);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_VerticalAcceleration");
  lua_pushlightuserdata(param_1,FUN_1801b4c00);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_HorizontalAcceleration");
  lua_pushlightuserdata(param_1,FUN_1801b40a0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_LateralAcceleration");
  lua_pushlightuserdata(param_1,FUN_1801b41f0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RateOfRoll");
  lua_pushlightuserdata(param_1,FUN_1801b4650);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RateOfYaw");
  lua_pushlightuserdata(param_1,FUN_1801b46c0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RateOfPitch");
  lua_pushlightuserdata(param_1,FUN_1801b45e0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_Roll");
  lua_pushlightuserdata(param_1,FUN_1801b4810);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_MagneticHeading");
  lua_pushlightuserdata(param_1,FUN_1801b43b0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_Pitch");
  lua_pushlightuserdata(param_1,FUN_1801b4500);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_Heading");
  lua_pushlightuserdata(param_1,FUN_1801b3f50);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_EngineLeftFuelConsumption");
  lua_pushlightuserdata(param_1,FUN_1801b3bd0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_EngineRightFuelConsumption");
  lua_pushlightuserdata(param_1,FUN_1801b3d20);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_EngineLeftTemperatureBeforeTurbine");
  lua_pushlightuserdata(param_1,FUN_1801b3cb0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_EngineRightTemperatureBeforeTurbine");
  lua_pushlightuserdata(param_1,FUN_1801b3e00);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_EngineLeftRPM");
  lua_pushlightuserdata(param_1,FUN_1801b3c40);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_EngineRightRPM");
  lua_pushlightuserdata(param_1,FUN_1801b3d90);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_WOW_RightMainLandingGear");
  lua_pushlightuserdata(param_1,FUN_1801b4dc0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_WOW_LeftMainLandingGear");
  lua_pushlightuserdata(param_1,FUN_1801b4ce0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_WOW_NoseLandingGear");
  lua_pushlightuserdata(param_1,FUN_1801b4d50);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RightMainLandingGearDown");
  lua_pushlightuserdata(param_1,FUN_1801b4730);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_LeftMainLandingGearDown");
  lua_pushlightuserdata(param_1,FUN_1801b4260);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_NoseLandingGearDown");
  lua_pushlightuserdata(param_1,FUN_1801b4420);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RightMainLandingGearUp");
  lua_pushlightuserdata(param_1,FUN_1801b47a0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_LeftMainLandingGearUp");
  lua_pushlightuserdata(param_1,FUN_1801b42d0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_NoseLandingGearUp");
  lua_pushlightuserdata(param_1,FUN_1801b4490);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_LandingGearHandlePos");
  lua_pushlightuserdata(param_1,FUN_1801b4180);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_StickRollPosition");
  lua_pushlightuserdata(param_1,FUN_1801b49d0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_StickPitchPosition");
  lua_pushlightuserdata(param_1,FUN_1801b4960);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_RudderPosition");
  lua_pushlightuserdata(param_1,FUN_1801b4880);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_ThrottleLeftPosition");
  lua_pushlightuserdata(param_1,FUN_1801b4a40);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_ThrottleRightPosition");
  lua_pushlightuserdata(param_1,FUN_1801b4ab0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_HelicopterCollective");
  lua_pushlightuserdata(param_1,FUN_1801b3fc0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_HelicopterCorrection");
  lua_pushlightuserdata(param_1,FUN_1801b4030);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_CanopyPos");
  lua_pushlightuserdata(param_1,l_canopy);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_CanopyState");
  lua_pushlightuserdata(param_1,FUN_1801b3b60);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_FlapsRetracted");
  lua_pushlightuserdata(param_1,FUN_1801b3ee0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_SpeedBrakePos");
  lua_pushlightuserdata(param_1,FUN_1801b48f0);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_FlapsPos");
  lua_pushlightuserdata(param_1,FUN_1801b3e70);
  lua_settable(param_1,param_2);
  lua_pushstring(param_1,"base_gauge_TotalFuelWeight");
  lua_pushlightuserdata(param_1,FUN_1801b4b20);
  lua_settable(param_1,param_2);
  return;
}

--]]
