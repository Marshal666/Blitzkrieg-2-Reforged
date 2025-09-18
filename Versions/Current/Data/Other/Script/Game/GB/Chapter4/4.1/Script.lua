missionend = 0;
Bridge = 111; -- ScriptID
FourDotsID = 1111; -- ScriptID
FifthDotID = 11111; -- ScriptID
Disp = 50;
EnemyFourDots = 1;
EnemyFifthDot = 1;
Bicycle = 150;
Hummel1 = 151;
Hummel2 = 152;
AA = 153;

function Patrol( id, action )
local k = 1;
	while k <= 9 do
		Cmd( action, id, 20, GetScriptAreaParams( "Art" .. k ) );
		WaitForGroupAtArea( id, "Art" .. k );
		k = k + 1;
		if id == 150 then
			Wait( RandomInt( 2 ) );
		end;
--		if id == 153 and GetNUnitsNearScriptObj( 0, id, 1100 ) > 0 then
--			Cmd( ACT_ENTRENCH, id, 1 );
--			while GetNUnitsNearScriptObj( 0, id, 1100 ) > 0 do
--				Wait(10);
--			end;
--		end;
		if id == 153 and GetNUnitsNearScriptObj( 0, id, 1100 ) > 0 then
			Cmd( ACT_ENTRENCH, id, 1 );
			while GetNUnitsNearScriptObj( 0, id, 1100 ) > 0 do
				Wait(10);
			end;
		end;
	end;
	if id == 151 then
		k = Random( 5 );
		Cmd( action, id, 100, GetScriptAreaParams( "DefH" .. k ) );
		WaitForGroupAtArea( id, "DefH" .. k );
		StartThread( HummelAction, id, k );
	end;
	if id == 152 then
		k = Random( 5 );
		Cmd( action, id, 100, GetScriptAreaParams( "DefH" .. k ) );
		WaitForGroupAtArea( id, "DefH" .. k );
		StartThread( HummelAction, id, k );
	end;
	if id == 153 then
		k = Random( 5 );
		Cmd( action, id, 100, GetScriptAreaParams( "AA" .. k ) );
		WaitForGroupAtArea( id, "AA" .. k );
		Cmd( ACT_ENTRENCH, id, 1 );
	end;
end;

function HummelAction( id, k )
	local rnd_coord = 0;
	local l = 0;
	coord_for_suppress = { {7615,2452}, {7043,1908}, {7624,876} };
	coord_for_suppress.n = 3;
	Wait(Random(10));
	while l<2 do
		while k <= 5 do
			Cmd( ACT_MOVE, id, 100, GetScriptAreaParams( "DefH" .. k ) );
			WaitForGroupAtArea( id, "DefH" .. k );
			rnd_coord = Random(3);
			Cmd( ACT_SUPPRESS, id, 100, coord_for_suppress[rnd_coord][1], coord_for_suppress[rnd_coord][2] );
			Wait(Random(20) + 20);
			k = k + 1;
		end;
		l = l + 1;
	end;
	Cmd( ACT_STOP, id );
end;

function ArtAction( id )
	local x = 7560;
	local y = 3287;
	if id == 162 or id == 163 then
		x = x - 100;
	end;
	if id == 161 or id == 162 or id == 163 then
		y = y - (id - 160)*200;
	end;
	Cmd( ACT_SUPPRESS, id, 20, x, y );
	Wait( 5 );
	while y > 2000 do 
		Cmd( ACT_SUPPRESS, id, 20, x, y );
		Wait( 5 );
		y = y - 200;
	end;
	Cmd( ACT_STOP, id );
end;

function Objective0()
	if ( EnemyFourDots == 0 ) and ( EnemyFifthDot == 0 ) and ( GetIGlobalVar( "temp.objective.0", 0 ) == 1 ) then
		Wait( 3 );
		CompleteObjective( 0 );
	end;
	
	if ( GetNUnitsInScriptGroup( 111 ) == 0 ) then -- bridge is destroyed
		FailObjective( 0 );
		return 1;
	end;
end;

function DotsCheck()
	while 1 do
	local a = GetObjectListArray(1111);
	local k = 0;
		for i=1, a.n do
			if IsAlive(a[i]) == 1 and NumUnitsAliveInArray(GetArray(GetPassangers( a[i], 1 ))) > 0 then
				k = k + 1;
			end;
		end;
--		Trace("Four k=%g",k);	
--		if IsSomeBodyAlive( 1111, 1 ) == 1  then
		if k == 0 then
			EnemyFourDots = 0;
			Trace( "EnemyFourDots=%g", EnemyFourDots );
			SetIGlobalVar("temp.general_reinforcement", 0);
		end;
	local b = GetObjectListArray(11111);
	k = 0;
		for i=1, b.n do
			if IsAlive(b[i]) == 1 and NumUnitsAliveInArray(GetArray(GetPassangers( b[i], 1 ))) > 0 then
				k = k + 1;
			end;
		end;
--		Trace("Fifth k=%g",k);	
--		if IsSomeBodyAlive( 11111,1 ) == 1 then
		if k == 0 then
			EnemyFifthDot = 0;
		end;
	k = 0;	
		Wait(3);
	end;
end;

function WinCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( GetIGlobalVar( "temp.objective.0", 0 ) == 2 ) then
			Wait( 3 );
			Win( 0 ); -- player wins
			missionend = 1;
		end;
	end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( GetNUnitsInParty( 0 ) <= 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) ) then
			missionend = 1;
			Wait( 3 );
			Win( 1 );
			return 1;
		end;
		for u = 0, Objectives_Count - 1 do
			if ( GetIGlobalVar( "temp.objective." .. u, 0 ) == 3 ) then
				missionend = 1;
				Wait( 3 );
				Win( 1 ); -- player looses
				return 1;
			end;
		end;
	end;
end;
SetIGlobalVar("temp.general_reinforcement", 0);
Trace( "EnemyFourDots=%g", GetNUnitsInScriptGroup( 1111, 1 ) );
Trace( "EnemyFifthDots=%g", GetNUnitsInScriptGroup( 11111, 1 ) );
Objectives = { Objective0 };
Objectives_Count = 1;

StartAllObjectives( Objectives, Objectives_Count );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( ArtAction, 160 );
Wait(1);
StartThread( ArtAction, 161 );
Wait(1);
StartThread( ArtAction, 162 );
Wait(1);
StartThread( ArtAction, 163 );
Wait( Random( 20 ) + 20);
StartThread( DotsCheck );
StartThread( Patrol, Bicycle, 3 );
Wait(Random(2));
StartThread( Patrol, Hummel1, 0 );
Wait(Random(2));
StartThread( Patrol, Hummel2, 0 );
Wait(Random(2));
StartThread( Patrol, AA, 0 );
Wait(120);
SetIGlobalVar("temp.general_reinforcement", 1);
