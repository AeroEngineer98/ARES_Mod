--dofile(LockOn_Options.script_path.."Systems/HUD/Units.lua")
dofile(LockOn_Options.script_path.."Systems/HUD/Indicator/definitions.lua")



--local MARK_MATERIAL   = MakeMaterial(nil,{255,120,0,255})
RS = HUD_SCALE



ud_scale 	= 0.00001 * 0.9		* RS	--0.00001
lr_scale 	= 0.095	  * 0.9	*2	* RS	--0.2		--0.085
life_time 	= 10			--1
life_time_low = 0


-------------------------------------------------------------
SetScale(MILLYRADIANS)


-- Create Center Mark
makeStaticLine(20, 1, {0,5*30/45*Deg_to_MR}, {0}) -- Center Mark H Line
makeStaticLine(20, 1, {0,5*30/45*Deg_to_MR}, {90}) -- Center Mark V Line


HUD_Static_base             	= CreateElement "ceSimple"
HUD_Static_base.name			= "HUD_Static_base"
HUD_Static_base.collimated 	= true
Add(HUD_Static_base)


HUD_Ind_base             	= CreateElement "ceSimple"
HUD_Ind_base.name			= "HUD_Ind_base"
HUD_Ind_base.init_pos		= {0, -1*Deg_to_MR}  --Initial coordinates (positioning) of the tx centre
HUD_Ind_base.element_params = {"H_SHIFT_HUD", "V_SHIFT_HUD", "ROLL_HUD"}  --Parameters that are controlling the element
HUD_Ind_base.controllers    = {{"move_up_down_using_parameter", 1, -1}, {"move_left_right_using_parameter", 0, 1}, {"rotate_using_parameter", 2, 1}} -- type of transformation, parameter index in "element_params", control ratio
HUD_Ind_base.collimated 	= true
Add(HUD_Ind_base)


local showHUD = true

if showHUD then

	

	LineThickness = 1.5
	HLineW = 150
	PLTensW = 130
	PLFivesW = 80
	PLGap = 40
	PLOneW = PLGap + LineThickness*2

	PLOnesOn = true
	
	local PL_String_def = txt_70stringdefs
	local IND_String_def = txt_100stringdefs
	
	makeHLine((HLineW-PLGap)/2, LineThickness, {(HLineW+PLGap)/4, 0}, {0}, "HUD_Ind_base") -- 10 deg up line right
	makeHLine((HLineW-PLGap)/2, LineThickness, {-(HLineW+PLGap)/4, 0}, {0}, "HUD_Ind_base") -- 10 deg up line left
	
	ConstantTextElement(0, {HLineW/2 + 15, 0}, {0}, "HUD_Ind_base", nil, PL_String_def)
	ConstantTextElement(0, {-HLineW/2 - 15, 0}, {0}, "HUD_Ind_base", nil, PL_String_def)
	



	for pitchI = -90,90 do

		local pitchIRotate = 0
		local sideL = "L"
		local sideR = "R"
		
		if pitchI < 0 then
			pitchIRotate = 180
			sideL = "R"
			sideR = "L"
		end
		
		if math.fmod(pitchI, 10) == 0 and pitchI ~= 0 and pitchI < 90 and pitchI > -90 then
			PitchLadderLine((PLTensW-PLGap)/2, LineThickness, sideR, {(PLTensW+PLGap)/4,pitchI*Deg_to_MR}, {pitchIRotate}, "HUD_Ind_base") -- 10 deg up line right
			PitchLadderLine((PLTensW-PLGap)/2, LineThickness, sideL, {-(PLTensW+PLGap)/4,pitchI*Deg_to_MR}, {pitchIRotate}, "HUD_Ind_base") -- 10 deg up line left
			ConstantTextElement(pitchI, {PLTensW/2 + 15, pitchI*Deg_to_MR}, {0}, "HUD_Ind_base", nil, PL_String_def)
			ConstantTextElement(pitchI, {-PLTensW/2 - 15, pitchI*Deg_to_MR}, {0}, "HUD_Ind_base", nil, PL_String_def)
			
		elseif math.fmod(pitchI, 5) == 0 and pitchI ~= 0 and pitchI <= 60 and pitchI >= -60 then
			makeHLine((PLFivesW-PLGap)/2, LineThickness, {(PLFivesW+PLGap)/4,pitchI*Deg_to_MR}, {0}, "HUD_Ind_base") -- 10 deg up line
			makeHLine((PLFivesW-PLGap)/2, LineThickness, {-(PLFivesW+PLGap)/4,pitchI*Deg_to_MR}, {0}, "HUD_Ind_base") -- 10 deg up line
			ConstantTextElement(pitchI, {PLFivesW/2 + 15, pitchI*Deg_to_MR}, {0}, "HUD_Ind_base", nil, PL_String_def)
			ConstantTextElement(pitchI, {-PLFivesW/2 - 15, pitchI*Deg_to_MR}, {0}, "HUD_Ind_base", nil, PL_String_def)
		
		elseif PLOnesOn and math.fmod(pitchI, 1) == 0 and pitchI ~= 0 and pitchI <= 60 and pitchI >= -60 then
			makeHLine((PLOneW-PLGap)/2, LineThickness, {(PLOneW+PLGap)/4,pitchI*Deg_to_MR}, {0}, "HUD_Ind_base") -- 10 deg up line
			makeHLine((PLOneW-PLGap)/2, LineThickness, {-(PLOneW+PLGap)/4,pitchI*Deg_to_MR}, {0}, "HUD_Ind_base") -- 10 deg up line
		end

	end


	-- 90 deg Crosses
	makeHLine(100, 2, {0,-90*Deg_to_MR}, {45}, "HUD_Ind_base") -- 90 deg down line
	makeHLine(100, 2, {0,-90*Deg_to_MR}, {-45}, "HUD_Ind_base") -- 90 deg down line

	makeHLine(100, 2, {0,90*Deg_to_MR}, {0}, "HUD_Ind_base") -- 90 deg up line
	makeHLine(100, 2, {0,90*Deg_to_MR}, {90}, "HUD_Ind_base") -- 90 deg up line
	
	
	-- Airspeed Indicator
	StrokeBox(50, 18, 1.5, {-140,50}, {0}, "HUD_Static_base")
	ParameterTextElement({"AIRSPEED_KIAS_HUD"}, {-120, 50}, {0}, "HUD_Static_base", "RightCenter", IND_String_def)


	-- Altimeter
	StrokeBox(60, 18, 1.5, {145,50}, {0}, "HUD_Static_base")
	ParameterTextElement({"ALTITUDE_FT_HUD"}, {170, 50}, {0}, "HUD_Static_base", "RightCenter", IND_String_def)

end




AddFPM({"AOA_HUD","AOS_HUD"})
--makeParamLine({"AOA_HUD","AOS_HUD",nil}, 50, 2, {0,0}, {0}, "HUD_Static_base")
--makeParamLine({"AOA_HUD",nil,nil}, 50, 2, {0,0}, {90}, "HUD_Static_base")