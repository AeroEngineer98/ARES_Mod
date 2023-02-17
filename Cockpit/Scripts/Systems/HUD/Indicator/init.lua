dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

indicator_type       = indicator_types.COLLIMATOR  -- COMMON, COLLIMATOR, HELMET

init_pageID     = 1
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW} -- GENERAL,HUD_ONLY_VIEW,SCREENSPACE_INSIDE_COCKPIT,SCREENSPACE_OUTSIDE_COCKPIT,GROUND_UNIT_OPERATOR,GROUND_UNIT_OPERATOR_SCREENSPACE
--subset ids
BASE    = 1
INDICATION = 2

page_subsets  = {
[BASE]    		= LockOn_Options.script_path.."Systems/HUD/Indicator/base_page.lua",
[INDICATION]    = LockOn_Options.script_path.."Systems/HUD/Indicator/indication_page.lua",
}
pages = 
{
	{
	 BASE,
	 INDICATION
	 },
}

--collimator_default_distance_factor = {auto_collimator_default_distance_factor[1], 0, 0}

--dofile(LockOn_Options.script_path.."materials.lua")