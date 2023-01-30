dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/weapon_system_api.lua")


package.cpath 			= package.cpath..";".. LockOn_Options.script_path.. "..\\..\\bin\\?.dll"
require('avSimplestWeaponSystem')


local dev = GetSelf()

local update_time_step = 0.02 --update will be called 50 times per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local wpn_guns = 2500

local wpn_guns_on = true
local wpn_guns_rate = 60/1025
local wpn_guns_elapsed = 0

local iCommandPlaneFire = 84
local iCommandPlaneFireOff = 85


local function update_storages()
    --WPN_GUNS:set(wpn_guns)
end


function update()

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

dev:listen_command(Keys.Trigger)
dev:listen_command(Keys.GunRearm)



function SetCommand(command,value)

    if command == Keys.Trigger then
        if value == 2 then 
            dispatch_action(nil,iCommandPlaneFire)

			--print_message_to_user("Trigger")
        elseif value == 0 then
            dispatch_action(nil,iCommandPlaneFireOff)

        end
    end
end


dev:listen_event("WeaponRearmComplete")
function CockpitEvent(command, val)
    if command == "WeaponRearmComplete" then
        wpn_guns = 2500
    end
end



need_to_be_closed = false -- close lua state after initialization

