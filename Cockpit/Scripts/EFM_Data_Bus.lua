
-- Throttle and Splaps Axes
local fm_Throttle_Axis = get_param_handle("FM_THROTTLE_AXIS_POS")
local fm_Splaps_Axis = get_param_handle("FM_SPLAPS_AXIS_POS")


-- FDAI Handles
local fm_FDAI_roll = get_param_handle("ROLL_DEG_FDAI")
local fm_FDAI_pitch = get_param_handle("PITCH_DEG_FDAI")
local fm_FDAI_hdg = get_param_handle("HEADING_DEG_FDAI")

-- Airspeed Indicator Handles
local fm_airspeed_ind = get_param_handle("AIRSPEED_IND")
local fm_mach = get_param_handle("MACH_NUM")

-- Altimeter Handles
local fm_altitude_ones = get_param_handle("ALTITUDE_FT_ONES")
local fm_altitude_thou = get_param_handle("ALTITUDE_FT_THOU")
local fm_altitude_tens = get_param_handle("ALTITUDE_FT_TENS")

-- G-Meter Handle
local Nz_Gee = get_param_handle("NZ_GEE")

-- Vertical Speed Indicator Handle
local VSI = get_param_handle("FM_VERT_SPEED")

-- Gear Indicator Handles
local fm_NGLamp = get_param_handle("FM_GEAR_N_LAMP")
local fm_MLLamp = get_param_handle("FM_GEAR_ML_LAMP")
local fm_MRLamp = get_param_handle("FM_GEAR_MR_LAMP")
local fm_ULamp = get_param_handle("FM_GEAR_U_LAMP")
local fm_GearCommand = get_param_handle("FM_GEAR_COMMAND")


--Warning Indicator Handles
--local fm_Splaps_Lamp = get_param_handle("FM_Airbrake_Ind")


-- Switches
local fm_DimmerSw = get_param_handle("FM_DIMMER_SW")
local fm_MasterArmSw = get_param_handle("FM_MASTER_ARM_SW")
local fm_MasterWarnSw = get_param_handle("FM_WARN_SW")
local fm_EngFireSw = get_param_handle("FM_ENG_FIRE_SW")
local fm_WPNSelectSw = get_param_handle("FM_WPN_SELECT_SW")



-- ///////// Get Functions /////////

-- Throttle Quadrant Get Functions
function fm_get_Throttle_Axis()
	return fm_Throttle_Axis:get()
end

function fm_get_Splaps_Axis()
	return fm_Splaps_Axis:get()
end


-- Gear Indicator Get Functions
function fm_get_NGLamp()
	return fm_NGLamp:get()
end

function fm_get_MLLamp()
	return fm_MLLamp:get()
end

function fm_get_MRLamp()
	return fm_MRLamp:get()
end

function fm_get_ULamp()
	return fm_ULamp:get()
end

function fm_get_GearCommand()
	return fm_GearCommand:get()
end

-- Airbrake Indicator Get Functions
--function fm_get_SplapsLamp()
--	return fm_Splaps_Lamp:get()
--end


-- Switch Get Functions
function fm_get_Dimmer_SW()
	return fm_DimmerSw:get()
end

function fm_get_MasterArm_SW()
	return fm_MasterArmSw:get()
end

function fm_get_MasterWarn_SW()
	return fm_MasterWarnSw:get()
end

function fm_get_EngFire_SW()
	return fm_EngFireSw:get()
end

function fm_get_WPNSelect_SW()
	return fm_WPNSelectSw:get()
end




function get_efm_data_bus()
    local efm_data_bus = {}
	-- ///// Set Functions /////
	
	
	-- ///// Get Functions /////
	efm_data_bus.fm_get_Throttle_Axis = fm_get_Throttle_Axis()
	efm_data_bus.fm_get_Splaps_Axis = fm_get_Splaps_Axis()
	
	efm_data_bus.fm_get_NGLamp = fm_get_NGLamp()
	efm_data_bus.fm_get_MLLamp = fm_get_MLLamp()
	efm_data_bus.fm_get_MRLamp = fm_get_MRLamp()
	efm_data_bus.fm_get_ULamp = fm_get_ULamp()
	efm_data_bus.fm_get_GearCommand = fm_get_GearCommand()
	
	--efm_data_bus.fm_get_SplapsLamp = fm_get_SplapsLamp()
	
	efm_data_bus.fm_get_Dimmer_SW = fm_get_Dimmer_SW()
	efm_data_bus.fm_get_MasterArm_SW = fm_get_MasterArm_SW()
	efm_data_bus.fm_get_MasterWarn_SW = fm_get_MasterWarn_SW()
	efm_data_bus.fm_get_EngFire_SW = fm_get_EngFire_SW()
	efm_data_bus.fm_get_WPNSelect_SW = fm_get_WPNSelect_SW()

	--print_message_to_user(efm_data_bus.fm_get_NGLamp)
	

    return efm_data_bus
   
end
