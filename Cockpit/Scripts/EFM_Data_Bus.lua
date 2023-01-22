
local fm_airspeed_true = get_param_handle("TAS_knots")
local fm_altitude_true = get_param_handle("ALTITUDE_FT_TRUE")

function fm_setTrueAirspeed(value)
    return fm_airspeed_true:set(value)
end

function fm_setTrueAltitude(value)
    return fm_altitude_true:set(value)
end




function get_efm_data_bus()
    local efm_data_bus = {}
	
	efm_data_bus.fm_setTrueAirspeed = fm_setTrueAirspeed
	efm_data_bus.fm_setTrueAltitude = fm_setTrueAltitude

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