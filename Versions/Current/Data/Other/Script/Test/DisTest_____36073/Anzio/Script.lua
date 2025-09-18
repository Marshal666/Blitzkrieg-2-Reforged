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
Reinf_Player_Tanks = 59;
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
--MotorCycleId = 402;
GenCarsId = 401;
Dzot_ScriptId = 10;
Tank_ScriptId = 101;
Dock_Units_ScriptId = 200;
Town_Units_ScriptId = 300;
Tanks_Group1 = 500;
SouthTown_Units_ScriptId = 600;
EastTown_Units_ScriptId = 700;
AAGun_ScriptId = 900;
Tigers_ScriptId = 50;
Trucks_ScriptId = 1001;

-- other
MINRADIUS = 50;
SIGHTRANGE = 37 * 32;
RADIUS = 512;
DISPERSION = 1024;
DZOT_HP_RESTORE = 540;
delay_attacks = 0;
stop_attacks = 0;
reinf_called = 0;
player_called_aviation = 0;
planes = {};
planes2 = {};

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


function Cars_Start_Movement()
	Trace("Cars_Start_Movement");
	Wait( 60 );
	CmdMultiple( ACT_MOVE, GenCarsId, GetScriptAreaParams( "P" .. 1 ) );
	--Cmd( ACT_MOVE, MotorCycleId, GetScriptAreaParams( "P" .. 1 ) );
	for i = 2, 20 do
		QCmdMultiple( ACT_MOVE, GenCarsId, GetScriptAreaParams( "P" .. i ) );
		--QCmd( ACT_MOVE, MotorCycleId, GetScriptAreaParams( "P" .. i ) );
	end;

end;

function Tanks_Attack()
	Trace("Tanks_Attack");
	Wait( 60 );
	Cmd( ACT_SWARM, Tanks_Group1, GetScriptAreaParams( "Landing_Zone" ) );
	Wait( 1 );
	while ( ( GetUnitState( Tanks_Group1 ) ~= STATE_REST ) and ( GetNUnitsInScriptGroup( Tanks_Group1 ) > 0 ) ) do -- GetUnitState currentry uses ScriptID
		Wait( 1 );
	end;
	if ( GetNUnitsInScriptGroup( Tanks_Group1 ) > 0 ) then
	Trace("Rest");
	Cmd( ACT_ATTACKOBJECT, Tanks_Group1, Dzot_ScriptId );
	while ( ( GetScriptObjectHPs( Dzot_ScriptId ) > 0 ) and ( GetNUnitsInScriptGroup( Tanks_Group1 ) > 0 ) ) do
		if ( GetNUnitsNearScriptObj( 0, Tanks_Group1, SIGHTRANGE ) > 0) then
		Cmd( ACT_STOP, Tanks_Group1 );
			while ( ( GetNUnitsNearScriptObj( 0, Tanks_Group1, SIGHTRANGE ) > 0 ) and ( GetNUnitsInScriptGroup( Tanks_Group1 ) > 0 ) ) do
				Wait( 2 );
			end;
		Cmd( ACT_ATTACKOBJECT, Tanks_Group1, Dzot_ScriptId );
		end;
		Wait( 1 );
	end;
	end;
	Trace("attacking group is dead");
	StartThread( Attacks_Manager );
end;

function Tanks_Attack2( group )
--local x, y = GetScriptAreaParams( "Landing_Zone" );
local x, y;
local startx, starty = GetObjCoordMedium( group );
local endx, endy = GetScriptAreaParams( "Landing_Zone" );
local attackvector = { x = endx - startx, y = endy - starty };
local dirvector = {};
local l = len( attackvector.x, attackvector.y );
local resultvector = {};
local tangent = RandomFloat() * 0.2 + 0.6;
local normal = RandomFloat() * 0.25 + 0.1;
	dirvector = norm( attackvector );
	Trace("dirvector %g %g", dirvector.x * 1000, dirvector.y * 1000 );
	resultvector.x = dirvector.x * tangent * l;
	resultvector.y = dirvector.y * tangent * l;
	dirvector = rot90( dirvector, 1 );
	Trace("dirvector %g %g", dirvector.x * 1000, dirvector.y * 1000 );
	resultvector.x = resultvector.x + dirvector.x * normal * l;
	resultvector.y = resultvector.y + dirvector.y * normal * l;
	x, y = resultvector.x + startx, resultvector.y + starty;
	Trace("resultvector = %g, %g", x, y );
	CmdArrayDisp( ACT_SWARM, group, 256, x, y );
	QCmdArrayDisp( ACT_SWARM, group, 256, endx, endy );
	WaitForArrayAtPosition( group, endx, endy, 400 );
	if ( NumUnitsAliveInArray( group ) > 0 ) then
	CmdArray( ACT_ATTACKOBJECT, group, GetObjectList( Dzot_ScriptId ) );
	while ( ( GetScriptObjectHPs( Dzot_ScriptId ) > 0 ) and ( NumUnitsAliveInArray( group ) > 0 ) ) do
		if ( GetNUnitsNearArray( 0, group, SIGHTRANGE ) > 0) then
		CmdArray( ACT_STOP, group );
			while ( ( GetNUnitsNearArray( 0, group, SIGHTRANGE ) > 0 ) and ( NumUnitsAliveInArray( group ) > 0 ) ) do
				Wait( 2 );
			end;
		CmdArray( ACT_ATTACKOBJECT, group, GetObjectList( Dzot_ScriptId ) );
		end;
		Wait( 1 );
	end;
	end;
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

function Reinf_Attack( k )
local Attack_Group = {};
local artgroup = {};
local Templates = { Deploy_Tanks, Deploy_TD, Deploy_AssaultSPG, Deploy_Artillery, Deploy_GA, Deploy_LightTanks };
local Reinfs = { Reinf_Enemy_Tanks, Reinf_Enemy_TD, Reinf_Enemy_AssaultSPG, Reinf_Enemy_Artillery, Reinf_Enemy_GA, Reinf_Enemy_LightTanks };
local EnemyPoints = { 1, 2, 5, 6, 4, 7 };
local Areas = { "Enemy_Reinforcement", "Enemy_Reinforcement2", "Enemy_Reinforcement3" };
local area = Areas[1];
	Trace("Enemy reinf %g landed", k );
	LandReinforcement( 2, Reinfs[k], Templates[k], EnemyPoints[k] );
	Sleep( 5 );
	if ( k == 5 ) then
		area = Areas[3];
	elseif ( ( k == 3 ) or ( k == 4 ) or ( k == 6 ) ) then
		area = Areas[2];
	end;
	Trace( area );
	Attack_Group = GetUnitListInAreaArray( 2, area );
	if ( k <= 2 ) then
		StartThread( Tanks_Attack2, Attack_Group );
		--CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Landing_Zone" ) );
	elseif ( k == 3 ) then
		CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION / 2, 9000 + Random( 5000 ), 4000 + Random( 9000 ) );
	elseif ( k == 4 ) then
		local tmparea = "Art" .. Random( 3 );
		CmdArrayDisp( ACT_DEPLOY, Attack_Group, DISPERSION / 4, GetScriptAreaParams( tmparea ) );
		while (	GetNArrayUnitsInArea( 2, tmparea, Attack_Group ) < NumUnitsAliveInArray( Attack_Group ) ) do
			Wait( 2 );
			Trace("%g %g", GetNArrayUnitsInArea( 2, tmparea, Attack_Group ), NumUnitsAliveInArray( Attack_Group ) );
		end;
		Wait( 5 );
		Trace("Deployed");
		artgroup = GetUnitListInAreaArray( 2, tmparea );
		CmdArray( ACT_ROTATE, artgroup, 0, 7000 );
		QCmdArray( ACT_ENTRENCH, artgroup );
	elseif ( k == 5 ) then
		Trace("planes 2 number = %g", Attack_Group.n);
		Wait( 5 );
		CmdArrayDisp( ACT_MOVE, Attack_Group, DISPERSION * 2, GetScriptAreaParams( "P" .. ( Random( 6 ) + 6 ) ) );
		planes2 = Attack_Group;
	elseif ( k == 6 ) then
		StartThread( Town3Patrol, Attack_Group );
	end;
end;

function Attacks_Manager()
	Trace("Attack Manager started");
	Wait( 40 );
	while( stop_attacks == 0 ) do
		if ( delay_attacks ~= 0 ) then
			StartThread( Reinf_Attack, mod( RandomInt( 3 ) + 6, 6 ) );
		else
			StartThread( Reinf_Attack, Random( 5 ) );
		end;
		Wait( 180 + RandomInt( 30 ) + delay_attacks * 120 );
	end;
end;

-- Objective #0 -- Player units near "Landing_Zone"
function Objective0CompleteCheck()
	if ( ( GetNUnitsInArea( 0, "Landing_Zone" ) > 1 ) and ( GetNUnitsInScriptGroup( Tank_ScriptId, 2 ) <= 0 ) ) then
		return 1;
	end;
end;

function Objective0FailCheck()
-- this objective can't be failed
end;

function Objective0Complete()
	DamageScriptObject( Dzot_ScriptId, -100 );
	Wait( 1 );
	DamageScriptObject( Dzot_ScriptId, -200 );
	 ObjectiveChanged( 0, 2 );
	Trace("Objective #0 complete");
	SetIGlobalVar( "temp.objective0", 2 );
	Wait( 5 );
	 ObjectiveChanged( 1, 1 );
	SetIGlobalVar( "temp.objective1", 1 );
	Trigger( Objective1CompleteCheck, Objective1Complete );
	--Trigger( Objective1FailCheck, Objective1Fail );

	 ObjectiveChanged( 3, 1 );
	SetIGlobalVar( "temp.objective3", 1 );
	Trigger( Objective3CompleteCheck, Objective3Complete );
	Trigger( Objective3FailCheck, Objective3Fail );

end;

function Objective0Fail()
-- this objective can't be failed
end;
-- End of Objective #0 --


-- Objective #1 -- Secure Docks
function Objective1CompleteCheck()
	if ( GetNUnitsInScriptGroup( Dock_Units_ScriptId, 2 ) <= 0 ) then
		return 1;
	end;
end;

function Objective1FailCheck()
-- this objective can't be failed
end;

function Objective1Complete()
	Trace("Objective #1 complete");
	--EnableReinforcement( 0, Reinf_Player_AssaultSPG, 1 );
	--EnableReinforcement( 0, Reinf_Player_AssaultInf, 1 );
	--EnableReinforcement( 0, Reinf_Player_HeavyArtillery, 1 );
	--EnableReinforcement( 0, Reinf_Player_TD, 1 );
	EnableReinforcementPoint( 0, 7, 1 ); -- 11
	EnableReinforcementPoint( 0, 6, 1 ); -- 12
	EnableReinforcementPoint( 0, 10, 1 );
	EnableReinforcementPoint( 0, 9, 1 );


	 ObjectiveChanged( 1, 2 );
	SetIGlobalVar( "temp.objective1", 2 );
	Wait( 5 );
	 ObjectiveChanged( 2, 1 );
	SetIGlobalVar( "temp.objective2", 1 );
	Trigger( Objective2CompleteCheck, Objective2Complete );
	--Trigger( Objective2FailCheck, Objective2Fail );
end;

function Objective1Fail()
-- this objective can't be failed
end;
-- End of Objective #1 --


-- Objective #2 -- Secure Town
function Objective2CompleteCheck()
	if ( GetNUnitsInScriptGroup( Town_Units_ScriptId, 2 ) <= 0 ) then
		return 1;
	end;
end;

function Objective2FailCheck()
-- this objective can't be failed
end;

function Objective2Complete()
	Trace("Objective #2 complete");
	 ObjectiveChanged( 2, 2 );
	SetIGlobalVar( "temp.objective2", 2 );
	Wait( 5 );
	StartThread( Tanks_Attack );
	StartThread( Cars_Start_Movement );
	-- ObjectiveChanged( 3, 1 );
	--SetIGlobalVar( "temp.objective3", 1 );

	 ObjectiveChanged( 4, 1 );
	SetIGlobalVar( "temp.objective4", 1 );

	 ObjectiveChanged( 6, 1 ); -- secondary
	SetIGlobalVar( "temp.sobjective0", 1 );

	 ObjectiveChanged( 7, 1 ); -- secondary
	SetIGlobalVar( "temp.sobjective1", 1 );

	--Trigger( Objective3CompleteCheck, Objective3Complete );
	--Trigger( Objective3FailCheck, Objective3Fail );

	Trigger( Objective4CompleteCheck, Objective4Complete );

	Trigger( ObjectiveS0CompleteCheck, ObjectiveS0Complete );
	Trigger( ObjectiveS0FailCheck, ObjectiveS0Fail );

	Trigger( ObjectiveS1CompleteCheck, ObjectiveS1Complete );
end;

function Objective2Fail()
-- this objective can't be failed
end;
-- End of Objective #2 --


-- Objective #3 -- Defend HQ
function Objective3CompleteCheck()
	if ( ( GetScriptObjectHPs( Dzot_ScriptId ) > 0 ) and ( GetIGlobalVar( "temp.objective5", 0 ) == 2 ) ) then
		return 1;
	end;
end;

function Objective3FailCheck()
	if ( GetScriptObjectHPs( Dzot_ScriptId ) == 0 ) then
		return 1;
	end;
end;

function Objective3Complete()
	Trace("Objective #3 complete");
	 ObjectiveChanged( 3, 2 );
	SetIGlobalVar( "temp.objective3", 2 );

end;

function Objective3Fail()
	Trace("Objective #3 fail");
	 ObjectiveChanged( 3, 3 );
	SetIGlobalVar( "temp.objective3", 3 );
	Wait( 3 );
	Win( 1 ); -- player lost (party)
end;
-- End of Objective #3 --


-- Objective #4 -- Secure South Town
function Objective4CompleteCheck()
	if ( GetNUnitsInScriptGroup( SouthTown_Units_ScriptId, 2 ) <= 0 ) then
		return 1;
	end;
--	return nil;
end;

function Objective4FailCheck()
-- this objective can't be failed
end;

function Objective4Complete()
	Trace("Objective #4 complete");
	delay_attacks = 1;
	--EnableReinforcementPoint( 2, 1, 0 ); -- disable reinf point #1 for player 2
	--EnableReinforcementPoint( 2, 2, 0 ); -- disable reinf point #2 for player 2
	 ObjectiveChanged( 4, 2 );
	SetIGlobalVar( "temp.objective4", 2 );
	Wait( 5 );
	 ObjectiveChanged( 5, 1 );
	SetIGlobalVar( "temp.objective5", 1 );
	Trigger( Objective5CompleteCheck, Objective5Complete );
	--Trigger( Objective5FailCheck, Objective5Fail );
end;

function Objective4Fail()
-- this objective can't be failed
end;
-- End of Objective #4 --


-- Objective #5 -- Secure East Town
function Objective5CompleteCheck()
	if ( GetNUnitsInScriptGroup( EastTown_Units_ScriptId, 2 ) <= 0 ) then
		return 1;
	end;
--	return nil;
end;

function Objective5FailCheck()
-- this objective can't be failed
end;

function Objective5Complete()
	Trace("Objective #5 complete");
	stop_attacks = 1;
	 ObjectiveChanged( 5, 2 );
	SetIGlobalVar( "temp.objective5", 2 );
	Wait( 5 );
	Win( 0 );
end;

function Objective5Fail()
-- this objective can't be failed
end;
-- End of Objective #5 --


-- Secondary Objective #0 -- Intercept italian generals
function ObjectiveS0CompleteCheck()
	if ( GetNUnitsInScriptGroup( 401, 2 ) < 3 ) then
		return 1;
	end;
end;

function ObjectiveS0FailCheck()
	if ( GetNScriptUnitsInArea( GenCarsId, "End_Point" ) > 0 ) then
		return 1;
	end;
end;

function ObjectiveS0Complete()
	Trace("Secondary Objective #0 complete");
	ChangePlayerForScriptGroup( GenCarsId, 3 );
	Sleep( 10 );
	Cmd( ACT_STOP, GenCarsId );
	 ObjectiveChanged( 6, 2 );
	SetIGlobalVar( "temp.sobjective0", 2 );
end;

function ObjectiveS0Fail()
	Trace("Secondary Objective #0 fail");
	Cmd( ACT_STOP, GenCarsId );
 	RemoveScriptGroup( GenCarsId );
	 ObjectiveChanged( 6, 3 );
	SetIGlobalVar( "temp.sobjective0", 3 );
end;
-- End of Secondary Objective #0 --


-- Secondary Objective #1 --
function ObjectiveS1CompleteCheck()
	if ( ( GetNUnitsInScriptGroup( AAGun_ScriptId, 2 ) <= 0 ) and ( GetNUnitsNearScriptObj( 0, Tigers_ScriptId, 300 ) > 0 ) ) then
		return 1;
	end;
end;

function ObjectiveS1FailCheck()
-- this objective can't be failed
end;

function ObjectiveS1Complete()
	Trace("Secondary Objective #1 complete");
	ChangePlayerForScriptGroup( Tigers_ScriptId, 0 );
	Wait( 1 );
	CmdMultiple( ACT_ROTATE, Tigers_ScriptId, 6700, 14336 );
	 ObjectiveChanged( 7, 2 );
	SetIGlobalVar( "temp.sobjective1", 2 );
end;

function ObjectiveS1Fail()
-- this objective can't be failed
end;
-- End of Secondary Objective #1 --

function StartCommands()
local ACT_ENTRENCH2 = 1062;
	Wait( 2 );
	--Cmd( ACT_ENTRENCH2, 600 );
	--Cmd( ACT_ENTRENCH2, 700 );
	--Cmd( ACT_ENTRENCH2, 10001 );
	--Cmd( ACT_ENTRENCH2, 900 );
	--QCmd( ACT_AMBUSH, 600 );
	--QCmd( ACT_AMBUSH, 700 );
	--QCmd( ACT_AMBUSH, 10001 );
	--QCmd( ACT_AMBUSH, 900 );
	--ChangeFormation( 10002, 4 );
	Cmd( 78, 10002 );
end;

function CallGermanFighters( enemyplanes )
	Wait( 30 + Random( 20 ) );
	if ( NumUnitsAliveInArray( enemyplanes ) > 0 ) then
		LandReinforcement( 2, Reinf_Enemy_Fighters, Deploy_Fighters, 8 );
		Sleep( 5 );
		planes2 = GetUnitListInAreaArray( 2, "Enemy_Reinforcement3" );
		--planes2 = GetUnitListInAreaArray( 2, "Planes" );
		Trace("planes 2 number = %g", planes2.n);
		Wait( 5 );
		CmdArrayDisp( ACT_MOVE, planes2, DISPERSION, GetObjCoordMedium( enemyplanes ) );
	end;
end;

function EnableNextReinf()
	Wait( 150 );
	reinf_called = 0;
--	SetIGlobalVar( "temp.reinfcalled", 0 );
end;

function NotifyReinforcementCalled( nPlayer, nReinf )
local Docks = { 3730, 4500 };
local Coast = { { 670, 4150 }, { 770, 6520 } };
local ship = {};
local _x, _y;
	if ( ( nPlayer == 0 ) and ( reinf_called == 0 ) ) then --( GetIGlobalVar( "temp.reinfcalled", 0 ) == 0 ) ) then
		--SetIGlobalVar( "temp.reinfcalled", 1 );
		reinf_called = 1;
		StartThread( EnableNextReinf );
		if ( ( nReinf == Reinf_Player_GA ) or ( nReinf == Reinf_Player_Fighters ) ) then
			LandReinforcement( 0, nReinf, DeployTable[nReinf], PointsTable[nReinf] );
			Sleep( 5 );
			planes = GetUnitListInAreaArray( 0, "Planes" );
			Trace("planes number = %g", planes.n);
			Wait( 5 );
			CmdArray( ACT_MOVE, planes, GetScriptAreaParams( "Landing_Zone" ) );
			player_called_aviation = 1;
			StartThread( CallGermanFighters, planes );
			return 0;
		end;
		LandReinforcement( 1, Reinf_Player_TransportShip, Deploy_SingleShip, 1 ); -- transport ship
		Wait( 1 );
		ship = GetUnitListInAreaArray( 1, "Ship" );
		if ( ( nReinf == Reinf_Player_Tanks ) or ( nReinf == Reinf_Player_Artillery ) or ( nReinf == Reinf_Player_MainInf ) or ( nReinf == Reinf_Player_LightTanks ) ) then
			UnitCmd( ACT_MOVE, ship[1], Coast[1][1], Coast[1][2] );
			UnitQCmd( ACT_MOVE, ship[1], Coast[2][1], Coast[2][2] );
			WaitForArrayAtPosition( ship, Coast[2][1], Coast[2][2], MINRADIUS );
		else
			CmdArray( ACT_MOVE, ship, Docks[1], Docks[2] );
			WaitForArrayAtPosition( ship, Docks[1], Docks[2], MINRADIUS );
		end;
		Wait( 2 );
		LandReinforcement( 0, nReinf, DeployTable[nReinf], PointsTable[nReinf] );
		Wait( 3 );
		_x = 1000 + RandomInt( 3000 );
		_y = 950;
		UnitCmd( ACT_MOVE, ship[1], _x, _y );
		WaitForArrayAtPosition( ship, _x, _y, MINRADIUS );
		UnitRemove( ship[1] );
	end;
end;

-- Main Script --
EnableReinforcementPoint( 0, 6, 0 ); -- 11
EnableReinforcementPoint( 0, 7, 0 ); -- 12
EnableReinforcementPoint( 0, 10, 0 );
EnableReinforcementPoint( 0, 9, 0 );
StartThread( StartCommands );

ObjectiveChanged( 0, 1 );
Trigger( Objective0CompleteCheck, Objective0Complete );

