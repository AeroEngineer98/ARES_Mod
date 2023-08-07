dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."EFM_Data_Bus.lua")	-- Initialize the EFM data bus
dofile(LockOn_Options.script_path.."utils.lua")


local dev = GetSelf()

local update_time_step = 0.02 --update will be called 50 times per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()

-- Get useful parameters
local dimmerDay_param = get_param_handle("DIMMER_DAY")
local dimmerKnob_param = get_param_handle("DIMMER_KNOB")

-- Indicators
local Canopy_Ind_param = get_param_handle("Canopy_Ind")
local Bingo_Ind_param = get_param_handle("Bingo_Ind")
local Hyd_Press_Ind_param = get_param_handle("Hyd_Press_Ind")
local Generator_Ind_param = get_param_handle("Generator_Ind")
local L_Fuel_Low_Ind_param = get_param_handle("L_Fuel_Low_Ind")
local R_Fuel_Low_Ind_param = get_param_handle("R_Fuel_Low_Ind")
local Motive_Ind_param = get_param_handle("Motive_Ind")
local Oil_Temp_Ind_param = get_param_handle("Oil_Temp_Ind")
local Oil_Pressure_Ind_param = get_param_handle("Oil_Pressure_Ind")
local Batt_Ind_param = get_param_handle("Batt_Ind")
local Chem_Ind_param = get_param_handle("Chem_Ind")
local Splaps_Ind_param = get_param_handle("Splaps_Ind")
local Autopilot_Ind_param = get_param_handle("Autopilot_Ind")
local Hook_Ind_param = get_param_handle("Hook_Ind")
local MasterWarn_Ind_param = get_param_handle("MasterWarn_Ind")
local EngFire_Ind_param = get_param_handle("EngineFire_Ind")

-- Indicator States
local Canopy_Ind_State_param = get_param_handle("Canopy_Ind_State")
local Bingo_Ind_State_param = get_param_handle("Bingo_Ind_State")
local Hyd_Press_Ind_State_param = get_param_handle("Hyd_Press_Ind_State")
local Generator_Ind_State_param = get_param_handle("Generator_Ind_State")
local L_Fuel_Low_Ind_State_param = get_param_handle("L_Fuel_Low_Ind_State")
local R_Fuel_Low_Ind_State_param = get_param_handle("R_Fuel_Low_Ind_State")
local Motive_Ind_State_param = get_param_handle("Motive_Ind_State")
local Oil_Temp_Ind_State_param = get_param_handle("Oil_Temp_Ind_State")
local Oil_Pressure_Ind_State_param = get_param_handle("Oil_Pressure_Ind_State")
local Batt_Ind_State_param = get_param_handle("Batt_Ind_State")
local Chem_Ind_State_param = get_param_handle("Chem_Ind_State")
local Splaps_Ind_State_param = get_param_handle("Splaps_Ind_State")
local Autopilot_Ind_State_param = get_param_handle("Autopilot_Ind_State")
local Hook_Ind_State_param = get_param_handle("Hook_Ind_State")
local MasterWarn_Ind_State_param = get_param_handle("MasterWarn_Ind_State")
local EngFire_Ind_State_param = get_param_handle("EngineFire_Ind_State")

-- Button and Switch Positions
local MasterWarn_pos_param = get_param_handle("MasterWarn_Sw")
local EngFire_pos_param = get_param_handle("EngineFire_Sw")




-- Set unused indicators to off
Canopy_Ind_State_param:set(0)
Bingo_Ind_State_param:set(0)
Hyd_Press_Ind_State_param:set(0)
Generator_Ind_State_param:set(0)
L_Fuel_Low_Ind_State_param:set(0)
R_Fuel_Low_Ind_State_param:set(0)
Motive_Ind_State_param:set(0)
Oil_Temp_Ind_State_param:set(0)
Oil_Pressure_Ind_State_param:set(0)
Batt_Ind_State_param:set(0)
Chem_Ind_State_param:set(0)
Splaps_Ind_State_param:set(0)
Autopilot_Ind_State_param:set(0)
Hook_Ind_State_param:set(0)
MasterWarn_Ind_State_param:set(1)
EngFire_Ind_State_param:set(1)



dev:listen_command(device_commands.Warning_Press)
dev:listen_command(device_commands.EngineFire_Press)

function SetCommand(command,value)

end


dimmerKnob_param:set(0.8)

function SetWarningIndicators()
	local dimmerVal = dimmerKnob_param:get()
	local dayVal = dimmerDay_param:get()
	
	-- Get state values for each indicator
	Canopy_Ind_value = Canopy_Ind_State_param:get()
	Bingo_Ind_value = Bingo_Ind_State_param:get()
	Hyd_Press_Ind_value = Hyd_Press_Ind_State_param:get()
	Generator_Ind_value = Generator_Ind_State_param:get()
	L_Fuel_Low_Ind_value = L_Fuel_Low_Ind_State_param:get()
	R_Fuel_Low_Ind_value = R_Fuel_Low_Ind_State_param:get()
	Motive_Ind_value = Motive_Ind_State_param:get()
	Oil_Temp_Ind_value = Oil_Temp_Ind_State_param:get()
	Oil_Pressure_Ind_value = Oil_Pressure_Ind_State_param:get()
	Batt_Ind_value = Batt_Ind_State_param:get()
	Chem_Ind_value = Chem_Ind_State_param:get()
	Splaps_Ind_value = Splaps_Ind_State_param:get()
	Autopilot_Ind_value = Autopilot_Ind_State_param:get()
	Hook_Ind_value = Hook_Ind_State_param:get()
	MasterWarn_Ind_value = MasterWarn_Ind_State_param:get()
	EngFire_Ind_value = EngFire_Ind_State_param:get()
	
	
	
	-- Set the values for each indicator
	Canopy_Ind_param:set(Canopy_Ind_value)
	Bingo_Ind_param:set(Bingo_Ind_value)
	Hyd_Press_Ind_param:set(Hyd_Press_Ind_value)
	Generator_Ind_param:set(Generator_Ind_value)
	L_Fuel_Low_Ind_param:set(L_Fuel_Low_Ind_value)
	R_Fuel_Low_Ind_param:set(R_Fuel_Low_Ind_value)
	Motive_Ind_param:set(Motive_Ind_value)
	Oil_Temp_Ind_param:set(Oil_Temp_Ind_value)
	Oil_Pressure_Ind_param:set(Oil_Pressure_Ind_value)
	Batt_Ind_param:set(Batt_Ind_value)
	Chem_Ind_param:set(Chem_Ind_value)
	Splaps_Ind_param:set(Splaps_Ind_value)
	Autopilot_Ind_param:set(Autopilot_Ind_value)
	Hook_Ind_param:set(Hook_Ind_value)
	MasterWarn_Ind_param:set(MasterWarn_Ind_value)
	EngFire_Ind_param:set(EngFire_Ind_value)
	
	--print_message_to_user(Splaps_Ind_value)


end


function CockpitSwitches()
	--print_message_to_user("Switches")
	fm_MasterWarnSw_value = efm_data_bus.fm_get_MasterWarn_SW
	fm_EngFireSw_value = efm_data_bus.fm_get_EngFire_SW
	local MasterWarn_pos = MasterWarn_pos_param:get()
	local EngFire_pos = EngFire_pos_param:get()
	
	MasterWarn_pos = movingSwitch(fm_MasterWarnSw_value, MasterWarn_pos, update_time_step, 0.05)
	EngFire_pos = movingSwitch(fm_EngFireSw_value, EngFire_pos, update_time_step, 0.05)
	
	MasterWarn_pos_param:set(MasterWarn_pos)
	EngFire_pos_param:set(EngFire_pos)
end


function updateEFM_Data_Bus()

	return get_efm_data_bus()

end


function update()
	efm_data_bus = updateEFM_Data_Bus()
	
	CockpitSwitches()
	SetWarningIndicators()

end

