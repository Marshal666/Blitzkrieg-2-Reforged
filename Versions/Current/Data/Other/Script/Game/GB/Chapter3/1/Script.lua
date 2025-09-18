missionend = 0;

function BridgeGuard()
local checked = 0;
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( IsSomeUnitInArea( 0, "most", 0 ) > 0 ) and ( checked == 0 ) then
			Cmd( ACT_SWARM, 2005, 50, GetScriptAreaParams( "guardpos" ) );
			WaitForGroupAtArea( 2005, "guardpos" );
			Cmd( ACT_STAND, 2005 );
			checked = 1;
		end;
		if ( IsSomeUnitInArea( 0, "most", 0 ) == 0 ) and ( checked == 1 ) then
			Cmd( ACT_MOVE, 2005, 50, GetScriptAreaParams( "rallypoint" ) );
			WaitForGroupAtArea( 2005, "rallypoint" );
			Cmd( ACT_ROTATE, 2005, 100, GetScriptAreaParams( "guardpos" ) );
			QCmd( ACT_STAND, 2005 );
			checked = 0;
		end;
	end;
end;

function StartZdez()
	while ( IsSomeUnitInArea( 0, "start", 0) > 0 ) do
		Wait( 3 );
	end;
	Cmd( ACT_SWARM, 2006, 100, GetScriptAreaParams( "artillery1" ) );
end;

function German_Tiger( sid )
	LandReinforcementFromMap( 1, "0", 1, sid );
	Cmd( ACT_SWARM, sid, 200, GetScriptAreaParams( "post2" ) );
	QCmd( ACT_ROTATE, sid, 200, GetScriptAreaParams( "dot1" ) );
	QCmd( ACT_ENTRENCH, sid, 1 );
end;

function Allied_Attack1( sid )
	LandReinforcementFromMap( 2, "0", 0, sid );
	Cmd( ACT_SWARM, sid, 200, GetScriptAreaParams( "post2" ) );
	WaitForGroupAtArea( sid, "post2" );
	Cmd( ACT_SWARM, sid, 200, GetScriptAreaParams( "gorod" ) );
	WaitForGroupAtArea( sid, "gorod" );
	Wait( 60 );
	Cmd( ACT_SWARM, sid, 200, GetScriptAreaParams( "post1" ) );
end;

function Allied_Attack2()
local sid = 17001;
local sid2 = 17002;
	LandReinforcementFromMap( 2, "1", 1, sid );
	Cmd( ACT_MOVE, sid, 100, GetScriptAreaParams( "dot1" ) );
	
	Wait( 5 );
	
	LandReinforcementFromMap( 2, "1", 1, sid2 );
	Cmd( ACT_MOVE, sid2, 100, GetScriptAreaParams( "dot2" ) );
end;

function Allied_Attack3()
local sid = 17003;
	LandReinforcementFromMap( 2, "2", 0, sid );
	Cmd( ACT_MOVE, sid, 200, GetScriptAreaParams( "dot1" ) );
end;

function Allied_Manager2( sid )
	while ( missionend == 0 ) and ( IsSomeUnitInArea( 0, "gorod", 0 ) == 0 ) and
		( IsSomeUnitInArea( 2, "gorod", 0 ) == 0 ) do
		StartThread( Allied_Attack1, sid );
		Wait( 100 + RandomInt( 20 ) );
		sid = sid + 1;
	end;
end;

function Allied_Manager()
	StartThread( Allied_Attack1, 18000 );
	Wait( 60 );
	StartThread( Allied_Attack2 );
	Wait( 60 );
	StartThread( Allied_Manager2, 18001 );
	Wait( 20 );
	StartThread( German_Tiger, 19000 );
	Wait( 60 );
	StartThread( German_Tiger, 19001 );
end;

function Objective0()
	if ( IsSomeUnitInArea( 1, "most", 0 ) < 1 ) and 
		( IsSomeUnitInArea( 0, "most", 0 ) > 0 ) then
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjective( 1 );
		StartThread( CheckEng );
		return 1;
    end;
	if ( IsSomeBodyAlive( 0, 2712 ) == 0 ) then -- bridge is destroyed
		Wait( 3 );
		FailObjective( 0 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeUnitInArea( 1, "gorod", 0 ) == 0 ) and ( IsSomeUnitInArea( 0, "gorod", 0 ) > 0 ) then
		CompleteObjective( 1 );
		missionend = 1;
		Wait( 3 );
		Win( 0 );
		return 1;
    end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 0, 2712 ) == 0 ) then -- bridge is destroyed
		Wait( 3 );
		FailObjective( 2 );
		return 1;
	end;
end;

function CheckEng()
local destroyed = 0;
	while ( missionend == 0 ) do
		Wait( 4 );
		if ( IsSomeBodyAlive( 0, 2712 ) == 0 ) then
			destroyed = 1;
		end;
		if ( destroyed == 1 ) and ( IsSomeBodyAlive( 0, 911 ) == 0 ) then
			LandReinforcementFromMap( 0, "engineers", 0, 911 );
			Cmd( ACT_MOVE, 911, 100, GetScriptAreaParams( "nearbridge" ) );
		end;
		if ( destroyed == 1 ) and ( GetScriptObjectHPs( 2712 ) == 4000 ) then
			destroyed = 0;
		end;
	end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( GetNUnitsInPlayerUF( 0 ) <= 0 ) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) 
			or ( IsReinforcementAvailable( 0 ) == 0 ) ) ) then
			missionend = 1;
			Wait( 3 );
			Win( 1 );
			return
		end;
		for u = 0, Objectives_Count - 1 do
			if ( GetIGlobalVar( "temp.objective." .. u, 0 ) == 3 ) then
				missionend = 1;
				Wait( 3 );
				Win( 1 ); -- player looses
				return
			end;
		end;
	end;
end;

function DeployMines()
local i;
local cx, cy;
local lx, ly = 500, -400;
local mines_total = 8;
local dx = lx / mines_total;
local dy = ly / mines_total;
local defaultx, defaulty = GetScriptObjCoord( 555 );
	cx, cy = GetScriptAreaParams( "post1" );
	cx = cx - lx;
	cy = cy - ly;
	Cmd( ACT_PLACE_MINE, 555, 20, cx , cy );
	for i = 1, mines_total do
		cx = cx + dx;
		cy = cy + dy;
		QCmd( ACT_PLACE_MINE, 555, 20, cx, cy );
	end;
	QCmd( ACT_MOVE, 555, 0, defaultx, defaulty );
end;

function Artillery()
	while ( GetIGlobalVar( "temp.objective.0", 0 ) ~= 2 ) do
		Wait( 2 );
	end;
	StartThread( ArtilleryDeploy );
	StartThread( DeployMines );
	Wait( 120 );
	Allied_Manager();
end;

function Recon()
	Wait( 120 + Random( 60 ) );
	StartThread( ReconDeploy );
end;

function ArtilleryDeploy()
local Reinf_art = "1";
local Reinf_ScriptId = 8888;
local units = {};
	LandReinforcementFromMap( 1, Reinf_art, 0 , Reinf_ScriptId );
	Wait( 1 );
	--units = GetObjectListArray( Reinf_ScriptId );
	--trucks = GetUnitsByParam( units, PT_CLASS, CLASS_APC );
	Cmd( ACT_DEPLOY, Reinf_ScriptId, 200, GetScriptAreaParams( "artillery" ) );
	QCmd( ACT_RESUPPLY, Reinf_ScriptId, 300, GetScriptAreaParams( "artillery" ) );
end;

function ReconDeploy()
local Reinf_recon = "2";
local Reinf_ScriptId = 9999;
	LandReinforcementFromMap( 1, Reinf_recon, 0 , Reinf_ScriptId );
	Wait( 1 );
	Cmd( ACT_MOVE, Reinf_ScriptId, 300, GetScriptAreaParams( "artillery0" ) );
	QCmd( ACT_MOVE, Reinf_ScriptId, 300, GetScriptAreaParams( "artillery1" ) );	
end;

function LightAttack()
local sid = 7500;
local units = {};
local inf = {};
	while ( IsSomeBodyAlive( 1, 750 ) == 1 ) do
		LandReinforcementFromMap( 1, "3", 0, sid );
		Wait( 1 );
		units = GetObjectListArray( sid );
		inf = GetUnitsByParam( units, PT_TYPE, TYPE_INF );
		tanks = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
		ChangeFormation( sid, 1 );
		Wait( 1 );
		Cmd( ACT_SWARM, sid, GetScriptAreaParams( "artillery1" ) );
		Wait( 1 );
		UnitCmd( ACT_FOLLOW, tanks[1], inf[1] );
		UnitCmd( ACT_FOLLOW, tanks[2], inf[2] );
		Wait( 150 );
		sid = sid + 1;
	end;
end;

----------------------------------
Objectives = { Objective0, Objective1 };
Objectives_Count = 2;

StartAllObjectives( Objectives, Objectives_Count );
Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( Artillery );
StartThread( Recon );
StartThread( BridgeGuard );
StartThread( StartZdez );
StartThread( LightAttack );
StartThread( FlagManager, 2 );
