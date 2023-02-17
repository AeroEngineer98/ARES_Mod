--dofile(LockOn_Options.script_path.."Systems/HUD/Units.lua")
dofile(LockOn_Options.script_path.."Systems/HUD/Indicator/definitions.lua")

--local TST  		 = MakeMaterial(nil,{80,17,7,200})
local TST  		 = MakeMaterial(nil,{220,220,220,5})

local SHOW_MASKS = true
--[[
total_field_of_view 				= CreateElement "ceMeshPoly"
total_field_of_view.name 			= "total_field_of_view"
total_field_of_view.primitivetype 	= "triangles"
total_field_of_view.vertices 		=  {{-1,1},{1,1},{1,-1},{-1,-1}}
total_field_of_view.indices			=  {0,1,2,0,2,3}
total_field_of_view.init_pos		= {0, 0, 0}
total_field_of_view.material		= TST
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level			= RADAR_DEFAULT_LEVEL
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= false
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)

]]--
SetScale(METERS)
local x_size        = 0.2401/2	--MFD_SIZE-- * MFD_SCALE
local y_size        = 0.3653/2	--MFD_SIZE --* MFD_SCALE
local corner		= 0.9

local HUD_Angle = -45


local vert		= {	{-x_size, y_size * corner},
					{ x_size, y_size * corner},
					{ x_size,-y_size * corner},
					{-x_size,-y_size * corner},
					
					{-x_size, 		y_size * corner},
					{ x_size, 		y_size * corner},
					{ x_size * corner, y_size},
					{-x_size * corner, y_size},
					
					{-x_size, 		-y_size * corner},
					{ x_size, 		-y_size * corner},
					{ x_size * corner,-y_size},
					{-x_size * corner,-y_size},
				}
local indi		 	= {	0, 1, 2, 0, 2, 3,
						4, 5, 6, 4, 6, 7,
						8, 9, 10, 8, 10, 11,
						} --default_box_indices





Radar_base             	= CreateElement "ceSimple"
Radar_base.name			= "Radar_base"
--Radar_base.init_pos		= {0,0,0} -- right/left, up/down, fwd/aft
Radar_base.init_rot		= {0, 0, HUD_Angle}
Add(Radar_base)

---------------------------------------------------



local	glass 			 	 	= CreateElement "ceMeshPoly"
		glass.name 			 	= "glass"
		glass.primitivetype 	= "triangles"
		glass.vertices 		 	= vert
		glass.indices 		 	= indi
		glass.material		 	= MakeMaterial(nil,{100,0,0,0})
		glass.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
		glass.level			 	= RADAR_DEFAULT_NOCLIP_LEVEL
		glass.parent_element	= "Radar_base"
	Add(glass)




local 	total_field_of_view 				= CreateElement "ceMeshPoly"
		total_field_of_view.name 			= "total_field_of_view"
		total_field_of_view.primitivetype 	= "triangles"
		total_field_of_view.vertices		= vert
		total_field_of_view.indices		 	= indi									
		total_field_of_view.material		= MakeMaterial(nil,{255,1,1,0})
		total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
		total_field_of_view.level			= RADAR_DEFAULT_NOCLIP_LEVEL--MDF_FOV_LEVEL
		total_field_of_view.parent_element	= "Radar_base"
	Add(total_field_of_view)
