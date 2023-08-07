# DCS World Scaled Composites ARES

I took this format from the community A-29 Super Tucano. From that Readme:

"This is a free, open source, SFM, A-29B independent module for DCS World. By independent it is meant that it does not require any other modules to work.
The development is in a very early stage, but the author has decided on releasing it in hopes it will help others on the implementation of modern aircraft systems using SFM.
All aircraft systems are implemented in Lua and can be freely used in other non-paid DCS World Modules."

This mod is my first foray into the modding world of DCS. I've created the 3D model from a 3-view posted to Facebook from Scaled, plus my own experiences with the airplane.

### A-29 Contributors
- Renault, Milaré, PaKo, Malamem, Athos, Dino, Jorge Rodrigues, Paoladelf, Farias, Skypork, CubeBoy, Rudel_chw, EDAV, Urbi, and many others.
### ARES Contributers
- Andrew Barth
- Darrent Turner (Flight Test)
- Jake Rabideau (Flight Test)

### August 6, 2023 Commit
- Added a weapons panel
- Changed the guns handdling to be through the weapons system lua script
- Added the ability to release bombs and missiles, though there's no targeting ability with any yet
- Moved the cockpit 5" aft toward the pilot


### February 24, 2023 Commit
- Added liveries! ARES can now have the Iron Eagle III livery
- Upgraded the standard "Blue Swoosh" livery
- Updated some missions


### February 19, 2023 Commit
- Upgraded the HUD which now has a flight path marker, airpseed, and altitude.
- Changed the HUD font to be a Futura-based font with a custom texture file
- Removed much of the flight controls logic in the flight model to better approximate a reversible-controls aircraft
- Changed the flight model to inclue N1, N2, and better thrust modeling so I can add N1 and N2 gauges that look more realistic


### February 17, 2023 Commit
- Added a HUD that shows a very basic pitch ladder. A big win!


### February 10, 2023 Commit
- Added a clickable gear handle
- Added gear and speedbrake indicators
- Added a day/night dimmer switch
- Added more working instruments
- Textured the instruments
- Figured out that in order for click commands to work, they must go through the EFM


### January 29, 2023 Commit
- Added more instruments
- Added textures to airspeed indicator
- Added a weapons system that auto-enables at startup with a gun from the A-4C mod


### January 22, 2023 Commits
- New cockpit layout established
- New placeholder cockpit textures


### January 21, 2023 Commits
- Firtst commit with a working cockpit gauge by passing data from the flight model to the lua scripts


### January 20, 2023 Commit
- Removed a lot of extra cockpit scripts that were unused and left-over from the A-29


### January 18, 2023 Commit
- Added a LOD file in order to add a collision mesh
- Added a "Suspension.lua" file for keeping track of suspension terms


### January 15, 2023 Commit
- Separated the cockpit model from the rest of the plane for future cockpit work
- Moved the viewpoint to be realistic - could still move forward a bit more.
- Retextured the cockpit with Zolatone!


### Initial Commit - January 14, 2023
- Changed from a simple flight model (SFM) to an external flight model (EFM) using IGServal's "Basic-custom-flight-model-for-DCS-World-main" flight model. Animations are either spotty or don't work, and there's too much stuff that's not applicable to ARES that's still in the mod.