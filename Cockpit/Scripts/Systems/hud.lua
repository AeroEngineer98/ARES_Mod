--dofile(LockOn_Options.script_path.."Systems/HUD/Units.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus

Deg_to_MR = 17.4533
Deg_to_R = 0.0174533

local dev 	    = GetSelf()

-- Parameters from EFM
local FM_Roll = get_param_handle("ROLL_DEG_FDAI")
local FM_Pitch = get_param_handle("PITCH_DEG_FDAI")
local FM_Hdg = get_param_handle("HEADING_DEG_FDAI")


-- Parameters for HUD
local HUD_Roll = get_param_handle("ROLL_HUD")
local HUD_H_Shift = get_param_handle("H_SHIFT_HUD")
local HUD_V_Shift = get_param_handle("V_SHIFT_HUD")
local HUD_Hdg = get_param_handle("HEADING_DEG_HUD")


local sensor_data = get_base_data()

local update_time_step = 0.02
make_default_activity(update_time_step)
--update will be called 50 times per second


function post_initialize()

	--current_PITCH:set(sensor_data.getPitch())
	--current_ROLL:set(sensor_data.getRoll())
end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end


function updateAttitude()
	local HUD_Roll_value = FM_Roll:get() * Deg_to_R
	local Pitch_value = FM_Pitch:get() * Deg_to_R * 30/45
	
	local HUD_V_Shift_value = Pitch_value * math.cos(HUD_Roll_value)
	local HUD_H_Shift_value = Pitch_value * math.sin(HUD_Roll_value)
	
	--print_message_to_user(HUD_Roll_value)

	HUD_Roll:set(HUD_Roll_value)
	HUD_V_Shift:set(HUD_V_Shift_value)
	HUD_H_Shift:set(HUD_H_Shift_value)
	
	
	
end


function update()
	efm_data_bus = updateEFM_Data_Bus()

	updateAttitude()
	--current_PITCH:set(sensor_data.getPitch())
	--current_ROLL:set(sensor_data.getRoll())
end

need_to_be_closed = false -- close lua state after initialization
