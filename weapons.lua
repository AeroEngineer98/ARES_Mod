function M61A1_gun(tbl)

		tbl.category = CAT_GUN_MOUNT
		tbl.name      = "M61A1"
		tbl.supply      =
		{
			shells = {"M61_20_HE_gr", "20x110mm AP-I", "20x110mm AP-T"},
			mixes  = {
				{1,2,1,3},
				{1,1,1,1,1,3},
				{3},
			},   -- 50% HE-i, 25% AP-I, 25% AP-T
			count  = 2000,
		}
		if tbl.mixes then
		   tbl.supply.mixes = tbl.mixes
		   tbl.mixes        = nil
		end
		tbl.gun =
		{
			max_burst_length    = 100000,
			rates               = {6000},
			recoil_coeff        = 0.7*1.3,
			barrels_count       = 1,
		}
		if tbl.rates then
		   tbl.gun.rates        =  tbl.rates
		   tbl.rates            = nil
		end
		tbl.ejector_pos             = tbl.ejector_pos or {0, 0, 0}
		tbl.ejector_pos_connector   = tbl.ejector_pos_connector     or  "Gun_point"
		tbl.ejector_dir             = {-1, -6, 0} -- left/right; back/front;?/?
		tbl.supply_position         = tbl.supply_position   or {0,  0.3, -0.3}
		tbl.aft_gun_mount           = false
		tbl.effective_fire_distance = 1500
		tbl.drop_cartridge          = 204
		tbl.muzzle_pos              = tbl.muzzle_pos            or  {0,0,0}     -- all position from connector
		tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
		tbl.azimuth_initial         = tbl.azimuth_initial       or  0
		tbl.elevation_initial       = tbl.elevation_initial     or  0
		if  tbl.effects == nil then
			tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
						   { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
						   { name = "SmokeEffect"}}
		end
		return declare_weapon(tbl)
	end
	
	
	function GAU8_gun(tbl)

		tbl.category = CAT_GUN_MOUNT
		tbl.name      = "Gau_8"
		tbl.supply      =
		{
			shells = {"GAU8_30_AP", "GAU8_30_HE", "GAU8_30_TP"},
			mixes  = {
				{1,2,1,3},
				{1,1,1,1,1,3},
				{3},
			},   -- 50% HE-i, 25% AP-I, 25% AP-T
			count  = 3600,
		}
		if tbl.mixes then
		   tbl.supply.mixes = tbl.mixes
		   tbl.mixes        = nil
		end
		tbl.gun =
		{
			max_burst_length    = 100000,
			rates               = {3600},
			recoil_coeff        = 0.8,
			barrels_count       = 1,
		}
		if tbl.rates then
		   tbl.gun.rates        =  tbl.rates
		   tbl.rates            = nil
		end
		tbl.ejector_pos             = tbl.ejector_pos or {0, 0, 0}
		tbl.ejector_pos_connector   = tbl.ejector_pos_connector     or  "Gun_point"
		tbl.ejector_dir             = {-1, -6, 0} -- left/right; back/front;?/?
		tbl.supply_position         = tbl.supply_position   or {0,  0.3, -0.3}
		tbl.aft_gun_mount           = false
		tbl.effective_fire_distance = 1500
		tbl.drop_cartridge          = 204
		tbl.muzzle_pos              = tbl.muzzle_pos            or  {0,0,0}     -- all position from connector
		tbl.muzzle_pos_connector    = tbl.muzzle_pos_connector  or  "Gun_point" -- all position from connector
		tbl.azimuth_initial         = tbl.azimuth_initial       or  0
		tbl.elevation_initial       = tbl.elevation_initial     or  0
		if  tbl.effects == nil then
			tbl.effects = {{ name = "FireEffect"     , arg = tbl.effect_arg_number or 436 },
						   { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
						   { name = "SmokeEffect"}}
		end
		return declare_weapon(tbl)
	end