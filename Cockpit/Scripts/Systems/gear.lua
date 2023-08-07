dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus
dofile(LockOn_Options.script_path.."utils.lua")

local gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.01
local efm_data_bus = get_efm_data_bus()



make_default_activity(update_time_step)


local GearKey  = Keys.GeartoggleKey
local GearHandle = device_commands.GearHandle
local WheelBrakeKey = Keys.WheelBrakeOnKey
local WheelBrakeKeyRel = Keys.WheelBrakeOffKey

local iCommandPlaneWheelBrakeOn = 74
local iCommandPlaneWheelBrakeOff = 75


local NGLamp_param = get_param_handle("GEAR_N_LAMP")
local MLLamp_param = get_param_handle("GEAR_ML_LAMP")
local MRLamp_param = get_param_handle("GEAR_MR_LAMP")
local ULamp_param = get_param_handle("GEAR_U_LAMP")
local NGLamp_day_param = get_param_handle("GEAR_N_LAMP_DAY")
local MLLamp_day_param = get_param_handle("GEAR_ML_LAMP_DAY")
local MRLamp_day_param = get_param_handle("GEAR_MR_LAMP_DAY")
local ULamp_day_param = get_param_handle("GEAR_U_LAMP_DAY")
local GearHandlePos_param = get_param_handle("GEAR_HANDLE_POS")
local dimmerDaySw = get_param_handle("DIMMER_DAY")


local gear_handle_pos = efm_data_bus.fm_get_GearCommand 
GearHandlePos_param:set(gear_handle_pos) -- Set gear handle position to whatever the commanded state is at startup


dev:listen_command(GearKey)
dev:listen_command(GearHandle)
--dev:listen_command(WheelBrakeKey)
--dev:listen_command(WheelBrakeKeyRel)


function SetCommand(command,value)
	--if command == WheelBrakeKey then
		--if value == 1 then 
			--dispatch_action(nil,iCommandPlaneWheelBrakeOn)
			--print_message_to_user("Brake")
		--end
	--end
end


function updateGearHandle()
	local gear_command = efm_data_bus.fm_get_GearCommand
	local gear_handle_pos = GearHandlePos_param:get()
	
	gear_handle_pos = movingSwitch(gear_command, gear_handle_pos, update_time_step, 0.25)
	
	GearHandlePos_param:set(gear_handle_pos)
end


function updateIndicators()
	local dimmerVal = 0.8
	local dayVal = dimmerDaySw:get()
	
	-- Basically this just takes whatever the EFM is saying the state of the light should be and assigning the gauge parameter that value. It leaves room for messing with the light in between the EFM and the actual gauge object
	
	fm_NGLamp_value = efm_data_bus.fm_get_NGLamp * dimmerVal
	fm_MLLamp_value = efm_data_bus.fm_get_MLLamp * dimmerVal
	fm_MRLamp_value = efm_data_bus.fm_get_MRLamp * dimmerVal
	fm_ULamp_value = efm_data_bus.fm_get_ULamp * dimmerVal
	
	fm_NGLamp_day_value = efm_data_bus.fm_get_NGLamp * dayVal
	fm_MLLamp_day_value = efm_data_bus.fm_get_MLLamp * dayVal
	fm_MRLamp_day_value = efm_data_bus.fm_get_MRLamp * dayVal
	fm_ULamp_day_value = efm_data_bus.fm_get_ULamp * dayVal
	
	NGLamp_param:set(fm_NGLamp_value)
	MLLamp_param:set(fm_MLLamp_value)
	MRLamp_param:set(fm_MRLamp_value)
	ULamp_param:set(fm_ULamp_value)

	NGLamp_day_param:set(fm_NGLamp_day_value)
	MLLamp_day_param:set(fm_MLLamp_day_value)
	MRLamp_day_param:set(fm_MRLamp_day_value)
	ULamp_day_param:set(fm_ULamp_day_value)

end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end


function update()

	efm_data_bus = updateEFM_Data_Bus()
	
	updateIndicators()
	updateGearHandle()
	
	--print_message_to_user(fm_NGLamp_day_value)
	
end
