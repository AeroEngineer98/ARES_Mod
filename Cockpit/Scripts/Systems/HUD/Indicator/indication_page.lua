--dofile(LockOn_Options.script_path.."Systems/HUD/Units.lua")
dofile(LockOn_Options.script_path.."Systems/HUD/Indicator/definitions.lua")



--local MARK_MATERIAL   = MakeMaterial(nil,{255,120,0,255})
RS = RADAR_SCALE



ud_scale 	= 0.00001 * 0.9		* RS	--0.00001
lr_scale 	= 0.095	  * 0.9	*2	* RS	--0.2		--0.085
life_time 	= 10			--1
life_time_low = 0


-------------------------------------------------------------
SetScale(MILLYRADIANS)
--[[
local x_size = 1*RS
local y_size = 100 *RS


for i = -2,2 do
	local   radar_grid_v 				= CreateElement "ceMeshPoly"
			radar_grid_v.name 			= "radar_grid_v"
			radar_grid_v.primitivetype 	= "triangles"
			radar_grid_v.vertices 		= {	{-x_size, -y_size},
											{-x_size,  y_size},	
											{ x_size,  y_size},	
											{ x_size, -y_size}
										  }
			radar_grid_v.indices  		= default_box_indices
			radar_grid_v.init_pos 		= {i*y_size/2,0}
			radar_grid_v.material 		= HUD_GREEN_SOFT
			radar_grid_v.h_clip_relation= h_clip_relations.COMPARE
			radar_grid_v.level			= RADAR_DEFAULT_LEVEL
			radar_grid_v.collimated     = true
		Add(radar_grid_v)

end

	x_size = 100*RS
	y_size = 1*RS
for i = -2,2 do
	local   radar_grid_v 				= CreateElement "ceMeshPoly"
			radar_grid_v.name 			= "radar_grid_v"
			radar_grid_v.primitivetype 	= "triangles"
			radar_grid_v.vertices 		= {	{-x_size, -y_size},
											{-x_size,  y_size},
											{ x_size,  y_size},	
											{ x_size, -y_size}
										  }
			radar_grid_v.indices  		= default_box_indices
			radar_grid_v.init_pos 		= {0,i*x_size/2}
			radar_grid_v.material 		= HUD_GREEN_SOFT
			radar_grid_v.h_clip_relation= h_clip_relations.COMPARE
			radar_grid_v.level			= RADAR_DEFAULT_LEVEL
			radar_grid_v.collimated 	= true
		Add(radar_grid_v)

end
--]]

--local HUD_Roll = get_param_handle("ROLL_DEG_HUD")
--local HUD_Roll_value = HUD_Roll:get()





-- Create Center Mark
makeLine(20, 1, {0,0}, {0}) -- Center Mark H Line
makeLine(20, 1, {0,0}, {90}) -- Center Mark V Line


HUD_Ind_base             	= CreateElement "ceSimple"
HUD_Ind_base.name			= "HUD_Ind_base"
--HUD_Ind_base.init_pos		= {pitch*Deg_to_MR*math.sin(math.rad(roll)), -pitch*Deg_to_MR*math.cos(math.rad(roll))} -- right/left, up/down, fwd/aft
--HUD_Ind_base.element_params = {"PITCH_DEG_HUD"}  --Parameters that are controlling the element
--HUD_Ind_base.controllers    = {{"move_up_down_using_parameter", 0, -Deg_to_R}} -- type of transformation, parameter index in "element_params", control ratio
HUD_Ind_base.collimated 	= true
Add(HUD_Ind_base)




makeHLine(250, 1, {0,0}, {0}, "HUD_Ind_base") -- Horizon Line
makeHLine(100, 1, {0,5*Deg_to_MR}, {0}, "HUD_Ind_base") -- 5 deg up line
makeHLine(200, 1, {0,10*Deg_to_MR}, {0}, "HUD_Ind_base") -- 10 deg up line
makeHLine(100, 1, {0,15*Deg_to_MR}, {0}, "HUD_Ind_base") -- 15 deg up line
makeHLine(200, 1, {0,20*Deg_to_MR}, {0}, "HUD_Ind_base") -- 20 deg up line
makeHLine(200, 1, {0,30*Deg_to_MR}, {0}, "HUD_Ind_base") -- 30 deg up line
makeHLine(200, 1, {0,40*Deg_to_MR}, {0}, "HUD_Ind_base") -- 40 deg up line
makeHLine(100, 1, {0,45*Deg_to_MR}, {0}, "HUD_Ind_base") -- 45 deg up line

makeHLine(100, 1, {0,-5*Deg_to_MR}, {0}, "HUD_Ind_base") -- 5 deg up line
makeHLine(200, 1, {0,-10*Deg_to_MR}, {0}, "HUD_Ind_base") -- 10 deg up line
makeHLine(100, 1, {0,-15*Deg_to_MR}, {0}, "HUD_Ind_base") -- 15 deg up line
makeHLine(200, 1, {0,-20*Deg_to_MR}, {0}, "HUD_Ind_base") -- 20 deg up line
makeHLine(200, 1, {0,-30*Deg_to_MR}, {0}, "HUD_Ind_base") -- 30 deg up line
makeHLine(200, 1, {0,-40*Deg_to_MR}, {0}, "HUD_Ind_base") -- 40 deg up line
makeHLine(100, 1, {0,-45*Deg_to_MR}, {0}, "HUD_Ind_base") -- 45 deg up line

-- 90 deg Crosses
makeHLine(100, 1, {0,-90*Deg_to_MR}, {45}, "HUD_Ind_base") -- 90 deg down line
makeHLine(100, 1, {0,-90*Deg_to_MR}, {-45}, "HUD_Ind_base") -- 90 deg down line

makeHLine(100, 1, {0,90*Deg_to_MR}, {0}, "HUD_Ind_base") -- 90 deg up line
makeHLine(100, 1, {0,90*Deg_to_MR}, {90}, "HUD_Ind_base") -- 90 deg up line
