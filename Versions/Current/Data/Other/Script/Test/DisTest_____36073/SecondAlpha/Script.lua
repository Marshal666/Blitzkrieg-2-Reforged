-- deploy templates id consts
Deploy_Tanks = 9;
Deploy_MainInf = 11;
Deploy_TD = 10;
Deploy_GA = 12;
Deploy_Fighters = 13;
Deploy_Artillery = 14;
Deploy_HeavyArtillery = 15;
Deploy_AssaultSPG = 17;
Deploy_LightTanks = 19;
Deploy_AssaultInf = 18;
Deploy_SingleShip = 20;

-- player reinf id consts
Reinf_Player_Tanks = 65; -- was 59
Reinf_Player_Artillery = 48;
Reinf_Player_MainInf = 57;
Reinf_Player_HeavyArtillery = 55;
Reinf_Player_Fighters = 53;
Reinf_Player_GA = 54;
Reinf_Player_TD = 58;
Reinf_Player_AssaultInf = 49;
Reinf_Player_AssaultSPG = 50;
Reinf_Player_LightTanks = 56;
Reinf_Player_TransportShip = 109;

Reinf_Allies_GA = 121;
Reinf_Allies_MainInf = 120;
Reinf_Allies_TD = 119;
Reinf_Allies_Tanks = 118;

Point_GA = 1;
Point_Fighters = 2;
Point_Bombers = 3;
Point_Paratroops = 4;
Point_Tanks = 5;
Point_LightTanks = 6;
Point_AssaultGuns = 7;
Point_TD = 8;
Point_Artillery = 9;
Point_HeavyArtillery = 10;
Point_MainInf = 11;
Point_AssaultInf = 12;

Tanks, TD, MainInf, Artillery, HeavyArtillery, Fighters, GA = 1, 2, 3, 4, 5, 6, 7;

ReinfIDs = { Reinf_Player_Tanks, Reinf_Player_TD, Reinf_Player_MainInf, Reinf_Player_Artillery, Reinf_Player_HeavyArtillery, Reinf_Player_Fighters, Reinf_Player_GA };
DeployIDs = { Deploy_Tanks, Deploy_TD, Deploy_MainInf, Deploy_Artillery, Deploy_HeavyArtillery, Deploy_Fighters, Deploy_GA };

-- enemy reinf id consts
Reinf_Enemy_Tanks = 67;
Reinf_Enemy_TD = 69;
Reinf_Enemy_MainInf = 72;
Reinf_Enemy_GA = 75;
Reinf_Enemy_Fighters = 76;
Reinf_Enemy_AssaultInf = 68;
Reinf_Enemy_Artillery = 66;
Reinf_Enemy_HeavyArtillery = 71;
Reinf_Enemy_LightTanks = 70;
Reinf_Enemy_AssaultSPG = 77;


-- map objects scriptid
Tank_ScriptId = 100;
Radar_ScriptId = 501;
Docks_ScriptId = 502;
Station_ScriptId = 503;
Saboteur_ScriptId = 10;
Bridge_ScriptId = 200;
Barrels_ScriptId = 505;
Warehouse_ScriptId = 506;
Town_Units_ScriptId = 504;
Artillery_ScriptId = 510;
Barrels_Total = GetNUnitsInScriptGroup( Barrels_ScriptId );
Warehouses_Total = GetNUnitsInScriptGroup( Warehouse_ScriptId );
Town_Units_Total = GetNUnitsInScriptGroup( Town_Units_ScriptId, 2 );

Keybuildings = {};
Keybuildings[501] = 2;
Keybuildings[502] = 2;
Keybuildings[503] = 2;

-- other
MINRADIUS = 50;
SIGHTRANGE = 37 * 32;
RADIUS = 512;
DISPERSION = 1024;
delay_attacks = 0;
stop_attacks = 0;
stop_allies_attacks = 0;
reinf_called = 0;
player_called_aviation = 0;
planes = {};
planes2 = {};
missionend = 0;
objective12given = 0;
stop_attacks_ai = 0;
truck_hp = 40;
gun_hp = 50;

DeployTable = {};
DeployTable[ Reinf_Player_Tanks ] = Deploy_Tanks;
DeployTable[ Reinf_Player_Artillery ] = Deploy_Artillery;
DeployTable[ Reinf_Player_MainInf ] = Deploy_MainInf;
DeployTable[ Reinf_Player_HeavyArtillery ] = Deploy_HeavyArtillery;
DeployTable[ Reinf_Player_Fighters ] = Deploy_Fighters;
DeployTable[ Reinf_Player_GA ] = Deploy_GA;
DeployTable[ Reinf_Player_TD ] = Deploy_TD;
DeployTable[ Reinf_Player_AssaultInf ] = Deploy_AssaultInf;
DeployTable[ Reinf_Player_AssaultSPG ] = Deploy_AssaultSPG;
DeployTable[ Reinf_Player_LightTanks ] = Deploy_LightTanks;

PointsTable = {};
PointsTable[ Reinf_Player_Tanks ] = 1;
PointsTable[ Reinf_Player_Artillery ] = 2;
PointsTable[ Reinf_Player_MainInf ] = 5;
PointsTable[ Reinf_Player_HeavyArtillery ] = 6;
PointsTable[ Reinf_Player_Fighters ] = 3;
PointsTable[ Reinf_Player_GA ] = 4;
PointsTable[ Reinf_Player_TD ] = 7;
PointsTable[ Reinf_Player_AssaultInf ] = 10;
PointsTable[ Reinf_Player_AssaultSPG ] = 9;
PointsTable[ Reinf_Player_LightTanks ] = 8;


function Tanks_Start_Movement()
	Trace("Tanks_Start_Movement");
	Wait( 60 );
	CmdMultiple( ACT_MOVE, Tank_ScriptId, GetScriptAreaParams( "P" .. 1 ) );
	--Cmd( ACT_MOVE, MotorCycleId, GetScriptAreaParams( "P" .. 1 ) );
	for i = 2, 20 do
		QCmdMultiple( ACT_MOVE, Tank_ScriptId, GetScriptAreaParams( "P" .. i ) );
		--QCmd( ACT_MOVE, MotorCycleId, GetScriptAreaParams( "P" .. i ) );
	end;

end;

function Smart_Attack( group, endx, endy )
--local x, y = GetScriptAreaParams( "Landing_Zone" );
local x, y;
local startx, starty = GetObjCoordMedium( group );
local attackvector = { x = endx - startx, y = endy - starty };
local dirvector = {};
local l = len( attackvector.x, attackvector.y );
local resultvector = {};
local tangent = RandomFloat() * 0.2 + 0.6;
local normal = RandomFloat() * 0.25 + 0.1;
--	dirvector = norm( attackvector );
--	Trace("dirvector %g %g", dirvector.x * 1000, dirvector.y * 1000 );
--	resultvector.x = dirvector.x * tangent * l;
--	resultvector.y = dirvector.y * tangent * l;
--	dirvector = rot90( dirvector, 1 );
--	Trace("dirvector %g %g", dirvector.x * 1000, dirvector.y * 1000 );
--	resultvector.x = resultvector.x + dirvector.x * normal * l;
--	resultvector.y = resultvector.y + dirvector.y * normal * l;
--	x, y = resultvector.x + startx, resultvector.y + starty;
--	Trace("resultvector = %g, %g", x, y );
--	CmdArrayDisp( ACT_SWARM, group, 256, x, y );
--	QCmdArrayDisp( ACT_SWARM, group, 256, endx, endy );
	CmdArrayDisp( ACT_SWARM, group, 300, endx, endy );
	WaitForArrayAtPosition( group, endx, endy, 450 );
	Wait( 5 );
	CmdArray( ACT_ENTRENCH, group );
end;

function Town3Patrol( group )
	while ( NumUnitsAliveInArray( group ) > 0 ) do
		CmdArrayDisp( ACT_SWARM, group, DISPERSION / 4, GetScriptAreaParams( "Town3_1" ) );
		WaitForArrayAtArea( 2, "Town3_1", group );
		Wait( 10 );
		CmdArrayDisp( ACT_SWARM, group, DISPERSION / 4, GetScriptAreaParams( "Town3_2" ) );
		WaitForArrayAtArea( 2, "Town3_2", group );
		Wait( 10 );
		CmdArrayDisp( ACT_SWARM, group, DISPERSION / 4, GetScriptAreaParams( "Town3_3" ) );
		WaitForArrayAtArea( 2, "Town3_3", group );
		Wait( 10 );
		CmdArrayDisp( ACT_SWARM, group, DISPERSION / 4, GetScriptAreaParams( "Town3_2" ) );
		WaitForArrayAtArea( 2, "Town3_2", group );
		Wait( 10 );
	end;
end;

-- !
function Reinf_Attack( k, Target )
local Attack_Group = {};
local artgroup = {};
local Templates = { Deploy_GA, Deploy_Tanks, Deploy_AssaultSPG, Deploy_TD, Deploy_Artillery };
local Reinfs = { Reinf_Enemy_GA, Reinf_Enemy_Tanks, Reinf_Enemy_AssaultSPG, Reinf_Enemy_TD, Reinf_Enemy_Artillery };
local EnemyPoints = { 1, 5, 7, 8, 9 };
local guns = {};
local trucks = {};
	X, Y = GetScriptObjCoord( Target );
	Trace( "%g %g", X, Y );
	if ( Target == 501 ) then -- radar
	DirX, DirY = X - 2000, Y;
	elseif ( Target == 502 ) then -- docks
	DirX, DirY = X + 2000, Y + 500;
	elseif ( Target == 503 ) then -- station
	DirX, DirY = X + 2000, Y + 1000;
	end;
	Trace("Enemy reinf %g landed", k );
	LandReinforcement( 2, Reinfs[k], Templates[k], EnemyPoints[k] );
	--Wait( 2 );
	Sleep( 5 );
	Attack_Group = GetUnitListInAreaArray( 2, "Player2_Reinf" );
	Trace( "Attack_group.n = %g", Attack_Group.n );
	if ( ( k == 2 ) or ( k == 4 ) ) then -- tanks and tank destroyers
		StartThread( Smart_Attack, Attack_Group, X, Y );
		--CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Landing_Zone" ) );
	elseif ( k == 3 ) then -- assault guns
		CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION / 2, Random( 4600 ) + 7300, Random( 2200 ) + 11800 );
	elseif ( k == 5 ) then -- artillery
		trucks = GetUnitListWithHPs( Attack_Group, truck_hp );
		guns = GetUnitListWithHPs( Attack_Group, gun_hp );
		CmdArrayDisp( ACT_DEPLOY, trucks, DISPERSION / 2, X, Y );
		--QCmdArrayDisp( ACT_MOVE, trucks, DirX, DirY );
		WaitForArrayAtPosition( trucks, X, Y, DISPERSION / 2 * 1.5 );
		Wait( 12 );
		Trace("Deployed");
		--artgroup = GetUnitListInAreaArray( 2, tmparea ); -- !!!!!!!!!		
		CmdArray( ACT_ROTATE, guns, DirX, DirY );
		--QCmdArray( ACT_ENTRENCH, Attack_Group );
	elseif ( k == 1 ) then -- ground attack
		Trace("player 2 planes number = %g", Attack_Group.n);
		Wait( 5 );
		CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, X, Y );
	end;
end;

function Attacks_Manager_AI()
local tmpnum = Random( 2 ) + 1;
local Templates = { Deploy_GA, Deploy_Tanks, Deploy_TD, Deploy_AssaultSPG, Deploy_Artillery };
local Reinfs = { Reinf_Enemy_GA, Reinf_Enemy_Tanks, Reinf_Enemy_TD, Reinf_Enemy_AssaultSPG, Reinf_Enemy_Artillery };
local EnemyPoints = { {1, 13}, {5, 17}, {8, 20}, {7, 19}, {9, 21} };
	Trace("Attack Manager AI started");
	Wait( 60 );
	while( stop_attacks_ai == 0 ) do
		LandReinforcement( 3, Reinfs[tmpnum], Templates[tmpnum], EnemyPoints[tmpnum][Random( 2 )] );
		Wait( 300 + RandomInt( 60 ) );
	end;
end;

function Attacks_Manager()
local required_type;
local tmpnum = Random( 3 );
local t, target;
	Trace("Attack Manager started");
	Wait( 40 );
	while( stop_attacks == 0 ) do
		--available_targets = { GetNUnitsInScriptGroup( 501, 0), GetNUnitsInScriptGroup( 502, 0), GetNUnitsInScriptGroup( 503, 0) };
		target = Random( 3 );
		--t = available_targets[ target ];
		t = Keybuildings[ target + 500 ];
		--if ( t == 0 ) then
		if ( t == 2 ) then
			required_type = 5;
		else
			required_type = Random( 4 );
		end;
		StartThread( Reinf_Attack, required_type, target + 500 );
		Wait( 180 + RandomInt( 60 ) );
	end;
end;

-- MOCHILOVO
function Mochilovo_Allies( allies_type )
local Coords = { { 14700, 14600 }, { 10800, 14200 }, { 8100, 14000 } };
local Allies_Group = {};
local AlliesTemplates = { Deploy_GA, Deploy_Tanks, Deploy_TD, Deploy_MainInf };
local AlliesReinfs = { Reinf_Allies_GA, Reinf_Allies_Tanks, Reinf_Allies_TD, Reinf_Allies_MainInf };
local AlliesPoints = { 1, 5, 8, 12 };
	Trace("Mochilovo: Allies reinf %g landed", allies_type );
	LandReinforcement( 1, AlliesReinfs[allies_type], AlliesTemplates[allies_type], AlliesPoints[allies_type] );
	Sleep( 5 );
	Allies_Group = GetUnitListInAreaArray( 1, "Player1_Mochilovo" );
	Trace( "Allies_Group.n = %g", Allies_Group.n );
	if ( ( allies_type == 2 ) or ( allies_type == 3 ) ) then -- tanks and tank destroyers
		CmdArrayDisp( ACT_SWARM, Allies_Group, 500, Coords[1][1], Coords[1][2] );
		QCmdArrayDisp( ACT_SWARM, Allies_Group, 500, Coords[2][1], Coords[2][2] );
		QCmdArrayDisp( ACT_SWARM, Allies_Group, 500, Coords[3][1], Coords[3][2] );
	elseif ( allies_type == 4 ) then -- infantry
		CmdArrayDisp( ACT_SWARM, Allies_Group, 500, Coords[1][1], Coords[1][2]);
		QCmdArrayDisp( ACT_SWARM, Allies_Group, 500, Coords[2][1], Coords[2][2]);
		QCmdArrayDisp( ACT_UNLOAD, Allies_Group, 500, Coords[2][1], Coords[2][2]);
	elseif ( allies_type == 1 ) then -- ground attack
		Wait( 5 );
		CmdArrayDisp( ACT_SWARM, Allies_Group, DISPERSION, Coords[2][1], Coords[2][2] );
	end;
end;

function Mochilovo_Enemy( enemy_type )
local Coords = { { 9100, 14000 }, { 10800, 14200 }, { 14700, 14600 } };
local Enemy_Group = {};
local EnemyTemplates = { Deploy_Tanks, Deploy_LightTanks, Deploy_TD, Deploy_MainInf };
local EnemyReinfs = { Reinf_Enemy_Tanks, Reinf_Enemy_LightTanks, Reinf_Enemy_TD, Reinf_Enemy_MainInf };
local EnemyPoints = { 13, 14, 16, 18 };
	Trace("Mochilovo: Enemy reinf %g landed", enemy_type );
	LandReinforcement( 2, EnemyReinfs[enemy_type], EnemyTemplates[enemy_type], EnemyPoints[enemy_type] );
	Sleep( 5 );
	Enemy_Group = GetUnitListInAreaArray( 2, "Player2_Mochilovo" );
	Trace( "Enemy_Group.n = %g", Enemy_Group.n );
	if ( ( enemy_type >= 1 ) or ( enemy_type <= 3 ) ) then -- tanks and tank destroyers
		CmdArrayDisp( ACT_SWARM, Enemy_Group, 500, Coords[1][1], Coords[1][2]);
		QCmdArrayDisp( ACT_SWARM, Enemy_Group, 500, Coords[2][1], Coords[2][2]);
		QCmdArrayDisp( ACT_SWARM, Enemy_Group, 500, Coords[3][1], Coords[3][2]);
	elseif ( enemy_type == 4 ) then -- infantry
		CmdArrayDisp( ACT_SWARM, Enemy_Group, 500, Coords[1][1], Coords[1][2]);
		QCmdArrayDisp( ACT_SWARM, Enemy_Group, 500, Coords[2][1], Coords[2][2]);
		QCmdArrayDisp( ACT_UNLOAD, Enemy_Group, 500, Coords[2][1], Coords[2][2]);
	end;
end;

function MochilovoManager()
	Trace("Mochilovo Manager started");
	Wait( 10 );
	while( stop_allies_attacks == 0 ) do
		StartThread( Mochilovo_Allies, Random( 4 ) );
		StartThread( Mochilovo_Enemy, Random( 4 ) );
		Wait( 180 + RandomInt( 60 ) );
	end;
end;

function Objective0() -- capture docks
local lastowner = Keybuildings[ Docks_ScriptId ];
	while ( missionend == 0 ) do
		Wait( 2 );
		local newowner = Keybuildings[ Docks_ScriptId ];
		if ( lastowner ~= newowner ) then
		if ( newowner == 0 ) then -- keybuilding captured
			Trace("Objective #0 complete");
			ObjectiveChanged( 0, 2 );
			SetIGlobalVar( "temp.objective0", 2 );
			if ( objective12given == 0 ) then
				ObjectiveChanged( 1, 1 );
				SetIGlobalVar( "temp.objective1", 1 );
				StartThread( Objective1 );
				ObjectiveChanged( 2, 1 );
				SetIGlobalVar( "temp.objective2", 1 );
				StartThread( Objective2 );
				Trigger( Objective3OpenCheck, Objective3Open );
				objective12given = 1;
			end;
		else -- keybuilding captured by enemy
			Trace("Objective #0 repeat");
			ObjectiveChanged( 0, 1 );
			SetIGlobalVar( "temp.objective0", 1 );
		end;
			lastowner = newowner;
		end;
	end;
end;

function Objective1() -- capture radar
local lastowner = Keybuildings[ Radar_ScriptId ];
	if ( lastowner == 0 ) then
		Trace("Objective #1 complete");
		ObjectiveChanged( 1, 2 );
		SetIGlobalVar( "temp.objective1", 2 );
	end;
	while ( missionend == 0 ) do
		Wait( 2 );
		local newowner = Keybuildings[ Radar_ScriptId ];
		if ( lastowner ~= newowner ) then
		if ( newowner == 0 ) then -- keybuilding captured
			Trace("Objective #1 complete");
			ObjectiveChanged( 1, 2 );
			SetIGlobalVar( "temp.objective1", 2 );
			lastowner = newowner;
		else -- keybuilding captured by enemy
			Trace("Objective #1 repeat");
			ObjectiveChanged( 1, 1 );
			SetIGlobalVar( "temp.objective1", 1 );
			lastowner = newowner;			
		end;
		end;
	end;
end;

function Objective2() -- capture station
local lastowner = Keybuildings[ Station_ScriptId ];
	if ( lastowner == 0 ) then
		Trace("Objective #2 complete");
		ObjectiveChanged( 2, 2 );
		SetIGlobalVar( "temp.objective2", 2 );
	end;
	while ( missionend == 0 ) do
		Wait( 2 );
		local newowner = Keybuildings[ Station_ScriptId ];
		if ( lastowner ~= newowner ) then
		if ( newowner == 0 ) then -- keybuilding captured
			Trace("Objective #2 complete");
			ObjectiveChanged( 2, 2 );
			SetIGlobalVar( "temp.objective2", 2 );
			lastowner = newowner;
		else -- keybuilding captured by enemy
			Trace("Objective #2 repeat");
			ObjectiveChanged( 2, 1 );
			SetIGlobalVar( "temp.objective2", 1 );
			lastowner = newowner;			
		end;
		end;
	end;
end;



------------------------- OLD SECTION
-- Objective #0 -- capture docks
function Objective0CompleteCheck()
--	if ( Keybuildings[501] + Keybuildings[502] + Keybuildings[503] == 0 ) then
--	if ( GetNUnitsInScriptGroup( 501, 0 ) + GetNUnitsInScriptGroup( 502, 0 ) + GetNUnitsInScriptGroup( 503, 0 ) == 3 ) then
	if ( Keybuildings[ Docks_ScriptId ] == 0 ) then
		return 1;
	end;
end;

function Objective0RepeatCheck()
--	if ( Keybuildings[501] + Keybuildings[502] + Keybuildings[503] == 6 ) then
--	if ( GetNUnitsInScriptGroup( 501, 2 ) + GetNUnitsInScriptGroup( 502, 2 ) + GetNUnitsInScriptGroup( 503, 2 ) +
--		GetNUnitsInScriptGroup( 501, 3 ) + GetNUnitsInScriptGroup( 502, 3 ) + GetNUnitsInScriptGroup( 503, 3 ) == 3 ) then
	if ( Keybuildings[ Docks_ScriptId ] == 2 ) then
		return 1;
	end;
end;

function Objective0Complete()
	Trace("Objective #0 complete");

	Trigger( Objective0FailCheck, Objective0Fail ); -- start fail check
	
	 ObjectiveChanged( 0, 2 );
	SetIGlobalVar( "temp.objective0", 2 );
	Wait( 5 );
	-- AI General gains reinforcements
	--EnableReinforcement( 3, Reinf_Enemy_Tanks, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_TD, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_AssaultSPG, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_LightTanks, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_Artillery, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_HeavyArtillery, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_AssaultInf, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_MainInf, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_GA, 1 );
	--EnableReinforcement( 3, Reinf_Enemy_Fighters, 1 );
	for u = 1, 24 do
		EnableReinforcementPoint( 3, u, 1 );
	end;
	
	StartThread( Attacks_Manager );
	--StartThread( Attacks_Manager_AI );
	
	 ObjectiveChanged( 1, 1 );
	SetIGlobalVar( "temp.objective1", 1 );
	Trigger( Objective1CompleteCheck, Objective1Complete );
	
	 ObjectiveChanged( 5, 1 );
	SetIGlobalVar( "temp.sobjective1", 1 );
	Trigger( ObjectiveS1CompleteCheck, ObjectiveS1Complete );

	 ObjectiveChanged( 6, 1 );
	SetIGlobalVar( "temp.sobjective2", 1 );
	Trigger( ObjectiveS2CompleteCheck, ObjectiveS2Complete );
	
end;

function Objective0Repeat()
	 ObjectiveChanged( 0, 1 );
	SetIGlobalVar( "temp.objective0", 1 );
	Trace("Objective #0 repeat");
	--Wait( 3 );
	--Win( 1 );
end;
-- End of Objective #0 --
------------------------- END OF OLD SECTION


-- Objective #3 -- Destroy at least 75% of script group
function Objective3OpenCheck()
	if ( GetIGlobalVar( "temp.objective1", 0 ) * GetIGlobalVar( "temp.objective2", 0 ) == 4 ) then
		return 1;
	end;
end;

function Objective3Open()
	ObjectiveChanged( 3, 1 );
	SetIGlobalVar( "temp.objective3", 1 );
	Trigger( Objective3CompleteCheck, Objective3Complete );

	ObjectiveChanged( 5, 1 );
	SetIGlobalVar( "temp.sobjective1", 1 );
	Trigger( ObjectiveS1CompleteCheck, ObjectiveS1Complete );

	ObjectiveChanged( 6, 1 );
	SetIGlobalVar( "temp.sobjective2", 1 );
	Trigger( ObjectiveS2CompleteCheck, ObjectiveS2Complete );
	
	for u = 1, 24 do
		EnableReinforcementPoint( 3, u, 1 );
	end;
	
	StartThread( Attacks_Manager );
	StartThread( Attacks_Manager_AI );
	StartThread( MochilovoManager );
end;

function Objective3CompleteCheck()
local __tmp = GetNUnitsInScriptGroup( Town_Units_ScriptId, 2 ) / Town_Units_Total;
	if ( __tmp <= 0.25 ) then
		return 1;
	end;
end;

function Objective3FailCheck()
-- this objective can't be failed
end;

function Objective3Complete()
	Trace("Objective #3 complete");
	 ObjectiveChanged( 3, 2 );
	SetIGlobalVar( "temp.objective3", 2 );
	stop_allies_attacks = 1;
end;

function Objective3Fail()
-- this objective can't be failed
end;
-- End of Objective #3 --


-- Secondary Objective #0 -- destroy artillery battery
function ObjectiveS0CompleteCheck()
	if ( GetNUnitsInScriptGroup( Artillery_ScriptId, 2 ) <= 0 ) then
		return 1;
	end;
end;

function ObjectiveS0FailCheck()
	if ( GetNUnitsInScriptGroup( Saboteur_ScriptId, 0 ) <= 0 ) then
--or ( GetNScriptUnitsInArea( Tank_ScriptId, "EndPoint" ) == 3 ) ) then
		return 1;
	end;
end;

function ObjectiveS0Complete()
	--Cmd( ACT_STOP, 9 );
	 ObjectiveChanged( 4, 2 );
	Trace("Secondary Objective #0 complete");
	SetIGlobalVar( "temp.sobjective0", 2 );
	--KillTrigger( trigger_objective0fail );
	--Wait( 5 );
	
	--EnableReinforcement( 0, Reinf_Player_Tanks, 1 );
	--EnableReinforcement( 0, Reinf_Player_TD, 1 );
	--EnableReinforcement( 0, Reinf_Player_LightTanks, 1 );
	--EnableReinforcement( 0, Reinf_Player_Artillery, 0 );
	--EnableReinforcement( 0, Reinf_Player_MainInf, 1 );
	--EnableReinforcement( 0, Reinf_Player_Fighters, 1 );
	--EnableReinforcementPoint( 0, Point_Tanks, 1);
	--EnableReinforcementPoint( 0, Point_TD, 1);
	--EnableReinforcementPoint( 0, Point_LightTanks, 1);
	--EnableReinforcementPoint( 0, Point_Artillery, 1);
	--EnableReinforcementPoint( 0, Point_MainInf, 1);
	--EnableReinforcementPoint( 0, Point_Fighters, 1);
	
	-- ObjectiveChanged( 1, 1 );
	--SetIGlobalVar( "temp.objective1", 1 );
	--Trigger( Objective1CompleteCheck, Objective1Complete );
	--Trigger( Objective1FailCheck, Objective1Fail );

	-- ObjectiveChanged( 3, 1 );
	--SetIGlobalVar( "temp.objective3", 1 );
	--Trigger( Objective3CompleteCheck, Objective3Complete );
	--Trigger( Objective3FailCheck, Objective3Fail );

end;

function ObjectiveS0Fail()
	 ObjectiveChanged( 4, 3 );
	Trace("Objective #0 failed");
	SetIGlobalVar( "temp.objective0", 3 );
	Wait( 3 );
	Win( 1 ); -- player lost
end;
-- End of Secondary Objective #0 --



-- Secondary Objective #1 -- Destroy the bridge
function ObjectiveS1CompleteCheck()
	if ( GetNUnitsInScriptGroup( Bridge_ScriptId ) < 3 ) then
		return 1;
	end;
end;

function ObjectiveS1FailCheck()
	-- can't be failed
end;

function ObjectiveS1Complete()
	Trace("Secondary Objective #1 complete");
	 ObjectiveChanged( 5, 2 );
	SetIGlobalVar( "temp.sobjective1", 2 );
	-- disable attacks from north
	stop_attacks = 1;
	
	-- start combat with allies
	--StartThread( MochilovoManager );
end;

function ObjectiveS1Fail()
	-- can't be failed
end;
-- End of Secondary Objective #0 --


-- Secondary Objective #1 -- Destroy fuel storage
function ObjectiveS2CompleteCheck()
	if ( ( ( ( GetNUnitsInScriptGroup( Barrels_ScriptId ) * 100 ) / Barrels_Total ) <= 25 ) and 
	 ( GetNUnitsInScriptGroup( Warehouse_ScriptId ) < Warehouses_Total ) )  then
		return 1;
	end;
end;

function Check1()
	Trace( "barrels current = %g", GetNUnitsInScriptGroup( Barrels_ScriptId ) );
	Trace( "barrels total = %g", Barrels_Total );
	Trace( "warehouses total = %g", GetNUnitsInScriptGroup( Warehouse_ScriptId ) );
end;

function ObjectiveS2FailCheck()
-- this objective can't be failed
end;

function ObjectiveS2Complete()
	Trace("Secondary Objective #2 complete");
	 ObjectiveChanged( 6, 2 );
	SetIGlobalVar( "temp.sobjective2", 2 );
	--
	-- disable reinforcements for AI general
	--
	--EnableReinforcement( 3, Reinf_Enemy_Tanks, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_TD, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_AssaultSPG, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_LightTanks, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_Artillery, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_HeavyArtillery, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_AssaultInf, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_MainInf, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_GA, 0 );
	--EnableReinforcement( 3, Reinf_Enemy_Fighters, 0 );
	for u = 1, 24 do
		EnableReinforcementPoint( 3, u, 0 );
	end;
	stop_attacks_ai = 1;
end;

function ObjectiveS2Fail()
-- this objective can't be failed
end;
-- End of Secondary Objective #1 --

-- !!! CRAP !!!
function KeybuildingCheck()
local enable, rnf1, rnf2;
	while ( missionend == 0 ) do
	Wait( 5 );
	for i = 501, 503 do
		local tmp1 = -1;
		local tmp2 = -1;
		local x, y = GetScriptObjCoord( i );
		--Trace( "num1 = %g", GetNUnitsInCircle( 0, x, y, RADIUS ) );
		--if ( GetNUnitsInCircle( 0, x, y, RADIUS * 1.5 ) > 0 ) then
		if ( GetNUnitsInScriptGroup( i, 0 ) == 1 ) then
			tmp1 = 0;
		end;
		--Trace( "num2 = %g", GetNUnitsInCircle( 2, x, y, RADIUS ) +
		--	GetNUnitsInCircle( 3, x, y, RADIUS ) );
		--if ( ( GetNUnitsInCircle( 2, x, y, RADIUS * 1.5 ) > 0 ) or
		--	( GetNUnitsInCircle( 3, x, y, RADIUS * 1.5 ) > 0 ) ) then
		if ( ( GetNUnitsInScriptGroup( i, 2 ) + GetNUnitsInScriptGroup( i, 3 ) ) == 1 ) then
			tmp2 = 2;
		end;
		tmp = tmp1 + tmp2 + 1;
		if ( tmp == 0 ) then
			enable = 1;
		elseif ( tmp ~= 0 ) then
			enable = 0;
		end;
		if ( i == Docks_ScriptId ) then
			--rnf1 = Reinf_Player_AssaultSPG;
			rnf1 = Point_AssaultGuns;
			rnf2 = 0;
		elseif ( i == Station_ScriptId ) then
			--rnf1 = Reinf_Player_AssaultInf;
			rnf1 = Point_AssaultInf;
			rnf2 = Point_HeavyArtillery;
			--rnf2 = Reinf_Player_HeavyArtillery;
		elseif ( i == Radar_ScriptId ) then
			--rnf1 = Reinf_Player_GA;
			rnf1 = Point_GA;
			rnf2 = 0;
		end;
		if ( tmp >= 0 ) and ( tmp <= 2 ) then
		if ( Keybuildings[i] ~= tmp ) then
			Trace( "build = %g, player = %g", i, tmp );
			Keybuildings[i] = tmp;
			--EnableReinforcement( 0, rnf1, enable );
			EnableReinforcementPoint( 0, rnf1, enable );
			if ( rnf2 ~= 0 ) then
				--EnableReinforcement( 0, rnf2, enable );
				EnableReinforcementPoint( 0, rnf2, enable );
			end;
		end;
		end;
	end;

	end;
end;
-- end of CRAP

function WinCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( GetIGlobalVar( "temp.objective0", 0 ) * GetIGlobalVar( "temp.objective1", 0 ) *
		 GetIGlobalVar( "temp.objective2", 0 ) * GetIGlobalVar( "temp.objective3", 0 ) == 16 ) then
			Wait( 5 );
			Win( 0 ); -- player wins
			missionend = 1;
		end;
	end;
end;

-- Main Script --
-- AI General has no reinfs
--EnableReinforcement( 3, Reinf_Enemy_Tanks, 0 );
--EnableReinforcement( 3, Reinf_Enemy_TD, 0 );
--EnableReinforcement( 3, Reinf_Enemy_AssaultSPG, 0 );
--EnableReinforcement( 3, Reinf_Enemy_LightTanks, 0 );
--EnableReinforcement( 3, Reinf_Enemy_Artillery, 0 );
--EnableReinforcement( 3, Reinf_Enemy_HeavyArtillery, 0 );
--EnableReinforcement( 3, Reinf_Enemy_AssaultInf, 0 );
--EnableReinforcement( 3, Reinf_Enemy_MainInf, 0 );
--EnableReinforcement( 3, Reinf_Enemy_GA, 0 );
--EnableReinforcement( 3, Reinf_Enemy_Fighters, 0 );

-- player has no reinfs
--EnableReinforcement( 0, Reinf_Player_Tanks, 0 );
--EnableReinforcement( 0, Reinf_Player_TD, 0 );
--EnableReinforcement( 0, Reinf_Player_AssaultSPG, 0 );
--EnableReinforcement( 0, Reinf_Player_LightTanks, 0 );
--EnableReinforcement( 0, Reinf_Player_Artillery, 0 );
--EnableReinforcement( 0, Reinf_Player_HeavyArtillery, 0 );
--EnableReinforcement( 0, Reinf_Player_AssaultInf, 0 );
--EnableReinforcement( 0, Reinf_Player_MainInf, 0 );
--EnableReinforcement( 0, Reinf_Player_GA, 0 );
--EnableReinforcement( 0, Reinf_Player_Fighters, 0 );
--EnableReinforcement( 0, 60, 0 );

--for u = 1, 12 do
--	EnableReinforcementPoint( 3, u, 0 );
--	EnableReinforcementPoint( 3, u + 12, 0 );
--	EnableReinforcementPoint( 0, u, 0 );
--end;

EnableReinforcementPoint( 0, Point_AssaultGuns, 0 );
EnableReinforcementPoint( 0, Point_AssaultInf, 0 );
EnableReinforcementPoint( 0, Point_HeavyArtillery, 0 );
EnableReinforcementPoint( 0, Point_GA, 0 );

ObjectiveChanged( 0, 1 );
--ObjectiveChanged( 4, 1 );
--Trigger( Objective0CompleteCheck, Objective0Complete );
--trigger_objective0fail = 
--Trigger( Objective0FailCheck, Objective0Fail );
StartThread( Objective0 );
--Trigger( ObjectiveS0CompleteCheck, ObjectiveS0Complete );
StartThread( KeybuildingCheck );
StartThread( WinCheck );