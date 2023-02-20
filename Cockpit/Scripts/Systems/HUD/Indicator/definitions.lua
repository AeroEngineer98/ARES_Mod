dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

SetScale(FOV)

HUD_DEFAULT_LEVEL = 9
HUD_DEFAULT_NOCLIP_LEVEL  = HUD_DEFAULT_LEVEL - 1
HUD_SCALE = 1--0.7--1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
    Add(object)
end

function AddHUDElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
	object.collimated 		= true
    Add(object)
end

Deg_to_MR = 17.4533
Deg_to_R = 0.0174533


-------FONTS------------------------------------------------------------------------------
HUD_FONT    = MakeFont(fontdescription["font_HUD"], HUD_GREEN_COLOR,   "HUD_FONT")

FONT_SCALE = 1

local font_size 					= 0.015						* FONT_SCALE
local default_char_height  			= font_size		--font_size or 0.004		* FONT_SCALE
local default_char_width   			= default_char_height--0.3 * default_char_height
local default_char_horiz_spacing 	= -0.006 * FONT_SCALE
local default_char_vert_spacing 	= -0.001							--must be adjustet manualy to scale (scale 0.8   	-0.001

txt_100stringdefs 			= 	{default_char_height * 1,	default_char_width * 1,		default_char_horiz_spacing,		default_char_vert_spacing} 
txt_70stringdefs 			= 	{default_char_height * 0.7,	default_char_width * 0.7,		default_char_horiz_spacing * 0.7,		default_char_vert_spacing} 

local text100offset = {-6, 1} -- An offset to the text to make the alignment correct. This is in liu of knowing how to make a font without it being off-center
local text70offset = {-6*0.7, 1*0.7} -- An offset to the text to make the alignment correct. This is in liu of knowing how to make a font without it being off-center



-----------------------------------------------------------------------------------------

--SetScale(MILLYRADIANS)

function makeHLine(width, thickness, position, rotation, parent)


	local	h_line 					= CreateElement "ceMeshPoly"
		h_line.name 				= "H_Line"
		h_line.primitivetype 		= "triangles"
		h_line.vertices 			= {	{-width/2, -thickness/2},
										{-width/2,  thickness/2},
										{ width/2,  thickness/2},	
										{ width/2, -thickness/2}
									}
		h_line.indices  			= default_box_indices
		h_line.init_pos 			= position
		h_line.init_rot 			= rotation
		h_line.material 			= HUD_GREEN_MAT
		h_line.parent_element		= parent or nil
	AddHUDElement(h_line)

end


function makeStaticLine(width, thickness, position, rotation, parent)
		local   line 			= CreateElement "ceMeshPoly"
		line.name 				= "Line"
		line.primitivetype 		= "triangles"
		line.vertices 			= {	{-width/2, -thickness/2},
									{-width/2,  thickness/2},
									{ width/2,  thickness/2},	
									{ width/2, -thickness/2}
								}
		line.indices  			= default_box_indices
		line.init_pos 			= position
		line.init_rot 			= rotation
		line.material 			= HUD_GREEN_MAT
		line.parent_element		= parent or nil
	AddHUDElement(line)

end


function makeParamLine(parameters, width, thickness, position, rotation, parent)
		local   paramline 			= CreateElement "ceMeshPoly"
		paramline.name 				= "ParamLine"
		paramline.primitivetype 	= "triangles"
		paramline.vertices 			= {	{-width/2, -thickness/2},
										{-width/2,  thickness/2},
										{ width/2,  thickness/2},	
										{ width/2, -thickness/2}
									}
		paramline.indices  			= default_box_indices
		paramline.init_pos 			= position
		paramline.init_rot 			= rotation
		paramline.element_params 	= parameters
		paramline.controllers    	= {{"move_up_down_using_parameter", 0, 1}, {"move_left_right_using_parameter", 1, 1}, {"rotate_using_parameter", 2, 1}}
		paramline.material 			= HUD_GREEN_MAT
		paramline.parent_element	= parent or nil
	AddHUDElement(paramline)

end


function ConstantTextElement(text, position, rotation, parent, alignment, stringdefs)
	
	if stringdefs == txt_70stringdefs then
		textoffset = text70offset
	else
		stringdefs = txt_100stringdefs
		textoffset = text100offset
	end
	
	if alignment == nil then
		alignment = "CenterCenter"
	end
	
	local TextEle					= CreateElement "ceStringPoly"  --Defines what type of element
		TextEle.name				= "TextEle"
		TextEle.material			= HUD_FONT  --For text elements, this is the font definition
		TextEle.init_pos			= {position[1] + textoffset[1], position[2] + textoffset[2]}
		TextEle.init_rot 			= rotation
		TextEle.alignment			= alignment -- "CenterCenter", "LeftCenter", "RightCenter"
		TextEle.stringdefs      	= stringdefs
		TextEle.formats		  		= {"%.0f"}
		TextEle.value          		= text
		TextEle.parent_element		= parent
		TextEle.UseBackground		= false
	AddHUDElement(TextEle) --Adding the element to the HUD

end


function ParameterTextElement(parameters, position, rotation, parent, alignment, stringdefs)

	if stringdefs == txt_70stringdefs then
		textoffset = text70offset
	else
		stringdefs = txt_100stringdefs
		textoffset = text100offset
	end
	
	if alignment == nil then
		alignment = "CenterCenter"
	end
	
	local TextEle					= CreateElement "ceStringPoly"  --Defines what type of element
		TextEle.name				= "TextEle"
		TextEle.material			= HUD_FONT  --For text elements, this is the font definition
		TextEle.init_pos			= {position[1] + textoffset[1], position[2] + textoffset[2]}
		TextEle.init_rot 			= rotation
		TextEle.alignment			= alignment -- "CenterCenter", "LeftCenter", "RightCenter"
		TextEle.stringdefs      	= stringdefs
		TextEle.formats		  		= {"%.0f"}
		--TextEle.value          		= text
		TextEle.element_params 		= parameters
		TextEle.controllers    		= {{"text_using_parameter",0,0}}
		TextEle.parent_element		= parent
		TextEle.UseBackground		= false
	AddHUDElement(TextEle) --Adding the element to the HUD

end



function PitchLadderLine(width, thickness, side, position, rotation, parent)

	local L_bracket = 10 -- Length of L at the end of the lines
	
			local PLvertices = 	{	{-width/2				,	thickness/2},				--0
									{-width/2+thickness		,	thickness/2},				--1
									{width/2				,	thickness/2},				--2
									{width/2				,	-thickness/2},				--3
									{-width/2+thickness		,	-thickness/2},				--4
									{-width/2+thickness		,	-thickness/2-L_bracket},	--5
									{-width/2				,	-thickness/2-L_bracket},	--6
									{-width/2				,	-thickness/2},				--7
								}
						
			local PLindices	= 	{ 	0, 1, 4,
									1, 4, 2,
									2, 3, 4,
									4, 5, 6,
									6, 7, 4,
									4, 7, 0,
								}
								
	if side == "L" then
		rotation = rotation
	elseif side == "R" then
		rotation = {rotation[1], 180}
	end
	
	local   PLline 					= CreateElement "ceMeshPoly"
		PLline.name 				= "PLline"
		PLline.primitivetype 		= "triangles"
		PLline.vertices 			= PLvertices
		PLline.indices  			= PLindices
		PLline.init_pos 			= position
		PLline.init_rot 			= rotation
		PLline.material 			= HUD_GREEN_MAT
		PLline.parent_element		= parent or nil
	AddHUDElement(PLline)

end



function StrokeBox(innerWidth, innerHeight, thickness, position, rotation, parent)

	local L_bracket = 10 -- Length of L at the end of the lines
	
			local BoxVertices = 	{	{-innerWidth/2 - thickness	,	innerHeight/2 + thickness},		--0
										{-innerWidth/2				,	innerHeight/2 + thickness},		--1
										{innerWidth/2				,	innerHeight/2 + thickness},		--2
										{innerWidth/2 + thickness	,	innerHeight/2 + thickness},		--3
										{innerWidth/2 + thickness	,	innerHeight/2},					--4
										{innerWidth/2 + thickness	,	-innerHeight/2},				--5
										{innerWidth/2 + thickness	,	-innerHeight/2 - thickness},	--6
										{innerWidth/2				,	-innerHeight/2 - thickness},	--7
										{-innerWidth/2				,	-innerHeight/2 - thickness},	--8
										{-innerWidth/2 - thickness	,	-innerHeight/2 - thickness},	--9
										{-innerWidth/2 - thickness	,	-innerHeight/2},				--10
										{-innerWidth/2 - thickness	,	innerHeight/2},					--11
										{-innerWidth/2				,	innerHeight/2},					--12
										{innerWidth/2				,	innerHeight/2},					--13
										{innerWidth/2				,	-innerHeight/2},				--14
										{-innerWidth/2				,	-innerHeight/2},				--15
									}
						
			local BoxIndices	= 	{ 	0, 1, 12,
										1, 12, 2,
										2, 3, 4,
										4, 5, 14,
										14, 5, 6,
										6, 14, 7,
										7, 8, 14,
										14, 15, 8,
										8, 9, 10,
										10, 8, 15,
										15, 10, 12,
										12, 10, 11,
										11, 0, 12,
										12, 2, 13,
										13, 2, 4,
										4, 13, 14,
									}
	
	local   Box 				= CreateElement "ceMeshPoly"
		Box.name 				= "Box"
		Box.primitivetype 		= "triangles"
		Box.vertices 			= BoxVertices
		Box.indices  			= BoxIndices
		Box.init_pos 			= position
		Box.init_rot 			= rotation
		Box.material 			= HUD_GREEN_MAT
		Box.parent_element		= parent or nil
	AddHUDElement(Box)

end



function AddFPM(parameters)
	
	local fpm_size = 35/2
	
	local FPM					= CreateElement "ceTexPoly" --Choose from predefined elemenent types. ceTexPoly for textures
		FPM.material			= FPM_Mat --{Filepath, colourdef}
		FPM.name				= "FPM" --element name string
		FPM.tex_coords			= {{0,0},{1,0},{1,1},{0,1}}  --Which part of the TX to use. 0 to 1, with topleft being 0,0. Same order as vertices (clockwise from TL)
		FPM.init_pos			= {0, 0}  --Initial coordinates (positioning) of the tx centre
		FPM.vertices			= {{-fpm_size, fpm_size}, {fpm_size,fpm_size}, {fpm_size,-fpm_size},{-fpm_size, -fpm_size}}  --Actual positioning of each vertex. You can rotate tx by swapping corners. Goes from Top left->tr->br->bl. Use to scale size
		FPM.indices				= {0,1,2, 0,3,2} --Defining the indice number for the vertex pattern (pattern here is standard rectangle pattern)
		FPM.collimated			= true  --Adds collimation effect
		FPM.element_params		= parameters
		FPM.controllers			= { {"move_up_down_using_parameter", 0, 1}, {"move_left_right_using_parameter", 1, 1}}  --Control parameters setup
	AddHUDElement(FPM)

end

--[[
function AddAAPiper(parameters, piper_size)

	local FPM					= CreateElement "ceTexPoly" --Choose from predefined elemenent types. ceTexPoly for textures
		FPM.material			= FPM_Mat --{Filepath, colourdef}
		FPM.name				= "FPM" --element name string
		FPM.tex_coords			= {{0,0},{1,0},{1,1},{0,1}}  --Which part of the TX to use. 0 to 1, with topleft being 0,0. Same order as vertices (clockwise from TL)
		FPM.init_pos			= {0, 0}  --Initial coordinates (positioning) of the tx centre
		FPM.vertices			= {{-fpm_size, fpm_size}, {fpm_size,fpm_size}, {fpm_size,-fpm_size},{-fpm_size, -fpm_size}}  --Actual positioning of each vertex. You can rotate tx by swapping corners. Goes from Top left->tr->br->bl. Use to scale size
		FPM.indices				= {0,1,2, 0,3,2} --Defining the indice number for the vertex pattern (pattern here is standard rectangle pattern)
		FPM.collimated			= true  --Adds collimation effect
		FPM.element_params		= parameters
		FPM.controllers			= { {"move_up_down_using_parameter", 0, 1}, {"move_left_right_using_parameter", 1, 1}}  --Control parameters setup
	AddHUDElement(FPM)

end
--]]

