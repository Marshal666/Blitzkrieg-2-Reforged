Blitzkrieg II
==========================================================================
WIP version (v0.3.10)
March 5th, 2005
Blitzkrieg II Copyright (c) 2003-2005 Nival Interactive
==========================================================================

1. Known issues

- We are still using Russian voiceover for German and American units right now. This will be change to appropriate voiceover later on.

- Some particle effects got corrupted, for example, dust behind moving vehicles is oversaturated

==========================================================================
2. What is New

2.1 March 5th, 2005 version (0.3.10)

Map Design:
- All missions in German campaign are created and can be played through (beta quality)

- All missions in US campaign are created except US2.3, US2.4, US2.5, US3.0, chapter US1 can be played through (beta quality)

- The following missions in Russian campaign are created but not finalized:
RUS1.0-RUS1.4, RUS2.1-RUS2.6

- All missions in chapters GER1 and GER2 are well balanced (final quality)

- New multiplayer map is designed and can be used for testing

General Gameplay:

- Difficulty level of all missions is significantly lowered

AI:

- Pathfinding is significantly improved

- Small objects such as trees and bushed don't block LOS any more

User Interface:

- Final in-mission is implemented

- Chapter map interface is still getting improved (not final yet)

Text work:

- GER1 and GER2 chapters have final texts

Voiceover:

- Final Russian voiceover is in the game

2.2 February 8th, 2005 version (0.3.9)

2.3 December 21st, 2004 version (0.3.8)

Map Design:

- All missions in GB3 chapter are redesigned to make the battles more massive and create the feeling of war going on around the player by putting allied forces on the map.

- Missions in GB3 chapter are well balanced

- The following missions from German campaign are created, but not finalized:
GER1.0-GER1.4 (map 974, 921, 935, 939, 955)
GER2.1-GER2.4 (map 1008, 1009, 1010, 1011)
GER3.1, GER3.2, GER3.4, GER3.4 (map 947, 953, 1001, 1017)
GER4.1-GER4.6 (map 982, 990, 1005, 1007, 1019, 1027)

- The following missions from US campaign are created, but not finalized:
US1.0-US1.4 (map 956, 944, 946, 980, 984)
US3.1-US3.5 (map 987, 993, 1006, 1018, 1029)
US4.3-US4.6 (map 932, 969, 971, 936)

General Gameplay:

- Design and implementation of commanders in order to personify units

- Redesign and implementation of in-mission notification system

AI:

- A problem with planes flying partially inside each other was solved; they can still intersect briefly, but they don't fly close to each other any more

User Interface:

- Chapter map is completely redesigned to be more visually appealing and easier to understand.

- Implementation of Army interface with commanders functionality

- Improvements in PWL screen to reach the final quality

Graphics:

- Buttons and icons improvements to show the final quality

Balancing:

- Close to final balancing of unit “triangles” (rock-paper-scissors)


2.4 October 15th, 2004 version (0.3.7)

Map Design:

- Three large missions GB1.0, GB3.0, and GB4.0 are fully designed, scripted and tested

- Eighteen small missions are fully designed, scripted and tested

- The entire Great Britain campaign can be played through and completed. The campaign has draft balance.

- One 2 by 2 multiplayer map is designed and tested (Autumn_4players_8X8)

General Gameplay:

- Recommended number of reinforcements for small missions is changed to strict limitation of maximum reinforcements per mission

AI:

- Several pathfinding problems were fixed

User Interface:

- Final art is in place for all single player interfaces and several multiplayer screens

- Multiplayer interfaces for Nival.net custom game are implemented

Multiplayer: 

- Multiplayer is functional for up to 2 by 2 custom game (this is map limitation) played through Nival.net master Server

- Master server is up and running, all beta testers' accounts are registered in the database and can be used

Graphics:

- Significant number of icons is redrawn; new intermission interfaces created

- New chapter maps are created for Great Britain campaign

- Draft background scene for intermission menus is created


2.5 July 29th, 2004 Version (0.3.6)

Map Design:

- Six small missions GB2.1, GB2.2, GB2.3, GB2.4, GB2.5, and GB2.6 were fully designed, scripted and tested. 

- The entire chapter GB2 can be played through and completed. The balance is still far from being final. The chapter map, the location of missions and mission texts are preliminary.

General Gameplay:

- Chapter level gameplay was slightly simplified. Now mission bonuses affect all other missions in chapter. All mission bonuses can be seen on chapter map interface. Available and not available reinforcements for each mission can be observed.

User Interface:

- New in-mission user interface was implemented and redrawn. The changes include rotatable minimap, new shortcut mapping (classic RTS layout), new reinforcement panel, buttons for selecting aircrafts, etc.

- New chapter map user interface was designed and implemented. It reflects the simplified concept of chapter level gameplay now.

Graphics:

- Graphical problems on GeForce 2 class video cards were fixed.

Multiplayer:

- Nival server based multiplayer is relatively stable now; the multiplayer game can be started, joined and played for several minutes without going out of sync.


2.6 July 8th, 2004 Version

Map Design:

- Final mission for second British chapter GB2.0 was designed, scripted and tested

- Six small mission placeholders GB2.1, GB2.2, GB2.3, GB2.4, GB2.5, and GB2.6 were placed in second British chapter. Three of them have to be completed in order to open the final mission. They are designed to auto-win immediatelly.

Graphics:

- All settings and seasons were completed.

- Models and textures for all units, soldiers, buildings, trees and other objects were finished.

Low Level AI:

- Some additional improvements in pathfinding and pathtracking. Units are now less likely to intersect with other units and objects, but some minor problems still exist.

High Level AI:

- AI General is fine-tuned

General Gameplay:

- Chapter map gameplay is implemented; reinforcements can be set for each mission plus starting reinforcements for chapter; bonuses for each mission can be set and they influence other missions.


2.7 April 15th, 2004 Version

Map Design:

- Existing Final Alpha mission was redesigned to make it more simple and linear and to include more Wow-factors. Mission objectives were changed, second infantry landing was eliminated to avoid the problem with 2 starting points, Erebus bombardment was added as the main Wow-factor at the beginning of the mission. Key buildings are clearly marked and described now. 

- British troops were replaced with American in the Final Alpha mission.

- New E3 Demo mission was added. It uses Africa setting and is set at night. This mission was designed to be a very short tutorial mission for the demo to be played before the Final Alpha mission. The goal of this mission is to familiarize a regular RTS player with Blitzkrieg II environment.

Graphics:
- Africa setting is complete.

- Night illumination model is complete and used in first E3 Demo mission.

Low Level AI:
- Some serious problems with pathtracking were fixed. Units were not able to reach destination in some cases and were not moving in groups correctly. There are still some problems with units not driving into tight places that will be fixed shortly. 

- Fixed the problem with planes flying through high hills and buildings. Now airplanes are following the terrain and trying to avoid colliding with it.

High Level AI:
- AI General can call in reinforcements now.

- AI General uses counter-artillery fire now.

- AI General attacks strategic buildings.

General Gameplay:
- Strategic buildings are implemented.

- Reinforcement system is functional.

- Objectives can be obtained, displayed, and completed.

- Scenario system is implemented, chapter map is functional.

- 12 types of units are functional: infantry, special ops infantry, tanks, tank destroyers, engineer trucks, tow trucks, long range artillery, AT guns, AA guns, fighters, ground attack planes, landing boats. Bombers, recon plane, paratroopers, torpedo boats and trains are under development.

Interfaces:
- In-game interface is fully functional, although some changes are necessary.

- Intermission interface is complete with exception of multiplayer interfaces.

Multiplayer:
- Basic functionality of Master Server is implemented, such as login, account support, password support, custom game hosting and joining, chat, etc.

- Multiplayer game for 2 players can be created and joined, but out-of-sync happens right away. Out-of-sync problems will be fixed later when AI is stable enough.

Resource Editor:
- All required functionality for maps mass-production is implemented. Resource Editor still required database support to be installed that will be removed in the final version.

Known problems:
- The American mission will not switch into demo mode if the analogue joystick or gamepad is connected.

==========================================================================
3. System Requirements

Minimal configuration:
Windows 98/ME/2000/XP, DirectX 9.0
Pentium III / Athlon 1000MHz, 256 MB RAM
GeForce2 class 3D graphics accelerator, 32 MB video RAM
Monitor capable of supporting 800x600 resolution
DirectX compatible sound card, mouse
HDD with 1.4 GB of free space.

Recommended configuration for optimal performance and high quality graphics:
Windows 98/ME/2000/XP, DirectX 9.0
Pentium IV / Athlon 2GHz, 256 MB RAM
GeForce3 class 3D graphics accelerator, 64 MB video RAM
Monitor capable of supporting 1024x768 resolution
DirectX compatible sound card, mouse
HDD with 1.4 GB of free space.

==========================================================================
4. In-game Controls

select unit or perform action	=> Left Mouse Button
perform default action		=> Right Mouse Button
exit 				=> LAlt+Q or Alt+F4
pause				=> Space
increase game speed		=> Num Plus
decrease game speed		=> Num Minus
pause				=> Spacebar or Pause
take screenshot			=> PrintScreen
assign group			=> Ctrl+0 - Ctrl+9
select group			=> 0 - 9
select next subgroup		=> Tab
open/close ESC menu		=> Esc
camera move forward		=> Up
camera move backward		=> Down
camera move left		=> Left
camera move right		=> Right
camera pitch			=> Ctrl+Up/Down
camera yaw			=> Ctrl+Left/Right
camera zoom in			=> PageUp
camera zoom out			=> PageDown
show fire ranges		=> Alt+R
quick save			=> LAlt+F7
quick load			=> LAlt+F8
open/close console		=> ~
toggle show interface 		=> LCtrl+LShift+I
toggle wireframe mode 		=> LCtrl+LShift+W
toggle fog of war		=> LCtrl+LShift+Q
toggle AI passability		=> LCtrl+LShift+A
toggle show mipmap		=> LCtrl+LShift+M
toggle show statistics		=> LCtrl+LShift+F
toggle show overdraw		=> LCtrl+LShift+O
toggle shot bounding boxes	=> LCtrl+LShift+B
toggle objective list 		=> O
toggle reinforcement mode	=> I

==========================================================================
5. Cheat Codes

Open console by pressing "~" key then type the following cheat codes and press "Enter":
@Win(0,1)			=> Automatically win current mission
@God(0,1)			=> Set invincibility mode (no damage to player units)
@God(0,2)			=> Set full God Mode (no damage to player units and every shot they make kills enemy)
@God(0,0)			=> Turns off God Mode

==========================================================================
6. Screenshots

Screenshots can be taken by pressing PrintScreen key. They can be found in \data\screenshots folder. It is recommended to turn off fog of war (LCtrl+LShift+Q) and interface (LCtrl+LShift+I) before taking screenshots.

==========================================================================
7. Developers feedback

Nival Interactive
http://www.nival.com
Project Manager: George Ossipov george.ossipov@nival.com
Assistant Project Manager: Alexander Veselov alexander.veselov@nival.com
