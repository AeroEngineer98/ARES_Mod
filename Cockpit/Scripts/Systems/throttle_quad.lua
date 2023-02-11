dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus

local throttle_quad_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.01
local efm_data_bus = get_efm_data_bus()

make_default_activity(update_time_step)


local JoystickThrottle  = Axes.JoystickThrottle
local ThrottleAxis = device_commands.throttle_axis
local SplapsKey  = Keys.PlaneAirBrake
local SplapsCommand = device_commands.speedbrake


local Throttle_param = get_param_handle("THROTTLE_AXIS_POS")
local Splaps_param = get_param_handle("SPLAPS_HANDLE_POS")
local dimmerDaySw = get_param_handle("DIMMER_DAY")
local SPLamp_param = get_param_handle("SP_LAMP")
local SPLamp_day_param = get_param_handle("SP_LAMP_DAY")


local throttle_lever_pos = efm_data_bus.fm_get_Throttle_Axis 
Throttle_param:set(throttle_lever_pos) -- Set throttle position to whatever the commanded state is at startup

local Splaps_handle_pos = efm_data_bus.fm_get_Splaps_Axis 
if Splaps_handle_pos == 0 then -- Set splaps handle position to whatever the commanded state is at startup
	Splaps_param:set(1) 
else
	Splaps_param:set(0)
end



dev:listen_command(JoystickThrottle)
dev:listen_command(ThrottleAxis)
dev:listen_command(SplapsKey)
dev:listen_command(SplapsCommand)


function SetCommand(command, value)

end

function updateIndicators()
	local dimmerVal = 0.8
	local dayVal = dimmerDaySw:get()
	
	-- Basically this just takes whatever the EFM is saying the state of the light should be and assigning the gauge parameter that value. It leaves room for messing with the light in between the EFM and the actual gauge object
	
	fm_SPLamp_value = efm_data_bus.fm_get_SplapsLamp
	
	fm_SPLamp_day_value = efm_data_bus.fm_get_SplapsLamp * dayVal
	
	if fm_SPLamp_value > 0.05*dimmerVal then
		SPLamp_param:set(dimmerVal)
	else
		SPLamp_param:set(0)
	end
	
	if fm_SPLamp_day_value > 0.05 then
		SPLamp_day_param:set(dimmerVal)
	else
		SPLamp_day_param:set(0)
	end

end

function updateThrottle()
	fm_ThrottleAxis_value = efm_data_bus.fm_get_Throttle_Axis
	
	
	Throttle_param:set(fm_ThrottleAxis_value)
end


function updateSplapsHandle()
	local fm_SplapsAxis_value = efm_data_bus.fm_get_Splaps_Axis
	local Splaps_handle_pos = Splaps_param:get()
	--print_message_to_user("fm_SplapsAxis_value: "..fm_SplapsAxis_value)
	--print_message_to_user("Splaps_handle_pos: "..Splaps_handle_pos)
	
	
	if (Splaps_handle_pos < 1) and (fm_SplapsAxis_value < 1) then
		Splaps_handle_pos = Splaps_handle_pos + 0.05
		--print_message_to_user("Fwd/Retracting")
		
	elseif (Splaps_handle_pos > 0) and (fm_SplapsAxis_value > 0) then
		Splaps_handle_pos = Splaps_handle_pos - 0.05
		--print_message_to_user("Aft/Extending")
		
	elseif (Splaps_handle_pos == 1) and (fm_SplapsAxis_value == 0) then
		Splaps_handle_pos = 1
		--print_message_to_user("Fwd/Retracted")
		
	elseif (Splaps_handle_pos == 0) and (fm_SplapsAxis_value == 1) then
		Splaps_handle_pos = 0
		--print_message_to_user("Aft/Extended")
	end
	
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
