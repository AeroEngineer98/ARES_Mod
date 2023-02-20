
dofile(LockOn_Options.script_path.."fonts.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

local ResourcesPath = LockOn_Options.script_path.."../IndicationResources/"


----Colors--------------------------------
HUD_GREEN_COLOR = {3, 252, 111, 255}
------------------------------------------

HUD_GREEN_MAT			= MakeMaterial(nil,HUD_GREEN_COLOR)
FPM_Mat					= MakeMaterial(ResourcesPath.."HUD/FPM.dds", HUD_GREEN_COLOR) --{ResourcesPath.."FPM.dds", HUD_GREEN_COLOR}

-------MATERIALS-------
materials = {}
materials["HUD_GREEN_COLOR"]    = HUD_GREEN_COLOR




