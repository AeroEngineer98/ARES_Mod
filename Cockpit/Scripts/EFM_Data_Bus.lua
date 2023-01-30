
-- FDAI Handles
local fm_FDAI_roll = get_param_handle("ROLL_DEG_FDAI")
local fm_FDAI_pitch = get_param_handle("PITCH_DEG_FDAI")
local fm_FDAI_hdg = get_param_handle("HEADING_DEG_FDAI")

-- Airspeed Indicator Handles
local fm_airspeed_ind = get_param_handle("AIRSPEED_IND")
local fm_mach = get_param_handle("MACH_NUM")

local fm_altitude_ones = get_param_handle("ALTITUDE_FT_ONES")
local fm_altitude_thou = get_param_handle("ALTITUDE_FT_THOU")
local fm_altitude_tens = get_param_handle("ALTITUDE_FT_TENS")


-- FDAI Functions
function fm_setRoll_deg(value)
    return fm_FDAI_roll:set(value)
end

function fm_setPitch_deg(value)
    return fm_FDAI_pitch:set(value)
end

function fm_setHeading_deg(value)
    return fm_FDAI_hdg:set(value)
end


-- Airspeed Indicator Functions
function fm_setIndAirspeed(value)
    return fm_airspeed_ind:set(value)
end

function fm_setMach(value)
    return fm_mach:set(value)
end


-- Altimeter Functions
function fm_setAltitudeOnes(value)
    return fm_altitude_ones:set(value)
end

function fm_setAltitudeThou(value)
    return fm_altitude_thou:set(value)
end

function fm_setAltitudeTens(value)
    return fm_altitude_tens:set(value)
end




function get_efm_data_bus()
    local efm_data_bus = {}
	
	--FDAI
	efm_data_bus.fm_setRoll_deg = fm_setRoll_deg
	efm_data_bus.fm_setPitch_deg = fm_setPitch_deg
	efm_data_bus.fm_setHeading_deg = fm_setHeading_deg
	
	--Airspeed
	efm_data_bus.fm_setIndAirspeed = fm_setIndAirspeed
	efm_data_bus.fm_setMach = fm_setMach
	
	--Altimeter
	efm_data_bus.fm_setAltitudeOnes = fm_setAltitudeOnes
	efm_data_bus.fm_setAltitudeThou = fm_setAltitudeThou
	efm_data_bus.fm_setAltitudeTens = fm_setAltitudeTens

    return efm_data_bus
   
end

--[[
local EFM_enabled = true

function get_efm_sensor_data_overrides()
    --Get the original data
    local data = get_base_data()

    if EFM_enabled then
        data.getEngineLeftRPM = fm_getEngineRPM
        data.getEngineLeftFuelConsumption = fm_getFuelFlow
        data.getThrottleLeftPosition = fm_getThrottle
        data.getTrueAirSpeed = fm_getAirspeed
        data.getAngleOfSlide = fm_getBeta
        data.getAngleOfAttack = fm_getAOA
        data.getIndicatedAirSpeed = fm_getCalibratedAirSpeed
    end

    return data
end


]]--