missionend = 0;
tanks_num = GetNUnitsInScriptGroup( 1000 );
hp1 = GetScriptObjectHPs( 1 );

function Defence( areanum )
	while 1 do
		Wait( 2 );
		if ( IsSomeUnitInArea( 0, "defence"..areanum, 0 ) == 1 ) then
			break;
		end;
	end;
	while 1 do
		Wait( 2 );
		if ( IsSomeUnitInArea( 0, "defence"..areanum, 0 ) == 0 ) then
			break;
		end;
	end;
	LandReinforcementFromMap( 1, "sherman", 1, 100 );
	Cmd( ACT_SWARM, 100, 200, GetScriptAreaParams( "deploy"..areanum ) );
	--QCmd( ACT_ROTATE, 100, 200, GetScriptAreaParams( "dir"..areanum ) );
	--QCmd( ACT_ENTRENCH, 100 );
end;

function Shuher()
	while ( IsSomeUnitInArea( 0, "bridge", 0 ) == 0 ) do
		Wait( 1 );
	end;
	Cmd( ACT_MOVE, 110, 200, GetScriptAreaParams( "runaway" ) );
	QCmd( ACT_ENTER, 110, 111 );
end;

function Shuher1()
local units = {};
local exit = 0;
	while exit == 0 do
		units = GetUnitListOfPlayerArray( 0 );
		tigers = GetUnitsByParam( units, PT_CLASS, CLASS_HEAVY_TANK );
		for i = 1, tigers.n do
			if ( IsUnitInArea( 0, "sherman", tigers[i] ) == 1 ) then
				exit = 1;
				break;
			end;
		end;
		Wait( 2 );
	end;
	RetreatScriptGroup( 2, GetScriptAreaParams( "runaway1" ) );
	QCmd( ACT_ENTRENCH, 2, 1 );
end;

function Objective0()
local units = GetUnitListOfPlayerArray( 0 );
local heavytanks = GetUnitsByParam( units, PT_CLASS, CLASS_HEAVY_TANK );
--local num = GetNUnitsInScriptGroup( 1000 );

	if ( heavytanks.n > tanks_num ) then
		tanks_num = heavytanks.n;
	end;
	
	--if ( ( GetNScriptUnitsInArea( 1000, "exit" ) == tanks_num ) and
		if ( GetNArrayUnitsInArea( 0, "exit", heavytanks ) == heavytanks.n ) then
		CompleteObjective( 0 );
		return 1;
    end;
	--if ( num < tanks_num ) or 
	if ( heavytanks.n < tanks_num ) then
		FailObjective( 0 );
		return 1;
	end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( IsSomeUnitInParty( 0 ) == 0 ) and ( ( GetReinforcementCallsLeft( 0 ) == 0 )
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

function WinCheck()
local obj;
	while ( missionend == 0 ) do
		obj = 1;
		Wait( 2 );
		for u = 0, Objectives_Count - 1 do
			if ( GetIGlobalVar( "temp.objective." .. u, 0 ) ~= 2 ) then
				obj = 0;
				break;
			end;
		end;
		if ( obj == 1 ) then
			missionend = 1;
			Wait( 3 );
			Win( 0 ); -- player wins
			return
		end
	end;
end;

function CheckRush()
	if ( IsSomeUnitInArea( 0, "rush", 0 ) == 1 ) then
		return 1;
	end;
end;

function Rush()
	LandReinforcementFromMap( 1, "sherman", 1, 2712 );
	Cmd( ACT_SWARM, 2712, 200, GetScriptAreaParams( "rush" ) );
end;

----------------------------------
Objectives = { Objective0 };
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );

Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( Defence, 1 );
--StartThread( Defence2 );
StartThread( Shuher );
StartThread( Shuher1 );
Trigger( CheckRush, Rush );
--StartThread( FlagManager, 1 );
Wait( 3 );
DamageScriptObject( 5, 100 );
ChangePlayerForScriptGroup( 5, 2 );
Wait( 1 );
DamageScriptObject( 5, 100 );
