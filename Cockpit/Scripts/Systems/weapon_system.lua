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



local stepMillis = 1000/200

local update_time_step = stepMillis/1000 --update will be called
make_default_activity(update_time_step)

local efm_data_bus = get_efm_data_bus()
local sensor_data = get_base_data()

-- Set initial conditions
MasterArm_pos_param:set(efm_data_bus.fm_get_MasterArm_SW)



local wpn_guns = 3600
-- Gun_AMT_param:get(wpn_guns)



local wpn_guns_rate = 3600/60/60
local wpn_guns_elapsed = 0


local WPNSelectModes = {'Missiles', 'Bombs', 'Rockets'}
local ReleaseModes = {'Single', 'Ripple', 'Salvo'}
local ReleaseTimer
local RippleLength = 4
local RippleWaitStep = 0
local STA_Arm_pos = {0,0,0,0}
local STA_Arm_val = {0,0,0,0}
local STA_Info = {}
local STA_Launch_Order = {3,0,2,1}
local STA_Launch_Command = {0,0,0,0}
local MSL_Inc = 1
local BMB_Inc = 1
local RKT_Inc = 1
local NumReleased = 0
local fired = false
local PicklePressed = 0
local MSL_STA_List = {-1}
local BMB_STA_List = {-1}
local RKT_STA_List = {-1}
local EMT_STA_List = {-1}




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
	
	for i = 1,4 do
		STA_Info[i-1] = WeaponSystem:get_station_info(i-1)
		--print_message_to_user(STA_Info[i-1].count)
	end
	
	--print_message_to_user(STA_Info[2].weapon.level3)
	
	
end


function update_displays()
	--Guns QTY Display
	Gun_Ones_param:set(math.floor(math.fmod(wpn_guns,10)))
	Gun_Tens_param:set(math.floor(math.fmod(wpn_guns,100)/10))
	Gun_Hund_param:set(math.floor(math.fmod(wpn_guns,1000)/100))
	Gun_Thou_param:set(math.floor(math.fmod(wpn_guns,10000)/1000))
end


function updateSwitches()

	--Nose, Nose/Tail SW
	-- Sidewinder Cool SW
	-- Missile Volume Knob
	-- Interval Knob
	-- Release Mode Knob SW
	-- Chemtrail SW
	-- Single/Pair within ripple
	-- Ripple QTY
	
	
	local fm_MasterArmSw_value = efm_data_bus.fm_get_MasterArm_SW
	local MasterArm_pos = MasterArm_pos_param:get()
	
	local WPNSelect_pos = get_cockpit_draw_argument_value(86)
	local JettSelect_pos = get_cockpit_draw_argument_value(87)
	local GunArm_pos = get_cockpit_draw_argument_value(89)
	STA_Arm_pos[1] = get_cockpit_draw_argument_value(90)
	STA_Arm_pos[2] = get_cockpit_draw_argument_value(91)
	STA_Arm_pos[3] = get_cockpit_draw_argument_value(92)
	STA_Arm_pos[4] = get_cockpit_draw_argument_value(93)
	local Chemtrail_pos = get_cockpit_draw_argument_value(120)
	local SWCool_pos = get_cockpit_draw_argument_value(121)
	local BombArmMode_pos = get_cockpit_draw_argument_value(122)
	local RELTimingMult_pos = get_cockpit_draw_argument_value(123)
	local REL_Mode_pos = get_cockpit_draw_argument_value(124)
	local REL_Timing_pos = get_cockpit_draw_argument_value(125)
	
	MasterArm_pos = movingSwitch(fm_MasterArmSw_value, MasterArm_pos, update_time_step, 0.2)
	
	MasterArm_pos_param:set(MasterArm_pos)
	WPNSelect_val = math.floor(WPNSelect_pos*2)
	JettSelect_val = math.floor(JettSelect_pos*5)
	GunArm_val = math.floor(GunArm_pos)
	for i = 1,4 do
		STA_Arm_val[i] = math.floor(STA_Arm_pos[i])
	end
	
	REL_Mode_val = math.floor(REL_Mode_pos*2)+1
	
	
	ReleaseTimer = 180 * REL_Timing_pos + 20
	
	if RELTimingMult_pos == 1 then
		ReleaseTimer = ReleaseTimer*10		
	end
	
	print_message_to_user(ReleaseModes[REL_Mode_val])
	
	-- WPNSelect_pos = get_cockpit_draw_argument_value(86)
	--print_message_to_user(WPNSelect_val)
end


function update_Stores_List()

	MSL_STA_List = {-1}
	BMB_STA_List = {-1}
	RKT_STA_List = {-1}
	EMT_STA_List = {-1}
	local j = 0
	
	for i = 0,3 do
		j = STA_Launch_Order[i+1]
		
		--print_message_to_user(j)
		if STA_Info[j].count > 0 and STA_Info[j].weapon.level2 == wsType_Missile then
			MSL_STA_List[#MSL_STA_List + 1] = j
			
		elseif STA_Info[j].count > 0 and STA_Info[j].weapon.level2 == wsType_Bomb then
			BMB_STA_List[#BMB_STA_List + 1] = j
			
		elseif STA_Info[j].count > 0 and STA_Info[j].weapon.level2 == wsType_NURS then
			RKT_STA_List[#RKT_STA_List + 1] = j
			
		elseif STA_Info[j].count == 0 then
			EMT_STA_List[#EMT_STA_List + 1] = j
			
		end
		
	end
	
	table.remove(MSL_STA_List,1)
	table.remove(BMB_STA_List,1)
	table.remove(RKT_STA_List,1)
	table.remove(EMT_STA_List,1)
	
	-- print_message_to_user(BMB_STA_List[1])

end

function WeaponsComputer()
	updateSwitches()
	WPN_Mode = WPNSelectModes[WPNSelect_val+1]
	REL_Mode = ReleaseModes[REL_Mode_val]
	
	
	
	if efm_data_bus.fm_get_MasterArm_SW == 1 then
		if WPN_Mode == 'Missiles' then
			-- for i = 0,3 do
				-- j = STA_Launch_Order[i]
				-- if STA_Info[j].count > 0 and STA_Info[j].weapon.level2 == wsType_Missile and STA_Launch_Command[j+1] == 1 then
					-- WeaponSystem:launch_station(j)
					-- WeaponSystem:performClickableAction(Keys.PickleOff, 1, false)
					-- print_message_to_user(tostring(j))
				-- end
			-- end
			
			--print_message_to_user("Missiles Selected")
			
		elseif WPN_Mode == 'Bombs' then
		
			if REL_Mode == 'Single' then
				for i = 1,#BMB_STA_List do	
					if STA_Info[BMB_STA_List[i]].count > 0 and STA_Info[BMB_STA_List[i]].weapon.level2 == wsType_Bomb and STA_Launch_Command[BMB_STA_List[i]+1] == 1 then
						WeaponSystem:launch_station(BMB_STA_List[i])
						WeaponSystem:performClickableAction(Keys.PickleOff, 1, false) 
					end
				end
			
			
			elseif REL_Mode == 'Salvo' then
				for i = 1,#BMB_STA_List do	
					if STA_Info[BMB_STA_List[i]].count > 0 and STA_Info[BMB_STA_List[i]].weapon.level2 == wsType_Bomb and STA_Launch_Command[BMB_STA_List[i]+1] == 1 then
						WeaponSystem:launch_station(BMB_STA_List[i])
						fired_ = true
					end
				end
				if fired_ then
					WeaponSystem:performClickableAction(Keys.PickleOff, 1, false) 
					fired_ = false 
				end
			
			
			elseif REL_Mode == 'Ripple' then
				if PicklePressed == 1 then
					if math.modf(RippleWaitStep, ReleaseTimer/stepMillis) == 0 then
						for i = 1,#BMB_STA_List do
							if STA_Info[BMB_STA_List[i]].count > 0 and STA_Info[BMB_STA_List[i]].weapon.level2 == wsType_Bomb and STA_Launch_Command[BMB_STA_List[i]+1] == 1 and BMB_STA_List[i] == BMB_STA_List[BMB_Inc] and fired_ == false then
								WeaponSystem:launch_station(BMB_STA_List[i])
								NumReleased = NumReleased + 1
								fired_ = true
								
								if BMB_Inc >= #BMB_STA_List then
									BMB_Inc = 1
								else 
									BMB_Inc = BMB_Inc + 1
								end
							end
						end
						fired_ = false
					end
					
					if NumReleased >= RippleLength then
						WeaponSystem:performClickableAction(Keys.PickleOff, 1, false) 
					end
					
					if RippleWaitStep > ReleaseTimer/stepMillis then
						RippleWaitStep = 0
					else
						RippleWaitStep = RippleWaitStep + 1
					end
				elseif PicklePressed == 0 then
					RippleWaitStep = 0
					NumReleased = 0
				end
				
			end
			
			
		elseif WPN_Mode == 'Rockets' then
			
			if REL_Mode == 'Single' then
				for i = 1,#RKT_STA_List do										
					if STA_Info[RKT_STA_List[i]].count > 0 and STA_Info[RKT_STA_List[i]].weapon.level2 == wsType_NURS and STA_Launch_Command[RKT_STA_List[i]+1] == 1 then
						WeaponSystem:launch_station(RKT_STA_List[i])
						WeaponSystem:performClickableAction(Keys.PickleOff, 1, false) 
					end
				end
			
			
			elseif REL_Mode == 'Salvo' then
				for i = 1,#RKT_STA_List do
					if STA_Info[RKT_STA_List[i]].count > 0 and STA_Info[RKT_STA_List[i]].weapon.level2 == wsType_NURS and STA_Launch_Command[RKT_STA_List[i]+1] == 1 then
						WeaponSystem:launch_station(RKT_STA_List[i])
						fired_ = true
					end
				end
				if fired_ then 
					WeaponSystem:performClickableAction(Keys.PickleOff, 1, false) 
					fired_ = false 
				end
				
				
			elseif REL_Mode == 'Ripple' then
				if PicklePressed == 1 then
					if math.modf(RippleWaitStep, ReleaseTimer/stepMillis) == 0 then
						for i = 1,#RKT_STA_List do
							if STA_Info[RKT_STA_List[i]].count > 0 and STA_Info[RKT_STA_List[i]].weapon.level2 == wsType_NURS and STA_Launch_Command[RKT_STA_List[i]+1] == 1 and RKT_STA_List[i] == RKT_STA_List[RKT_Inc] and fired_ == false then
								WeaponSystem:launch_station(RKT_STA_List[i])
								NumReleased = NumReleased + 1			
								fired_ = true
								
								if RKT_Inc >= #RKT_STA_List then
									RKT_Inc = 1
								else 
									RKT_Inc = RKT_Inc + 1
								end
							end
						end
						fired_ = false
					end
					
					if NumReleased >= RippleLength then
						WeaponSystem:performClickableAction(Keys.PickleOff, 1, false) 
					end
					
					if RippleWaitStep > ReleaseTimer/stepMillis then
						RippleWaitStep = 0
					else
						RippleWaitStep = RippleWaitStep + 1
					end
				elseif PicklePressed == 0 then
					RippleWaitStep = 0
					NumReleased = 0
				end
				
			
			end
			
		end
		
	end
	
	
	
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
	
	
	update_storages()
	update_Stores_List()
	update_displays()
	
	WeaponsComputer()
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
		if STA_Arm_val[1] == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon1, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon1, 0, false)
		end
	
	elseif command == Keys.SelectPylon2Key then 
		if STA_Arm_val[2] == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon2, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon2, 0, false)
		end	
		
	elseif command == Keys.SelectPylon3Key then 
		if STA_Arm_val[3] == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon3, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon3, 0, false)
		end
		
	elseif command == Keys.SelectPylon4Key then 
		if STA_Arm_val[4] == 0 then
			WeaponSystem:performClickableAction(device_commands.SelectPylon4, 1, false)
		else
			WeaponSystem:performClickableAction(device_commands.SelectPylon4, 0, false)
		end
		
	elseif command == Keys.PickleOn and efm_data_bus.fm_get_MasterArm_SW == 1 then 
		for i = 1,4 do
			PicklePressed = 1
			if STA_Arm_val[i] == 1 then
				STA_Launch_Command[i] = 1
				
			else
				STA_Launch_Command[i] = 0
			end
		end
		
	elseif command == Keys.PickleOff and efm_data_bus.fm_get_MasterArm_SW == 1 then 
		for i = 1,4 do
				STA_Launch_Command[i] = 0
				
		end
		PicklePressed = 0
	
	end
	
	--print_message_to_user("command")
	--print_message_to_user(command)
	--print_message_to_user(value)
	
end


WeaponSystem:listen_event("WeaponRearmComplete")
function CockpitEvent(command, val)
    if command == "WeaponRearmComplete" then
        wpn_guns = 3600
    end
end



need_to_be_closed = false -- close lua state after initialization

