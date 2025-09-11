sid = 1000;
atkwave = { 4, 5, 6 };
delays = { 15, 12, 10 };

function IsAliveAndMobile( scriptid )
obj = GetObjectListArray( scriptid );
	for i = 1, obj.n do
		if ( IsAlive( obj[ i ] ) == 1 ) and ( IsImmobilized( obj[ i ] ) == 0 ) then
			return 1;
		end;
	end;
	return 0;
end;

function Attack( reinf, pt )
local point = "p"..pt;
	sid = sid + 1;
	LandReinforcementFromMap( 1, reinf, pt, sid );
	Cmd( ACT_SWARM, sid, 0, point .. "1" );
	for i = 2, 5 do
		QCmd( ACT_SWARM, sid, 0, point .. i );
	end;
end;

function Attack_Manager()
	for wave = 1, 3 do
		for atk = 1, atkwave[ wave ] do
			StartThread( Attack, "attack" .. wave .. "_" .. Random( 3 ), RandomInt( 4 ) );
			Wait( delays[ wave ] + Random( 10 ) );
		end;
		if ( wave == 3 ) then
			LandReinforcementFromMap( 0, "reinf2", 1, 10002 );
		end;
		Wait( 60 + Random( 10 ) );
		if ( wave == 2 ) then
			LandReinforcementFromMap( 0, "reinf1", 2, 10001 );
		end;
		Wait( 60 + Random( 10 ) );
	end;
	for atk = 1, 4 do
		StartThread( Attack, "ferdinand", atk );
	end;
	StartCycled( Objective0 );
end;

function Objective0()
local sum = 0;
	for i = 1001, sid do
		sum = sum + IsAliveAndMobile( i );
	end;
	if ( sum == 0 ) then
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjective( 1 );
		GiveObjective( 2 );
		Wait( 5 );
		LandReinforcementFromMap( 0, "reinf3", 0, 10003 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		CompleteObjective( 1 );
		return 1;
	end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 1, 20 ) == 0 ) then
		CompleteObjective( 2 );
		return 1;
	end;
end;

function LooseCheck()
	if ( IsSomePlayerUnit( 0 ) == 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
		Win( 1 );
		return 1;
	end;
end;

function WinCheck()
local o = 0;
	for i = 0, 2 do
		if ( GetObjectiveState( i ) ~= 2 ) then
			o = 1;
			break;
		end;
	end;
	if ( o == 0 ) then
		Wait( 2 );
		Win( 0 );
	end;
end;

GiveObjective( 0 );
Wait( 2 );
StartThread( Attack_Manager );
StartCycled( Objective1 );
StartCycled( Objective2 );
StartCycled( LooseCheck );
StartCycled( WinCheck );