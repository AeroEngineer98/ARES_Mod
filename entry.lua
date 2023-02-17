local self_ID  = "ARES" 

-- DCS WORLD Convention:
-- Xbody: Out the front of the nose
-- Ybody: Out the top of the aircraft
-- Zbody: Out the right wing

local _spring_force_multiplier = 10
local _static_multiplier = 10
local _friction_multiplier = 1
local _roll_friction_multiplier = 1
local _damage_multiplier = 12

declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
displayName     = _("ARES"),
developerName   =   "A. Barth",
version		 = "pre-alpha",
state		 = "installed",
info		 = _("ARES"),
binaries	= { 'Custom_FM', },  -- The DLL of the external flight model 


InputProfiles =
{
    ["ARES"] = current_mod_path .. '/Input/ARES',
},

Skins	=
	{
		{
			name	= _("ARES with EFM"), -- Mod title in bottom banner on startup
			dir		= "Theme"
		},
	},

Missions =
	{
		{
			name		= _("ARES"), -- Title in Instant Action
			dir			= "Missions",
		},
	},


LogBook =
	{
		{
			name		= _("Model 151 ARES"), -- Title of entry in logbook
			type		= "ARES",
		},
	},		
})


mount_vfs_texture_path  (current_mod_path ..  "/Theme/ME")--for simulator loading window
mount_vfs_texture_path  (current_mod_path ..  "/Textures/ARES")
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures")
mount_vfs_model_path    (current_mod_path ..  "/Shapes")

dofile(current_mod_path..'/ARES.lua')

dofile(current_mod_path..'/Entry/suspension.lua')


local FM = 
{
	[1] = self_ID,
	[2] = "Custom_FM",
	center_of_mass		=	{ 0.183 , 0.261 , 0.0},		-- center of mass position relative to object 3d model center for empty aircraft
	moment_of_inertia  	= 	{12874.0, 85552.1, 75673.6},   	-- moment of inertia of empty aircraft
	suspension   = suspension, -- gear posts initialization
} 


----------------------------------------------------------------------------------------
make_flyable('ARES', current_mod_path..'/Cockpit/Scripts/', FM, current_mod_path..'/comm.lua')
----------------------------------------------------------------------------------------
plugin_done()
