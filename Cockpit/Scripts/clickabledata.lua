dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local gettext = require("i_18n")
_ = gettext.translate


elements = {}

--elements["PNT_05"] = default_movable_axis("Throttle Axis", devices.THROTTLE_QUAD, device_commands.throttle_axis, 5, 0, {-1,1})
elements["PNT_08"] = default_2_position_tumb("Landing Gear", devices.GEAR, device_commands.GearHandle, 8)
elements["PNT_09"] = default_2_position_tumb("Splaps Axis", devices.THROTTLE_QUAD, device_commands.PlaneAirBrake, 9)

elements["PNT_79"] = default_2_position_tumb("Master Arm", devices.WEAPON_SYSTEM, device_commands.MasterArm, 79)
elements["PNT_81"] = default_button("Master Warning Silence", devices.ELECTRIC_SYSTEM, device_commands.Warning_Press, 81)
elements["PNT_83"] = default_button("Engine Fire Suppression", devices.ELECTRIC_SYSTEM, device_commands.EngineFire_Press, 83)
elements["PNT_86"] = multiposition_switch("Weapons Select", devices.WEAPON_SYSTEM, device_commands.WpnSelect, 86, 3, 0.5, false, 0, 5)
elements["PNT_87"] = multiposition_switch("Jettison Select", devices.WEAPON_SYSTEM, device_commands.JettSelect, 87, 6, 0.2, false, 0, 5)
elements["PNT_89"] = default_2_position_tumb("Gun Arm", devices.WEAPON_SYSTEM, device_commands.GunArm, 89, 5)
elements["PNT_90"] = default_2_position_tumb("Left Outboard Pylon Arm", devices.WEAPON_SYSTEM, device_commands.SelectPylon1, 90, 5)
elements["PNT_91"] = default_2_position_tumb("Left Inboard Pylon Arm", devices.WEAPON_SYSTEM, device_commands.SelectPylon2, 91, 5)
elements["PNT_92"] = default_2_position_tumb("Right Inboard Pylon Arm", devices.WEAPON_SYSTEM, device_commands.SelectPylon3, 92, 5)
elements["PNT_93"] = default_2_position_tumb("Right Outboard Pylon Arm", devices.WEAPON_SYSTEM, device_commands.SelectPylon4, 93, 5)


elements["PNT_120"] = default_2_position_tumb("Chemtrail ON/OFF", devices.WEAPON_SYSTEM, device_commands.Chemtrail, 120, 5)
elements["PNT_121"] = default_2_position_tumb("Sidewinder Cool ON/OFF", devices.WEAPON_SYSTEM, device_commands.SWCool, 121, 5)
elements["PNT_122"] = default_2_position_tumb("Bomb Fusing Mode", devices.WEAPON_SYSTEM, device_commands.BombArm, 122, 5)
elements["PNT_123"] = default_2_position_tumb("Release Interval Multiplier", devices.WEAPON_SYSTEM, device_commands.TimingMult, 123, 5)
elements["PNT_124"] = multiposition_switch("Stores Release Mode", devices.WEAPON_SYSTEM, device_commands.StoresReleaseMode, 124, 3, 0.5, false, 0, 5)
elements["PNT_125"] = default_axis("Stores Release Interval", devices.WEAPON_SYSTEM, device_commands.StoresReleaseTimer, 125, 0, 1)



elements["PNT_300"] = default_2_position_tumb("Indicators Day/Night", devices.AVIONICS, device_commands.Dimmer_Day, 200)
