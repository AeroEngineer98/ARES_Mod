dofile(LockOn_Options.common_script_path.."../../../Database/wsTypes.lua")

local count = -1
local function counter()
	count = count + 1
	return count
end


WPN_WEAPON_TYPE_IDS = {
    NO_WEAPON = 0,
    AA_IR_MISSILE = 1,
    AG_WEAPON_BEG = 2,
    AG_UNGUIDED_BOMB = 3,
    AG_UNGUIDED_ROCKET = 4,
    AG_GUN = 5,
    AG_WEAPON_END = 6,
	AA_AIM9M = 7
}


WPN_READY = get_param_handle("WPN_READY")
WPN_GUNS = get_param_handle("WPN_GUNS")
