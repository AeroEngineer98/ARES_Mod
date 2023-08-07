dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus
dofile(LockOn_Options.script_path.."utils.lua")

local throttle_quad_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.01
local efm_data_bus = get_efm_data_bus()

make_default_activity(update_time_step)


local JoystickThrottle  = Axes.JoystickThrottle
local SplapsKey  = Keys.PlaneAirBrakeKey
local SplapsCommand = device_commands.PlaneAirBrake


local Throttle_param = get_param_handle("THROTTLE_AXIS_POS")
local Splaps_param = get_param_handle("SPLAPS_HANDLE_POS")
local dimmerDaySw = get_param_handle("DIMMER_DAY")
local Splaps_Ind_State_param = get_param_handle("Splaps_Ind_State")

--local SPLamp_param = get_param_handle("SP_LAMP")
--local SPLamp_day_param = get_param_handle("SP_LAMP_DAY")


local throttle_lever_pos = efm_data_bus.fm_get_Throttle_Axis 
Throttle_param:set(throttle_lever_pos) -- Set throttle position to whatever the commanded state is at startup

local Splaps_handle_pos = efm_data_bus.fm_get_Splaps_Axis 
Splaps_param:set(Splaps_handle_pos)



dev:listen_command(JoystickThrottle)
dev:listen_command(SplapsKey)
dev:listen_command(SplapsCommand)


function SetCommand(command, value)

end

function updateIndicators()
	Splaps_Ind_val = math.ceil(efm_data_bus.fm_get_Splaps_Axis)
	Splaps_Ind_State_param:set(Splaps_Ind_val)
end

function updateThrottle()
	fm_ThrottleAxis_value = efm_data_bus.fm_get_Throttle_Axis
	
	
	Throttle_param:set(fm_ThrottleAxis_value)
end


function updateSplapsHandle()
	local fm_SplapsAxis_value = efm_data_bus.fm_get_Splaps_Axis
	local Splaps_handle_pos = Splaps_param:get()
	
	Splaps_handle_pos = movingSwitch(fm_SplapsAxis_value, Splaps_handle_pos, update_time_step, 0.2)
	--print_message_to_user(fm_SplapsAxis_value)
	
	Splaps_param:set(Splaps_handle_pos)
end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end


function update()

	efm_data_bus = updateEFM_Data_Bus()
	
	updateIndicators()
	updateThrottle()
	updateSplapsHandle()
	
	
end
