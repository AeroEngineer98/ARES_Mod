local WeaponSystem     = GetSelf()
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/weapon_system_api.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus
dofile(LockOn_Options.script_path.."utils.lua")


package.cpath 			= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('avSimplestWeaponSystem')


-- Get useful parameters
local MasterArm_pos_param = get_param_handle("MASTER_ARM_POS")
local MasterArmCommand = device_commands.MasterArm

local Gun_Thou_param = get_param_handle("GUN_AMT_THOU")
local Gun_Hund_param = get_param_handle("GUN_AMT_HUND")
local Gun_Tens_param = get_param_handle("GUN_AMT_TENS")
local Gun_Ones_param = get_param_handle("GUN_AMT_ONES")





local update_time_step = 0.02 --update will be called 50 times per second
make_default_activity(update_time_step)

local efm_data_bus = get_efm_data_bus()
local sensor_data = get_base_data()

-- Set initial conditions
MasterArm_pos_param:set(efm_data_bus.fm_get_MasterArm_SW)



local wpn_guns = 3600
-- Gun_AMT_param:get(wpn_guns)



local wpn_guns_rate = 3600/60/60
local wpn_guns_elapsed = 0

--local iCommandPlaneFire = 84
--local iCommandPlaneFireOff = 85


function update_storages()
    --WPN_GUNS:set(wpn_guns)
	if gun_firing == true then
		wpn_guns = wpn_guns - wpn_guns_rate
	end
	
	if wpn_guns <= 0 then
		dispatch_action(nil,Keys.iCommandPlaneFireOff)
		gun_firing = false
		wpn_guns = 0
	end
end


function update_displays()
	--Guns QTY Display
	Gun_Ones_param:set(math.floor(math.fmod(wpn_guns,10)))
	Gun_Tens_param:set(math.floor(math.fmod(wpn_guns,100)/10))
	Gun_Hund_param:set(math.floor(math.fmod(wpn_guns,1000)/100))
	Gun_Thou_param:set(math.floor(math.fmod(wpn_guns,10000)/1000))
end


function updateSwitches()
	local fm_MasterArmSw_value = efm_data_bus.fm_get_MasterArm_SW
	local MasterArm_pos = MasterArm_pos_param:get()
	
	local WPNSelect_pos = get_cockpit_draw_argument_value(86)
	local JettSelect_pos = get_cockpit_draw_argument_value(87)
	local GunArm_pos = get_cockpit_draw_argument_value(89)
	local STA_1_Arm_pos = get_cockpit_draw_argument_value(90)
	local STA_2_Arm_pos = get_cockpit_draw_argument_value(91)
	local STA_3_Arm_pos = get_cockpit_draw_argument_value(92)
	local STA_4_Arm_pos = get_cockpit_draw_argument_value(93)
	
	MasterArm_pos = movingSwitch(fm_MasterArmSw_value, MasterArm_pos, update_time_step, 0.2)
	
	MasterArm_pos_param:set(MasterArm_pos)
	WPNSelect_val = math.floor(WPNSelect_pos*4)
	JettSelect_val = math.floor(JettSelect_pos*5)
	GunArm_val = math.floor(GunArm_pos)
	STA_1_Arm_val = math.floor(STA_1_Arm_pos)
	STA_2_Arm_val = math.floor(STA_2_Arm_pos)
	STA_3_Arm_val = math.floor(STA_3_Arm_pos)
	STA_4_Arm_val = math.floor(STA_4_Arm_pos)
	
	
	-- WPNSelect_pos = get_cockpit_draw_argument_value(86)
	--print_message_to_user(L_OB_Arm_pos)
end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end


function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
	
    if birth=="GROUND_HOT" then
    elseif birth=="AIR_HOT" then
    elseif birth=="GROUND_COLD" then
    end

    update_storages()

    avSimplestWeaponSystem.Setup()
end


function update()
	efm_data_bus = updateEFM_Data_Bus()
	
	updateSwitches()
	update_storages()
	update_displays()
	--print_message_to_user(math.fmod(wpn_guns,10000)/1000)
	
end


WeaponSystem:listen_command(Keys.PlaneFireOn)
WeaponSystem:listen_command(Keys.PlaneFireOff)
WeaponSystem:listen_command(Keys.PickleOn)
WeaponSystem:listen_command(Keys.PickleOff)
WeaponSystem:listen_command(Keys.GunRearm)
WeaponSystem:listen_command(Keys.SelectPylon1Key)
WeaponSystem:listen_command(Keys.SelectPylon2Key)
WeaponSystem:listen_command(Keys.SelectPylon3Key)
WeaponSystem:listen_command(Keys.SelectPylon4Key)
WeaponSystem:listen_command(Keys.GunEnableKey)

function SetCommand(command,value)
	if command == Keys.PlaneFireOn and efm_data_bus.fm_get_MasterArm_SW == 1 and GunArm_val == 1 then
		if wpn_guns > 0 then 
			dispatch_action(nil,Keys.iCommandPlaneFire)
			gun_firing = true
		end

	elseif command == Keys.PlaneFireOff then
		dispatch_action(nil,Keys.iCommandPlaneFireOff)
		gun_firing = false
	
	elseif command == Keys.GunEnableKey then 
		if get_cockpit_draw_argument_value(89) == 0 then
			WeaponSystem:performClickableAction(device_commands.GunArm, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.GunArm, 0, false)
		end
		
	elseif command == Keys.SelectPylon1Key then 
		if STA_1_Arm_val == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon1, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon1, 0, false)
		end
	
	elseif command == Keys.SelectPylon2Key then 
		if get_cockpit_draw_argument_value(91) == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon2, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon2, 0, false)
		end	
		
	elseif command == Keys.SelectPylon3Key then 
		if get_cockpit_draw_argument_value(92) == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon3, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon3, 0, false)
		end
		
	elseif command == Keys.SelectPylon4Key then 
		if get_cockpit_draw_argument_value(93) == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon4, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon4, 0, false)
		end
		
	elseif command == Keys.PickleOn and efm_data_bus.fm_get_MasterArm_SW == 1 then 
		if STA_1_Arm_val == 1 then
			WeaponSystem:launch_station(0)
		end
		if STA_2_Arm_val == 1 then
			WeaponSystem:launch_station(1)
		end
		if STA_3_Arm_val == 1 then
			WeaponSystem:launch_station(2)
		end
		if STA_4_Arm_val == 1 then
			WeaponSystem:launch_station(3)
		end
	
	end
	
	--print_message_to_user("command")
	--print_message_to_user(command)
	--print_message_to_user(value)
	
end


WeaponSystem:listen_event("WeaponRearmComplete")
function CockpitEvent(command, val)
    if command == "WeaponRearmComplete" then
        wpn_guns = 2500
    end
end



need_to_be_closed = false -- close lua state after initialization

