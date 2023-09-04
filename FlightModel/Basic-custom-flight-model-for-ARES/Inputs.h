#pragma once
// Used in ed_fm_set_command() 
enum InputCommands
{
	//------ - Keys from command_defs.lua(4000 - 5999) ---- -//

	//Test Keys

	// Default Commands
	iCommandPlaneFire = 4084, //iCommandPlaneFire = FireBurst without burst limit
	iCommandPlaneFireOff = 4085, //iCommandPlaneFireOff = Stop Burst

	// Gear Keys(150 - 159)
	GeartoggleKey = 4150,
	WheelBrakeOnKey = 4074, //151, iCommandPlaneWheelBrakeOn = 74
	WheelBrakeOffKey = 4075, //152, iCommandPlaneWheelBrakeOff = 75

	//Splaps Keys(160 - 164)
	PlaneAirBrakeKey = 4160,
	PlaneAirBrakeOnKey = 4161,
	PlaneAirBrakeOffKey = 4162,

	//Hook Keys(165 - 169)
	TailHookKey = 4165,

	//Flight Controls Keys(170 - 179)
	ResetTrimKey = 4170,
	TrimUpKey = 4171,
	TrimDownKey = 4172,
	TrimLeftKey = 4173,
	TrimRightKey = 4174,
	RuddertrimLeftKey = 4175,
	RuddertrimRightKey = 4176,

	//Electrical System Keys(180 - 199)


	//Weapons System Keys(200 - 219)
	PlaneFireOn = 4200,
	PlaneFireOff = 4201,
	PickleOn = 4202,
	PickleOff = 4203,
	MasterArmKey = 4204, //Toggles MasterArm
	GunEnableKey = 4205,
	SelectPylon1Key = 4206,
	SelectPylon2Key = 4207,
	SelectPylon3Key = 4208,
	SelectPylon4Key = 4209,
	AAModeKey = 4210,
	AGModeKey = 4211,
	ChemtrailKey = 4212,
	SWCoolKey = 4213,
	BombArmKey = 4214,
	TimingMultKey = 4215,
	StoresReleaseModeKey = 4216,
	StoresReleaseTimerKey = 4217,
	MSLVolumeKey = 4218,


	//Engine System Keys(220 - 229)
	EngineStartKey = 4220,
	Engine_StopKey = 4221,
	EngineIgnitorKey = 4222,








	// ----- Axes from command_defs.lua (2000-2999) ----- //
	JoystickPitch = 2001,
	JoystickRoll = 2002,
	JoystickYaw = 2003,
	JoystickThrottle = 2004,






	// ----- Commands from command_defs.lua (3000-) ----- //

	// Test Commands
	Button_Test = 3000, 

	// Gear Commands (3001 - 3009)
	GearHandle = 3001,
	Emer_gear_release = 3002,
	EmerParkBrake = 3003,
	Wheelbrake_AXIS = 3004,
	Left_wheelbrake_AXIS = 3005,
	Right_wheelbrake_AXIS = 3006,


	// Splaps Commands (3010 - 3014)
	PlaneAirBrake = 3010,


	// Hook Commands (3015 - 3019)
	TailHook = 3015,


	// Flight Controls Commands  (3020 - 3029)


	// Electrical System Commands  (3030 - 3049)
	Warning_Press = 3030,
	EngineFire_Press = 3031,



	// Weapons System Commands (3050 - 3069)
	MasterArm = 3050,
	WpnSelect = 3051,
	JettSelect = 3052,
	GunArm = 3053,
	SelectPylon1 = 3054,
	SelectPylon2 = 3055,
	SelectPylon3 = 3056,
	SelectPylon4 = 3057,
	Chemtrail = 3058,
	SWCool = 3059,
	BombArm = 3060,
	TimingMult = 3061,
	StoresReleaseMode = 3062,
	StoresReleaseTimer = 3063,
	MSLVolume = 3064,


	// Engine System Commands (3070 - 3079)
	EngineStart = 3070,
	EngineIgnition = 3071,
	ThrottleAxis = 3072, 
	ThrottleClick = 3073,


	// ECS Commands (3080 - 3089)


	// Interior Lighting Commands (3090 - 3099)
	Dimmer_Day = 3090,


	// Comms Commands (3100 - 3119)
	pilot_salute = 3100,



	// Misc Commands (3120 - )
	clock_stopwatch = 3120,


};