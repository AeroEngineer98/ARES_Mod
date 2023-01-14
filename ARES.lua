--mounting 3d model paths and texture paths 

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/ARES.zip")
mount_vfs_texture_path  (current_mod_path.."/Textures/")
mount_vfs_sound_path    (current_mod_path.."/Sounds")

ARES =  {
	Name 				=   'ARES',
	DisplayName			= _('ARES'),
	Cannon 				= "yes",
	HumanCockpit 		= false,
	HumanCockpitPath    = current_mod_path..'/Cockpit/',
	Picture 			= "A-29B.png", 
	Rate 				= 40, -- RewardPoint in Multiplayer
	Shape 				= "ARES",
	debrisGeneration     = true,
	shape_table_data 	= 
	{
		{
			file  	 	= 'ARES'; -- name of edm file
			life  	 	= 20; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'Fighter-2-crush'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'ARES';
			index    	=  WSTYPE_PLACEHOLDER;---------------------------------------------------------------------------------------
            classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		-- no need for this as we are using a built in destroyed model
		-- {
		-- 	name  = "ARES-collision";
		-- 	file  = "ARES-collision";
		-- 	fire  = { 240, 2};
		-- },

	},


	mapclasskey 		= "P0091000025", -- Was P0091000024
	



		
    index       =  WSTYPE_PLACEHOLDER;
	attribute  	= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER , ARES,"Fighters", "Refuelable",},
	Categories	= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
	    M_empty									=	5120,  -- kg
		M_nominal								=	6400,  -- kg  -- kg ~ %50 fuel, combat load
		M_max									=	9930,  -- kg
		M_fuel_max								=   640, -- utilizável 495 --509 + 239 + 249*2 + 231,   -- kg Asas, Fuselage, Subalar, Ventral,
        M_fuel_per_tank 						= 	{320, 320}, -- kg
		H_max									=	10668 , -- m

		average_fuel_consumption 	= 0.302, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
        defFuelRatio    			= 0.68, -- топливо по умолчанию в долях от полного
		CAS_min 					= 53, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
		V_opt 						= 240/1.944,-- Cruise speed (for AI) –- Assume Mach 0.80 at 20000 ft as optimal. See -- http://www.nasa.gov/centers/dryden/pdf/87789main_H-636.pdf and		–- http://www.hochwarth.com/misc/AviationCalculator.html 		–- Mach 0.8 at 20000 = XXX kts TAS = XXX m / s
		V_take_off 					= 120/1.944, -- Take off speed in m/s (for AI)
		V_land 						= 125/1.944, -- Land speed in m/s (for AI)
		V_max_sea_level 			= 320/1.944, -- Max speed at sea level in m/s (for AI)
		V_max_h 					= 210/1.944, -- Max speed at max altitude in m/s (for AI)
		Vy_max 						= 12, -- Max climb speed in m/s (for AI)
		Mach_max 					= 0.562, -- Max speed in Mach (for AI)
		Ny_min 						= -4, -- Min G (for AI)
		Ny_max 						= 8.0,  -- Max G (for AI)
		Ny_max_e 					= 8.0,  -- Max G (for AI)
		AOA_take_off 				= math.rad(9.0), -- AoA in take off (for AI) -- in radians
		bank_angle_max 				= 60, -- Max bank angle (for AI)
	
		has_afteburner 				= false, -- AFB yes/no
		has_speedbrake 				= true, -- Speedbrake yes/no
		has_differential_stabilizer	= false, -- differential stabilizers

		main_gear_pos 				= 	{-0.225224,	-1.58723,	-1.58913}, -- in {Y, Z, X} format??
		nose_gear_pos 				= 	{4.15486,	-1.58895,	0}, 
		tand_gear_max				=	0.57735026919, -- tangent of degrees of rotation max of nose wheel steering

		nose_gear_amortizer_direct_stroke        = 0.00,    -- down from nose_gear_pos !!!
		nose_gear_amortizer_reversal_stroke      = -0.16,   -- up
		nose_gear_amortizer_normal_weight_stroke = -0.06,   
		main_gear_amortizer_direct_stroke        = 0.00,     -- down from main_gear_pos !!!
		main_gear_amortizer_reversal_stroke      = -0.16,   -- up
		main_gear_amortizer_normal_weight_stroke = -0.06,   
	
		nose_gear_wheel_diameter	=	0.547, --in m
		main_gear_wheel_diameter	=	0.643, -- in m
	
	
		-- Need to update with OpenVSP numbers for ARES --
		wing_area 					= 27.1241, -- wing area in m2
		wing_span 					= 14.3121, -- wing span in m
		wing_type 					= 0, -- 0 = fixed wing

		thrust_sum_max 				= 17000, -- thrust in kg (44kN)
		thrust_sum_ab 				= 17000, -- thrust in kg (71kN)
		length 						= 12.5464, -- full length in m
		height 						= 3.7782, -- height in m
		flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
		range 						= 1568, -- Max range in km (for AI)
		RCS 						= 3, -- Radar Cross Section m2
		IR_emission_coeff 			= 0.1, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
		IR_emission_coeff_ab 		= 0.1, -- With afterburner
		wing_tip_pos 				= {-3.0254, -0.0608, -7.1451}, -- wingtip coords for visual effects
		brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
		
		-- The following is used for graphical AB effects
		engines_count				= 1, -- Engines count
		engines_nozzles = 
		{
			[1] = 
			{
				pos 		=  {-4.9564,0.39713,0}, -- nozzle coords
				elevation   =  0, -- AFB cone elevation –- for engines mounted at an angle to fuselage, change elevation
				diameter	 = 0.661, -- AFB cone diameter
				exhaust_length_ab   = 3.0, -- length in m
				exhaust_length_ab_K = 0.3, -- AB animation
				engine_number  = 1, --both to first engine
				smokiness_level     = 	1.0,  --both to first engine
			},
	
			
		
		}, -- end of engines_nozzles
		crew_size	 = 1,
		crew_members = 
		{
				[1] = 
				{	pilot_name            = "pilot_f86",
					ejection_seat_name	=	17,
					drop_canopy_name	=	'A-29B CANOPY', -- Create new canopy object and rename to ARES CANOPY
					pos = 	{0,	0.3,	0}, -- location of your pilot ejecting,
					can_be_playable 	 = true,
					role 				 = "pilot",
					role_display_name    = _("Pilot"),
					ejection_order      = 0,
				}, -- end of [1]
		}, -- end of crew_members
	
		fires_pos = 
		{
			[1] = 	{-2.117,	-0.9,	0},
			[2] = 	{0.500,	0.213,	0},
			[3] = 	{0.500,	0.213,	-2.182},
			[4] = 	{-0.82,	0.265,	2.774},
			[5] = 	{-0.82,	0.265,	-2.774},
			[6] = 	{-0.82,	0.255,	2.7274},
			[7] = 	{-0.82,	0.255,	-2.7274},
			[8] = 	{0.5,	-0.5,	2.7578},
			[9] = 	{0.5,	-0.5,	-2.578},
			[10] = 	{0.50,	0.084,	2.754},
			[11] = 	{0.50,	0.084,	-2.7534},
		}, -- end of fires_pos
	
		detection_range_max		 = 0, --is the max range in kilometers that the radar can see something large (e.g. a bomber, tanker, AWACS, etc.).
		radar_can_see_ground 	 = false, -- ground target identification capability, but this has not been verified

		CanopyGeometry = { -- Mk1 eyeball sensor for visual spotting targets
			azimuth = {-160.0, 160.0}, -- pilot view horizontal (AI)
			elevation = {-40.0, 90.0} -- pilot view vertical (AI)
		},

		Sensors = {
		},

		HumanRadio = {
			frequency     = 124.0, -- onboard radio, default DCSW frequency, chnl 0
			editable     = true,
			minFrequency     = 30.000,
			maxFrequency     = 399.975,
			rangeFrequency = {
				{min = 30.0,  max = 87.975},
				{min = 108.0, max = 173.975},
				{min = 225.0, max = 399.975},
			},
		},
		
		panelRadio = {
			[1] = {
				name = _("AN/ARC-150(V)-2"), --UHF
				range = {
					{min = 225.0, max = 399.975}
				},
				channels = {
					[1] = { name = _("Channel 1"), default = 225.0, modulation = _("AM")}, -- default
					[2] = { name = _("Channel 2"), default = 258.0, modulation = _("AM")},
					[3] = { name = _("Channel 3"), default = 260.0, modulation = _("AM")},
					[4] = { name = _("Channel 4"), default = 270.0, modulation = _("AM")},
					[5] = { name = _("Channel 5"), default = 255.0, modulation = _("AM")},
					[6] = { name = _("Channel 6"), default = 259.0, modulation = _("AM")},
					[7] = { name = _("Channel 7"), default = 262.0, modulation = _("AM")},
					[8] = { name = _("Channel 8"), default = 257.0, modulation = _("AM")},
					[9] = { name = _("Channel 9"), default = 253.0, modulation = _("AM")},
					[10] = { name = _("Channel 10"), default = 263.0, modulation = _("AM")},
					[11] = { name = _("Channel 11"), default = 267.0, modulation = _("AM")},
					[12] = { name = _("Channel 12"), default = 254.0, modulation = _("AM")},
					[13] = { name = _("Channel 13"), default = 264.0, modulation = _("AM")},
					[14] = { name = _("Channel 14"), default = 266.0, modulation = _("AM")},
					[15] = { name = _("Channel 15"), default = 265.0, modulation = _("AM")},
					[16] = { name = _("Channel 16"), default = 252.0, modulation = _("AM")},
					[17] = { name = _("Channel 17"), default = 268.0, modulation = _("AM")},
					[18] = { name = _("Channel 18"), default = 269.0, modulation = _("AM")},
					[19] = { name = _("Channel 19"), default = 268.0, modulation = _("AM")},
					[20] = { name = _("Channel 20"), default = 269.0, modulation = _("AM")},
				}
			},
			[2] = {
				name = _("SRT-651/N"), --VHF/UHF
				range = {{min = 30.0, max = 88.0},
						 {min = 108.0, max = 174.0},
						 {min = 225.0, max = 399.975}},
				channels = {
					[1] = { name = _("Channel 1"), default = 225.0, connect = true}, -- default
					[2] = { name = _("Channel 2"), default = 258.0},
					[3] = { name = _("Channel 3"), default = 260.0},
					[4] = { name = _("Channel 4"), default = 270.0},
					[5] = { name = _("Channel 5"), default = 255.0},
					[6] = { name = _("Channel 6"), default = 259.0},
					[7] = { name = _("Channel 7"), default = 262.0},
					[8] = { name = _("Channel 8"), default = 257.0},
					[9] = { name = _("Channel 9"), default = 253.0},
					[10] = { name = _("Channel 10"), default = 263.0},
					[11] = { name = _("Channel 11"), default = 267.0},
					[12] = { name = _("Channel 12"), default = 254.0},
					[13] = { name = _("Channel 13"), default = 264.0},
					[14] = { name = _("Channel 14"), default = 266.0},
					[15] = { name = _("Channel 15"), default = 265.0},
					[16] = { name = _("Channel 16"), default = 252.0},
					[17] = { name = _("Channel 17"), default = 268.0},
					[18] = { name = _("Channel 18"), default = 269.0},
					[19] = { name = _("Channel 19"), default = 268.0},
					[20] = { name = _("Channel 20"), default = 269.0},
					[21] = { name = _("Channel 21"), default = 225.0},
					[22] = { name = _("Channel 22"), default = 258.0},
					[23] = { name = _("Channel 23"), default = 260.0},
					[24] = { name = _("Channel 24"), default = 270.0},
					[25] = { name = _("Channel 25"), default = 255.0},
					[26] = { name = _("Channel 26"), default = 259.0},
					[27] = { name = _("Channel 27"), default = 262.0},
					[28] = { name = _("Channel 28"), default = 257.0},
					[29] = { name = _("Channel 29"), default = 253.0},
					[30] = { name = _("Channel 30"), default = 263.0},
				}
			},
		},
	
		
		-- Countermeasures
		SingleChargeTotal = 60,
		CMDS_Incrementation = 15,
		ChaffDefault = 30,
		ChaffChargeSize = 1,
		FlareDefault = 15,
		FlareChargeSize = 2,
		CMDS_Edit = false,
		chaff_flare_dispenser = {
			[1] =
			{
				dir = {-1, 0, 0}, -- dispenses to rear
				pos = {-6, 0, -0.8}, -- left rear of fuselage
			}, -- end of [1]
		}, -- end of chaff_flare_dispenser

		Pylons =     {
			pylon(1, 0, -0.814, -0.525, -2.399,
				{
					connector = 'pylon1', arg = 308 ,arg_value = 0,
					use_full_connector_position = false,
				},
				{
					{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, -- AIM-9P
								
					{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk-20 Rockeye
					{ CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, -- Mk-81
					{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
					{ CLSID = "{Mk82SNAKEYE}" }, 						  -- MK82SE
					{ CLSID = "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, -- M-117
					{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU12
					{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU16
					{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97

					{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU68-MK156
					{ CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, -- LAU-61 - 19
	                { CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151 High Explosive *7

					-- { CLSID = "{CBU_105}" ,arg_increment = 0.0}, 		-- CBU-105	
					-- { CLSID	= "AGM114x2_OH_58" }, 						--"AGM-114K * 2"
					-- { CLSID = "{GBU_49}" ,arg_increment = 0.10 }, 		--FRENCH GBU-49

					{ CLSID = "<CLEAN>", arg_value = 1 }, -- CLEAN --
				}
			),
			pylon(2, 0, -0.116, -0.611, -0.749,
				{
					connector = 'pylon2', arg = 309 ,arg_value = 0,
					use_full_connector_position = false,
				},
				{
					{ CLSID = "{A-29B TANK}" },

					{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk-20 Rockeye
					{ CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, -- Mk-81
					{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
					{ CLSID = "{Mk82SNAKEYE}" }, 						  -- MK82SE
					{ CLSID = "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, -- M-117
					{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU12
					{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU16
					{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97

					{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU68-MK156
					{ CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, -- LAU-61 - 19
	                { CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151 High Explosive *7

					-- { CLSID = "{CBU_105}" ,arg_increment = 0.0}, 		-- CBU-105	
					-- { CLSID	= "AGM114x2_OH_58" }, 						--"AGM-114K * 2"
					-- { CLSID = "{GBU_49}" ,arg_increment = 0.10 }, 		--FRENCH GBU-49
	
					{ CLSID = "<CLEAN>", arg_value = 1 }, -- CLEAN --
				}
			),
			pylon(3, 0, -0.116, -0.611, -0.749,
				{
					connector = 'pylon3', arg = 310 ,arg_value = 0,
					use_full_connector_position = false,
				},
				{
					{ CLSID = "{A-29B TANK}" },

					{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk-20 Rockeye
					{ CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, -- Mk-81
					{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
					{ CLSID = "{Mk82SNAKEYE}" }, 						  -- MK82SE
					{ CLSID = "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, -- M-117
					{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU12
					{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU16
					{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97

					{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU68-MK156
					{ CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, -- LAU-61 - 19
	                { CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151 High Explosive *7

					-- { CLSID = "{CBU_105}" ,arg_increment = 0.0}, 		-- CBU-105	
					-- { CLSID	= "AGM114x2_OH_58" }, 						--"AGM-114K * 2"
					-- { CLSID = "{GBU_49}" ,arg_increment = 0.10 }, 		--FRENCH GBU-49
	
					{ CLSID = "<CLEAN>", arg_value = 1 }, -- CLEAN --
				}
			),
			pylon(4, 0, -0.814, -0.525, -2.399,
				{
					connector = 'pylon4', arg = 311 ,arg_value = 0,
					use_full_connector_position = false,
				 },
				{
					{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, -- AIM-9P
								
					{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk-20 Rockeye
					{ CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}" }, -- Mk-81
					{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
					{ CLSID = "{Mk82SNAKEYE}" }, 						  -- MK82SE
					{ CLSID = "{00F5DAC4-0466-4122-998F-B1A298E34113}" }, -- M-117
					{ CLSID = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}" }, -- GBU12
					{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU16
					{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97

					{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU68-MK156
					{ CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}" }, -- LAU-61 - 19
	                { CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151 High Explosive *7

					-- { CLSID = "{CBU_105}" ,arg_increment = 0.0}, 		-- CBU-105	
					-- { CLSID	= "AGM114x2_OH_58" }, 						--"AGM-114K * 2"
					-- { CLSID = "{GBU_49}" ,arg_increment = 0.10 }, 		--FRENCH GBU-49

					{ CLSID = "<CLEAN>", arg_value = 1 }, -- CLEAN --
				}
			),
			pylon(5, 0, 1.664, -0.933, 0.715,
				{
					use_full_connector_position = true,
					connector 		= "SmokeWhite",
				    DisplayName 	= "Smoke",
				 },
				{
				    {CLSID = "{SMOKE-WHITE-A29B}",		    arg_value = 0.2}, -- Smoke pod
				    {CLSID = "{SMOKE-RED-A29B}",		    arg_value = 0.2}, -- Smoke pod
				    {CLSID = "{SMOKE-GREEN-A29B}",		    arg_value = 0.2}, -- Smoke pod
				    {CLSID = "{SMOKE-BLACK-A29B}",		    arg_value = 0.2}, -- Smoke pod
				    {CLSID = "{SMOKE-ORANGE-A29B}",		    arg_value = 0.2}, -- Smoke pod
				    {CLSID = "{SMOKE-YELLOW-A29B}",		    arg_value = 0.2}, -- Smoke pod
				}
			),
	},
	
	Tasks = {
        aircraft_task(CAP),
		aircraft_task(Escort),
      	aircraft_task(FighterSweep),
		aircraft_task(GroundAttack),
		aircraft_task(PinpointStrike),
      	aircraft_task(CAS),
       	aircraft_task(AFAC),
		aircraft_task(RunwayAttack),
		aircraft_task(AntishipStrike),
		aircraft_task(Intercept),
   	},	
	DefaultTask = aircraft_task(Intercept),



	SFM_Data = {
	
		-- F-104T aerodynamics
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0			=	0.17,      -- zero AoA lift coefficient
			Mzalfa		=	1.8,	-- tail pitch coefficient M0.9
			Mzalfadt	=	1.2,	-- wing pitch coefficient M0.9
			
			kjx			=	5,  -- 0.117, aileron control power coefficient / roll damping coefficient
			kjz			=	1, -- 0.0011, -- elevator or stab control power coefficient / pitch damping coefficient
			
			Czbe		=	-0.34,  -- directional stability coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			
			cx_gear		=	0.006,  -- 0.3,    -- coefficient, drag, gear
			cx_flap		=	0.184,   -- coefficient, drag, full flaps
			cy_flap		=	0.37,   -- coefficient, normal force, lift, flaps
			cx_brk		=	0.014,  -- 0.08,   -- coefficient, drag, breaks
			
			table_data  = 
			{	--      M		Cx0		 Cya		B	B4	    Omxmax		Aldop		Cymax
				[1] = 	{0,	    0.008,	0.043,	0.175,	0,		0.5,		15,			1.17},
				[2] = 	{0.2,	0.008,	0.043,	0.175,	0,		3.197,		15,			1.17},
				[3] = 	{0.4,	0.008,	0.064,	0.175,	0,		3.014,		15,			0.935},
				[4] = 	{0.6,	0.043,	0.065,	0.175,	0,		1.910,		15,			0.875},
				[5] = 	{0.7,	0.064,	0.071,	0.175,	0,		2.242,		15,			0.845},
				[6] = 	{0.8,	0.071,	0.072,	0.175,	0,		2.580,		15,			0.865},
				[7] = 	{0.9,	0.080,	0.078,	0.175,	0,		2.923,		15,			0.985},
				[8] = 	{1	,	0.090,	0.089,	0.175,	0,		3.161,		15,			1.185},
				[9] = 	{1.1,	0.083,	0.086,	0.204,	0,		2.937,		15,			1.185},
			}, -- end of table_data
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		}, -- end of aerodynamics	
		
		
		engine = 
		{
			Nmg		=	64.6, -- % RPM at idle
			MinRUD	=	0, -- always 0 in current modeled aircraft -- Min state of the throttle
			MaxRUD	=	1, -- always 1 in current modeled aircraft -- Max state of the throttle
			MaksRUD	=	1, -- .85 for afterburning, 1 for non-afterburning engine. -- Military power state of the throttle
			ForsRUD	=	1, -- .91 for afterburning, 1 for non-afterburning -- Afterburner state of the throttle
			typeng	=	4, -- E_TURBOJET = 0, E_TURBOJET_AB = 1, E_PISTON = 2, E_TURBOPROP = 3,	E_TURBOFAN    = 4,	E_TURBOSHAFT = 5
			hMaxEng	=	19.5, -- maximum operating altitude for the engine in km -- typically higher than service ceiling of the aircraft
			dcx_eng	=	0.095, -- drag coefficient for the engine -- no correlation found -- most common values are 0.0085 and 0.0144
			cemax   = 	0.37, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor   = 	0.37, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1800, --  altitude coefficient for max thrust -- altitude effects to thrust -- The best recommendation at this point is to start with these values between 2000 and 3000 and adjust as needed after initial flight testing
			dpdh_f	=	1800, --  altitude coefficient for AB thrust ???? or altitude effects to fuel rate -- The best recommendation at this point is to start with these values between 2000 and 3000 and adjust as needed after initial flight testing
			Startup_Prework = 1.0,
			Startup_RPMs = {
				{0.0, 0},
				{1.0, 60},
				{8.0, 60},
				{8.6, 880},
				{13.0, 601},
			},
			Startup_Ignition_Time = 8.3,
			Shutdown_Duration = 9.8,

			table_data = {
			-- Pmax - total thrust in Mil Pwr in Newtons for all engines
			-- Pfor - total thrust in AB in Newtons for all engines
			--   M		Pmax		 Pfor
			{0.0,		38227.0,	 38227.0},	-- Made up from F-18 div by 2 - F404 w/out AB
			{0.1,		38991.0,	 38991.0},
			{0.2,		39756.0,	 39756.0},
			{0.3,		40903.0,	 40903.0},
			{0.4,		42814.0,	 42814.0},
			{0.5,		45490.0,	 45490.0},
			{0.6,		48930.0,	 48930.0},
			{0.7,		48548.0,	 48548.0},
			{0.8,		47784.0,	 47784.0},
			{0.9,		47019.0,	 47019.0},
			{1.0,		45872.0,	 45872.0},
			{1.1,		42814.0,	 42814.0}
		}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
           
		}, -- end of engine
		-- thrust_max = -- thrust interpolation table by altitude and mach number, 2d table.  Modified for carrier takeoffs at/around 71 foot deck height
        --         {
        --             M       =   {0, 0.1, 0.225, 0.23, 0.3, 0.5, 0.7, 0.8, 0.9, 1.1},
        --             H       =   {0, 19, 20, 23, 24, 250, 4572, 7620, 10668, 13716, 16764, 19812},
        --             thrust  =  {-- M    0     0.1    0.225   0.23,   0.3    0.5     0.7     0.8     0.9     1.1
        --                         {   41370,  39460,  38060,  38056,  37023,  36653,  36996,  37112,  36813,  34073 },--H = 0 (sea level)
        --                         {   41370,  39460,  38060,  38056,  37023,  36653,  36996,  37112,  36813,  34073 },--H = 19 (~62.3 feet)
        --                         {   41370,  39460,  38060,  38056,  37023,  36653,  36996,  37112,  36813,  34073 },--H = 20 (~66.6 feet)
        --                         {   41370,  39460,  38060,  38056,  37023,  36653,  36996,  37112,  36813,  34073 },--H = 23 (~75.5 feet)
        --                         {   41370,  39460,  38060,  38056,  37023,  36653,  36996,  37112,  36813,  34073 },--H = 24 (~78.7 feet)
        --                         {   41370,  39460,  38060,  38056,  37023,  36653,  36996,  37112,  36813,  34073 },--H = 250 (820 feet)
        --                         {   27254,  25799,  24765,  24761,  24203,  24599,  26227,  27254,  28353,  29785 },--H = 4572 (15kft)
        --                         {   20818,  19203,  18130,  18127,  17548,  17473,  18638,  19608,  20684,  22873 },--H = 7620 (25kft)
        --                         {   10876,  11076,  11128,  11130,  11556,  12193,  13024,  13674,  14434,  16098 },--H = 10668 (35kft)
        --                         {   6025,   6379,    6676,   6680,  6837,   7433,   8194,   8603,   9101,   10075 },--H = 13716 (45kft)
        --                         {   3336,   3554,    3837,   3840,  3990,   4484,   5000,   5307,   5596,   6232  },--H = 16764 (55kft)
        --                         {   1904,   2042,    2296,   2300,  2433,   2798,   3212,   3483,   3639,   4097  },--H = 19812 (65kft)
        --                        },
        --         },
		-- TSFC_afterburner =  -- afterburning thrust specific fuel consumption by altitude and Mach number RPM  100%, 2d table
		-- {
		-- 	M 		 = {0,0.3,0.5,0.7,1.0},
		-- 	H		 = {0,1000,3000,10000},
		-- 	TSFC	 = {-- M 0  0.3 0.5  0.7  1.0
		-- 				{   1,   1,  1,   1,   1},--H = 0
		-- 				{   1,   1,  1,   1,   1},--H = 1000
		-- 				{   1,   1,  1,   1,   1},--H = 3000
		-- 				{   1,   1,  1,   1,   1},--H = 10000
		-- 	}
		-- },
		-- extended =
		-- {
		--   Cx0 = -- Interpolierung von Cx0 bei Geschwindikeit M und HÃ¶he H
		--   {-- minimum Cx0 ist xxx maximum Cx0 ist yyy
		-- 	M       = {0, 0.2, 0.4, 0.6, 0.7, 0.8, 0.9, 1, 1.05, 1.1, 1.2, 1.3, 1.5, 1.7, 1.8, 2, 2.1, 2.2, 3.9},--Machnumber as above
		-- 	H       = {0, 4572, 10668, 13716, 16764}, --HÃ¶he = SeaLevel, 15kft, 35kft, 45kft, 55kft
		-- 	Cdmin   = {--M    0     0.2     0.4     0.6     0.7     0.8     0.9     1       1.05    1.1     1.2     1.3     1.5     1.7     1.8       2      2.1     2.2     3.9
		-- 			   {    0.015,  0.5,    0.04,   0.019, 0.018,  0.015,  0.018,  0.045,   0.048,  0.05,   0.048,  0.047,  0.046,  0.046,  0.046,   0.046,  0.046,  0.046,  0.046,}, --SeaLevel 0
		-- 			   {    0.015,  0.015,  0.1,    0.027, 0.02,   0.019,  0.02,   0.045,   0.048,  0.05,   0.048,  0.047,  0.046,  0.046,  0.046,   0.046,  0.046,  0.046,  0.046,},-- 15kft
		-- 			   {    0.015,  0.015,  0.015,  0.12,  0.08,   0.04,   0.035,  0.05,    0.055,  0.06,   0.065,  0.06,   0.05,   0.04,   0.035,   0.025,  0.02,   0.015,  0.015,},-- 35kft
		-- 			   {    0.015,  0.015,  0.015,  0.015, 0.12,   0.1,    0.07,   0.075,   0.077,  0.08,   0.075,  0.07,   0.055,  0.05,   0.049,   0.0475, 0.045,  0.035,  0.031,},-- 45kft
		-- 			   {    0.015,  0.015,  0.015,  0.015, 0.05,   0.09,   0.11,   0.14,    0.13,   0.12,   0.1,    0.09,   0.07,   0.06,   0.055,   0.05,   0.0475, 0.042,  0.035,},-- 55kft
		-- 			  },
		--   },
		-- }, -- end of Cx0

	},

    AddPropAircraft = {
        {
            id = "SoloFlight",
            control = 'checkbox',
            label = _('Solo Flight'),
            defValue = false,
            weightWhenOn = -80,
            wCtrl = 150,
		},
		{ id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true,
			values = {{id =  0, dispName = _("Pilot")},
					 {id =  1, dispName = _("Instructor")},
					 {id = -1, dispName = _("Ask Always")},
					 {id = -2, dispName = _("Equally Responsible")}},
			defValue  = 1,
			wCtrl     = 150
		},

		{ id = "LGB1000", control = 'spinbox',  label = _('Laser Code 1st Digit'), defValue = 1, min = 1, max = 1, dimension = ' ', playerOnly = true}, -- only for completeness
        { id = "LGB100", control = 'spinbox',  label = _('Laser Code 2nd Digit'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
        { id = "LGB10", control = 'spinbox',  label = _('Laser Code 3rd Digit'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
        { id = "LGB1", control = 'spinbox',  label = _('Laser Code 4th Digit'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},

    },
	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
		[0]		= {critical_damage = 5, args = {146}},
		[3]		= {critical_damage = 20,args = {65}}  ,
		[4]		= {critical_damage = 20, args = {150}},
		[5]		= {critical_damage = 20, args = {147}},
		[7]		= {critical_damage = 4, args = {249}} ,
		[9]		= {critical_damage = 3, args = {154}},
		[10]	= {critical_damage = 3, args = {153}},
		[11]	= {critical_damage = 3, args = {167}},
		[12]	= {critical_damage = 3, args = {161}},
		[15]	= {critical_damage = 5, args = {267}},
		[16]	= {critical_damage = 5, args = {266}},
		[23]	= {critical_damage = 8, args = {223}, deps_cells = {25}},
		[24]	= {critical_damage = 8, args = {213}, deps_cells = {26, 60}},
		[25]	= {critical_damage = 3, args = {226}},
		[26]	= {critical_damage = 3, args = {216}},
		[29]	= {critical_damage = 9, args = {224}, deps_cells = {31, 25, 23}},
		[30]	= {critical_damage = 9, args = {214}, deps_cells = {32, 26, 24, 60}},
		[31]	= {critical_damage = 4, args = {229}},
		[32]	= {critical_damage = 4, args = {219}},
		[35]	= {critical_damage = 10, args = {225}, deps_cells = {29, 31, 25, 23}},
		[36]	= {critical_damage = 10, args = {215}, deps_cells = {30, 32, 26, 24, 60}} ,
		[37]	= {critical_damage = 4, args = {227}},
		[38]	= {critical_damage = 4, args = {217}},
		[39]	= {critical_damage = 7,	args = {244}, deps_cells = {53}},
		[40]	= {critical_damage = 7, args = {241}, deps_cells = {54}},
		[45]	= {critical_damage = 9, args = {235}, deps_cells = {39, 51, 53}},
		[46]	= {critical_damage = 9, args = {233}, deps_cells = {40, 52, 54}},
		[51]	= {critical_damage = 3, args = {239}},
		[52]	= {critical_damage = 3, args = {237}},
		[53]	= {critical_damage = 3, args = {248}},
		[54]	= {critical_damage = 3, args = {247}},
		[55]	= {critical_damage = 20, args = {81}, deps_cells = {39, 40, 45, 46, 51, 52, 53, 54}},
		[59]	= {critical_damage = 5, args = {148}},
		[60]	= {critical_damage = 1, args = {144}},

		[83]	= {critical_damage = 3, args = {134}} ,-- nose wheel
		[84]	= {critical_damage = 3, args = {136}}, -- left wheel
		[85]	= {critical_damage = 3, args = {135}} ,-- right wheel
	},

	DamageParts = 
	{  
		[1] = "A-29B-collision", -- wing R
	},

	Failures = {
		{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},

	lights_data = {
        typename = "collection",
        lights = {
			[WOLALIGHT_STROBES]	= {
				typename	=	"collection",
				lights 		= {
					{ typename = "argnatostrobelight", argument = 83, period = 1.2},		-- beacon lights
				},
			},--must be collection
			[WOLALIGHT_LANDING_LIGHTS]	= {
				typename	= 	"collection",
				lights		= {
					{ typename  = "argumentlight",	argument  = 51, },
				},
			},--must be collection
			[WOLALIGHT_TAXI_LIGHTS]	= {
				typename	= 	"collection",
				lights		= {
					{ typename  = "argumentlight",	argument  = 208, },
				},
			},--must be collection
			[WOLALIGHT_NAVLIGHTS]	= {
				typename 	= "collection",
				lights 		= {
					{ typename  = "argumentlight", argument  = 49, },				-- red
				},
			},--must be collection
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename	= "collection",
				lights		= {
					{ typename  = "argumentlight",	argument  = 88, },
				},		-- green bars
			},--must be collection

			-- STROBE / ANTI-COLLISION
			[WOLALIGHT_BEACONS] = {
				typename = "collection",
				lights = {
					-- 0 -- Anti-collision strobe
					{ typename = "argnatostrobelight", argument = 200, period = 0.4, flash_time = 0.1, },
				},
			},
        }
    },

	stores_number	=	10,

	LandRWCategories = 
        {
            [1] = 
            {
                Name = "AircraftCarrier",
            }, -- end of [1]
        }, -- end of LandRWCategories
		MaxFuelWeight = "15245",
        MaxHeight = "20000",
        MaxSpeed = "3000",
        MaxTakeOffWeight = "41200",
        Picture = "ARES_Loadout.png", -- Picture in loadout menu
        Rate = "30",
        Shape = "ARES", -- EDM File for Plane
        TakeOffRWCategories = 
        {
            [1] = 
            {
                Name = "AircraftCarrier With Catapult",
            }, -- end of [1]
			[2] = 
            {
				Name = "AircraftCarrier With Tramplin",
            }, -- end of [2]
        }, -- end of TakeOffRWCategories
	
	

		Countermeasures = {
			ECM = "AN/ALQ-165"
		},

	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 60,
		chaff = {default = 30, increment = 1, chargeSz = 1},
		flare = {default = 30,  increment = 1, chargeSz = 1},
	},

	chaff_flare_dispenser 	= {
			
		{ dir =  {0, -1, 0}, pos =   {-3.027,  0.35, -0.3}, }, -- Chaff L
		{ dir =  {0, -1, 0}, pos =   {-3.727,  0.35, 0.3}, },  -- Chaff R
	    { dir =  {0, -1,  0}, pos =  {-3.032,  0.35, -0.32}, }, -- Flares L	
		{ dir =  {0, -1,  0}, pos =  {-3.732,  0.35,  0.32}, }, -- Flares R
	},
		

	mapclasskey = "P0091000024",

	Guns = {				-- {Y, Z, X} from Blender
		MG_20({muzzle_pos = {4.228,0.248, 0.699},_connector =  "Point_Gun",rates = {1025},effect_arg_number = 350,mixes = {{1,2,2,3,3}},azimuth_initial = 0.0,elevation_initial = 0,supply_position = {4.5,0.22, 0.3}})-- MITRAIL AVR 1 
	}, -- 3dsmax X, Z, -Y
	
}

add_aircraft(ARES)
	