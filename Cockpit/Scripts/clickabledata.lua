dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local gettext = require("i_18n")
_ = gettext.translate


elements = {}

--elements["PNT_05"] = default_movable_axis("Throttle Axis", devices.THROTTLE_QUAD, device_commands.throttle_axis, 5, 0, {-1,1})
elements["PNT_08"] = default_2_position_tumb("Landing Gear", devices.GEAR, device_commands.Gear, 8)
elements["PNT_09"] = default_2_position_tumb("Splaps Axis", devices.THROTTLE_QUAD, device_commands.speedbrake, 9)

elements["PNT_200"] = default_2_position_tumb("Indicators Day/Night", devices.AVIONICS, device_commands.Dimmer_Day, 200)
