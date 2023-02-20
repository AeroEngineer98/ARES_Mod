--dofile(LockOn_Options.script_path.."Systems/HUD/Units.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus

Deg_to_MR = 17.4533
Deg_to_R = 0.0174533

HUDPitchScale = 30/45

local dev 	    = GetSelf()

-- Parameters from EFM
local FM_Roll = get_param_handle("ROLL_DEG_FDAI")
local FM_Pitch = get_param_handle("PITCH_DEG_FDAI")
local FM_Hdg = get_param_handle("HEADING_DEG_FDAI")
local FM_airspeed_KIAS = get_param_handle("AIRSPEED_IND")
local FM_altitude_tens = get_param_handle("ALTITUDE_FT_TENS")
local FM_AOA = get_param_handle("AOA_DEG")
local FM_AOS = get_param_handle("BETA_DEG")


-- Parameters for HUD
local HUD_Roll = get_param_handle("ROLL_HUD")
local HUD_H_Shift = get_param_handle("H_SHIFT_HUD")
local HUD_V_Shift = get_param_handle("V_SHIFT_HUD")
local HUD_Hdg = get_param_handle("HEADING_DEG_HUD")
local HUD_Airspeed = get_param_handle("AIRSPEED_KIAS_HUD")
local HUD_Altitude = get_param_handle("ALTITUDE_FT_HUD")
local HUD_AOA = get_param_handle("AOA_HUD")
local HUD_AOS = get_param_handle("AOS_HUD")


local sensor_data = get_base_data()

local update_time_step = 0.02
make_default_activity(update_time_step)
--update will be called 50 times per second



local HUD_AOA_Limit = 8 -- In Deg
local HUD_AOS_Limit = 6 -- In Deg


function post_initialize()

	--current_PITCH:set(sensor_data.getPitch())
	--current_ROLL:set(sensor_data.getRoll())
end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end


function updateAttitude()
	local HUD_Roll_value = FM_Roll:get() * Deg_to_R
	local Pitch_value = FM_Pitch:get() * Deg_to_R * HUDPitchScale
	
	local HUD_V_Shift_value = Pitch_value * math.cos(HUD_Roll_value)
	local HUD_H_Shift_value = Pitch_value * math.sin(HUD_Roll_value)
	
	--print_message_to_user(HUD_Roll_value)

	HUD_Roll:set(HUD_Roll_value)
	HUD_V_Shift:set(HUD_V_Shift_value)
	HUD_H_Shift:set(HUD_H_Shift_value)	
end

function updateNumbers()
	local HUD_KIAS_value = FM_airspeed_KIAS:get()
	local HUD_ALT_value = FM_altitude_tens:get()
	


	HUD_Airspeed:set(HUD_KIAS_value)
	HUD_Altitude:set(HUD_ALT_value)

end


function updateFPM()
	local HUD_AOA_value = -1 * FM_AOA:get()
	local HUD_AOS_value = FM_AOS:get()
	
	-- Limit AoA in HUD
	if HUD_AOA_value <= -HUD_AOA_Limit then
		HUD_AOA_value = -HUD_AOA_Limit
	elseif HUD_AOA_value >= HUD_AOA_Limit then
		HUD_AOA_value = HUD_AOA_Limit
	end
	
	-- Limit AoS in HUD
	if HUD_AOS_value <= -HUD_AOS_Limit then
		HUD_AOS_value = -HUD_AOS_Limit
	elseif HUD_AOS_value >= HUD_AOS_Limit then
		HUD_AOS_value = HUD_AOS_Limit
	end
	
	HUD_AOA_value = HUD_AOA_value * Deg_to_R * HUDPitchScale
	HUD_AOS_value = HUD_AOS_value * Deg_to_R
	
	--print_message_to_user(HUD_AOA_value/Deg_to_R)

	
	HUD_AOA:set(HUD_AOA_value)
	HUD_AOS:set(HUD_AOS_value)
	
	--return HUD_AOS_value

end


function update()
	efm_data_bus = updateEFM_Data_Bus()

	updateFPM()
	updateAttitude(sideslip)
	updateNumbers()
	

end

need_to_be_closed = false -- close lua state after initialization
