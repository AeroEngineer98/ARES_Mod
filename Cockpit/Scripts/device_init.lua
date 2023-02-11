dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")


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
--creators[devices.HUD]             	= {"avLuaDevice"           ,LockOn_Options.script_path.."Systems/hud.lua"}


--indicators                  = {}
--indicators[#indicators + 1] = {"ccIndicator", LockOn_Options.script_path.."HUD/Indicator/HUD_page_init.lua" , devices.HUD ,	{ {"PTR-HUD-CENTER", "PTR-HUD-DOWN", "PTR-HUD-RIGHT"},{},2},2}




---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
