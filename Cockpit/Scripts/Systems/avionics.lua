dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus


local avionics_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.01
--sensor_data = get_base_data()
efm_data_bus = get_efm_data_bus()

make_default_activity(update_time_step)

local dimmerDaySw_command = 0

local FM_Nz_Gee = get_param_handle("FM_NZ_GEE")
local Nz_Gee = get_param_handle("NZ_GEE")
local FM_VSI_handle = get_param_handle("FM_VERT_SPEED")
local VSI_handle = get_param_handle("VERT_SPEED")

local dimmer = get_param_handle("DIMMER")
local dimmerDaySw = get_param_handle("DIMMER_DAY")



local Dimmer_Day_Night = device_commands.Dimmer_Day

dev:listen_command(Dimmer_Day_Night)



function post_initialize()
	dimmerDaySw:set(0)
end


function SetCommand(command, value)

end

function updateGauges()
	Nz_Gee_value = FM_Nz_Gee:get()
	Nz_Gee:set(Nz_Gee_value+1)
	
	FM_VSI_handle_value = FM_VSI_handle:get()
	VSI_handle:set(FM_VSI_handle_value*196.85)
end

function updateSwitches()
	local dimmerDaySw_command = efm_data_bus.fm_get_Dimmer_SW	
	
	dimmerDaySw:set(dimmerDaySw_command)

end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end



function update()
	efm_data_bus = updateEFM_Data_Bus()
	
	
	updateGauges()
	updateSwitches()
	
	--[[
	--FDAI
	efm_data_bus.fm_setRoll_deg
	efm_data_bus.fm_setPitch_deg
	efm_data_bus.fm_setHeading_deg
	
	--Airspeed
	efm_data_bus.fm_setIndAirspeed
	efm_data_bus.fm_setMach
	
	--Altimeter
	efm_data_bus.fm_setAltitudeOnes
	efm_data_bus.fm_setAltitudeThou
	efm_data_bus.fm_setAltitudeTens
	]]--

end
