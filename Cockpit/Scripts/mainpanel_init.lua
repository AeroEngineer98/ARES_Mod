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
-- use_external_shape=flase
local ft_to_meter = 0.3048


dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")

dusk_border					 = 0.4
draw_pilot					 = false

external_model_canopy_arg	 = 38

use_external_views = true

day_texture_set_value   = 0.0
night_texture_set_value = 0.1



local controllers = LoRegisterPanelControls()
local RADIANS_TO_DEGREES = 57.2958








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
