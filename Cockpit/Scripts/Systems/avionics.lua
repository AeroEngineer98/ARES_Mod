dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus


local avionics_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.01
local sensor_data = get_base_data()
local efm_data_bus = get_efm_data_bus()

make_default_activity(update_time_step)

function update()
	
	efm_data_bus.fm_setTrueAirspeed
	efm_data_bus.fm_setTrueAltitude


end
