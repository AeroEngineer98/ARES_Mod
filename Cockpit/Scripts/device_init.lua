--mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
--dofile(LockOn_Options.script_path.."avRadar_example/radarexample_device_init.lua")

layoutGeometry = {}

MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua", {},}

-- Avionics devices initialization example
--	items in <...> are optional
--
-- creators[DEVICE_ID] = {"NAME_OF_CONTROLLER_CLASS",
--						  <"CONTROLLER_SCRIPT_FILE",>
--						  <{devices.LINKED_DEVICE1, devices.LINKED_DEVICE2, ...},>
--						  <"INPUT_COMMANDS_SCRIPT_FILE",>
--						  <{{"NAME_OF_INDICATOR_CLASS", "INDICATOR_SCRIPT_FILE"}, ...}>
--						 }
creators                          	= {}
creators[devices.ELECTRIC_SYSTEM] 	= {"avSimpleElectricSystem",LockOn_Options.script_path.."Systems/electric_system.lua"}
creators[devices.AVIONICS] 			= {"avLuaDevice",LockOn_Options.script_path.."Systems/avionics.lua"}
creators[devices.GEAR] 				= {"avLuaDevice",LockOn_Options.script_path.."Systems/gear.lua"}
creators[devices.THROTTLE_QUAD] 	= {"avLuaDevice",LockOn_Options.script_path.."Systems/throttle_quad.lua"}
creators[devices.WEAPON_SYSTEM]   	= {"avSimpleWeaponSystem"  ,LockOn_Options.script_path.."Systems/weapon_system.lua"}
creators[devices.HUD]             	= {"avLuaDevice"           ,LockOn_Options.script_path.."Systems/hud.lua"}

--tmp_tpl = {sz_I = 0.0, sx_I = 1.0, sy_I = 0.0, rz_I = 0.0, ry_I =0.0}

indicators                  = {}
indicators[#indicators + 1] = 	{
										"ccIndicator",
										
										LockOn_Options.script_path.."Systems/HUD/Indicator/init.lua",
										devices.HUD,
									--	devices.avionics,
										{	
											{"PNT_HUD_CENTER"},
											{
											sz_l = 0,sx_l = 0, sy_l =  0 --sz_l = 0.0,sx_l = -0.50, sy_l =  -0.07  -- Z, X, Y = right/left, fwd/aft, up/down
											},
											1
										}
									}

---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
