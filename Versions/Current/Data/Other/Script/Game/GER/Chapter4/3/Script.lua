missionend = 0;

function Para_Assault( sid, point, dest )
local graph = {};
local units = {};
local inf = {};
local sid_ = sid;

	LandReinforcementFromMap( 1, "para", point, sid_ );
	Cmd( ACT_UNLOAD, sid_, 200, GetScriptAreaParams( dest ) );
	Wait( 1 );
	units = GetObjectListArray( sid_ );
	inf = GetUnitsByParam( units, PT_TYPE, TYPE_INF ); -- ??? sometimes units are nil

	WaitWhileStateArray( inf, 1 );
	WaitWhileStateArray( inf, 27 );
	
	if ( Random( 10 ) <= 3 ) then
		Cmd( ACT_SWARM, sid_, 200, GetScriptAreaParams( "factory" ) );
	end;
end;

function Attack_Manager()
local pt, pt1, dest, atk;
local sid = 15000;
	Wait( 20 + Random( 20 ) );
	while ( missionend == 0 ) do
		pt = Random( 3 );
		dest = "para" .. Random( 3 );
		StartThread( Para_Assault, sid, pt, dest );
		
		--Wait( 5 + RandomInt( 3 ) );
		--sid = sid + 1;
		
		--StartThread( Para_Assault, sid, pt, dest );
		Wait( 180 + RandomInt( 20 ) );
		sid = sid + 1;
	end;
end;

function Objective0()
	if ( GetGameTime() >= 800 ) then
		if ( GetNUnitsInScriptGroup( 501, 1 ) == 0 ) then
			CompleteObjective( 0 );
			return 1;
		else
			FailObjective( 0 );
			return 1;
		end;
	end;
	if ( GetNUnitsInScriptGroup( 100 ) < 4 ) then
		FailObjective( 0 );
		return 1;
	end;
	if ( ( GetNUnitsInPlayerUF( 0 ) - GetNUnitsInScriptGroup( 404, 0 ) <= 0 ) 
		and ( ( GetReinforcementCallsLeft( 0 ) == 0 )
		or ( IsReinforcementAvailable( 0 ) == 0 ) ) ) then
		FailObjective( 0 );
		return 1;
	end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( Objectives_Count ~= nil ) then
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
end;

----------------------------------
Objectives = { Objective0 };
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );

Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( Attack_Manager );
