local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices                     = {}
devices["ELECTRIC_SYSTEM"]  = counter() --1	-- Electrical system is needed for flight controls
devices["AVIONICS"]  = counter() --2	-- Avionics system to control gauges
devices["GEAR"]  = counter() --2	-- Gear system to interface with clicks and EFM

