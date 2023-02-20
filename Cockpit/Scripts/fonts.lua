dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

local ResourcesPath = LockOn_Options.script_path.."../IndicationResources/"

fontdescription = {}

HUD_xsize = 170
HUD_ysize = 170
fontdescription["font_HUD"] = {
	texture    = ResourcesPath.."HUD/ARES_Fonts_Futura.dds",
	size       = {7, 6},
	resolution = {1195, 1024},	
	default    = {HUD_xsize, HUD_ysize},
	chars	   = {

		 [1]   = {symbol['0'], HUD_xsize, HUD_ysize},
		 [2]   = {symbol['1'], HUD_xsize, HUD_ysize},
		 [3]   = {symbol['2'], HUD_xsize, HUD_ysize},
		 [4]   = {symbol['3'], HUD_xsize, HUD_ysize},
		 [5]   = {symbol['4'], HUD_xsize, HUD_ysize},
		 [6]   = {symbol['5'], HUD_xsize, HUD_ysize},

		 [7]   = {symbol['6'], HUD_xsize, HUD_ysize},
		 [8]   = {symbol['7'], HUD_xsize, HUD_ysize},
		 [9]   = {symbol['8'], HUD_xsize, HUD_ysize},
		 [10]  = {symbol['9'], HUD_xsize, HUD_ysize},
		 [11]  = {symbol[' '], HUD_xsize, HUD_ysize},
		 [12]  = {latin['A'], HUD_xsize, HUD_ysize},

		 [13]  = {latin['B'], HUD_xsize, HUD_ysize},
		 [14]  = {latin['C'], HUD_xsize, HUD_ysize},
		 [15]  = {latin['D'], HUD_xsize, HUD_ysize},
		 [16]  = {latin['E'], HUD_xsize, HUD_ysize},
		 [17]  = {latin['F'], HUD_xsize, HUD_ysize},
		 [18]  = {latin['G'], HUD_xsize, HUD_ysize},

		 [19]  = {latin['H'], HUD_xsize, HUD_ysize},
		 [20]  = {latin['I'], HUD_xsize, HUD_ysize},
		 [21]  = {latin['J'], HUD_xsize, HUD_ysize},
		 [22]  = {latin['K'], HUD_xsize, HUD_ysize},
		 [23]  = {latin['L'], HUD_xsize, HUD_ysize},
		 [24]  = {latin['M'], HUD_xsize, HUD_ysize},

		 [25]  = {latin['N'], HUD_xsize, HUD_ysize},
		 [26]  = {latin['O'], HUD_xsize, HUD_ysize},
		 [27]  = {latin['P'], HUD_xsize, HUD_ysize},
		 [28]  = {latin['Q'], HUD_xsize, HUD_ysize},
		 [29]  = {latin['R'], HUD_xsize, HUD_ysize},
		 [30]  = {latin['S'], HUD_xsize, HUD_ysize},

		 [31]  = {latin['T'], HUD_xsize, HUD_ysize},
		 [32]  = {latin['U'], HUD_xsize, HUD_ysize},
		 [33]  = {latin['V'], HUD_xsize, HUD_ysize},
		 [34]  = {latin['W'], HUD_xsize, HUD_ysize},
		 [35]  = {latin['X'], HUD_xsize, HUD_ysize},
		 [36]  = {latin['Y'], HUD_xsize, HUD_ysize},
		 
		 [37]  = {latin['Z'], HUD_xsize, HUD_ysize},
		 [38]  = {symbol['+'], HUD_xsize, HUD_ysize},
		 [39]  = {symbol['-'], HUD_xsize, HUD_ysize},
		 [40]  = {symbol['/'], HUD_xsize, HUD_ysize},
		 [41]  = {symbol['\\'], HUD_xsize, HUD_ysize},
		 [42]  = {symbol['|'], HUD_xsize, HUD_ysize},


	}
}