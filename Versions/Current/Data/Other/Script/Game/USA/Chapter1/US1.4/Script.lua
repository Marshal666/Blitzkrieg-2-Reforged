-- variables
missionend = 0;
Disp = 50;

area = { "Defence" };
area.n = 1;
area_state = { 1 };
area_state.n = 1;
--ScriptID's
id1 = 101;

trench_segments = {};
trench_segments[1] = GetObjectListArray( 199 );
trench_segments[2] = GetObjectListArray( 198 );
trench_segments[3] = GetObjectListArray( 197 );

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
		if ( ( IsSomeUnitInParty ( 0 ) == 0 ) and ( IsReinforcementAvailable ( 0 ) == 0 ) ) then
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
				return 1;
			end;
		end;
	end;
end;

function Objective0()
	if ( area_state[1] == 0 ) and ( GetIGlobalVar( "temp.objective.0", 0 ) == 1 ) then
		Wait( 3 );
		CompleteObjective( 0 );
		if ( GetIGlobalVar( "temp.objective.1", 0 ) ~= 1 ) then
			GiveObjective( 1 );
		end;
		return 1;
	end;
end;

function Objective1()
	if ( GetIGlobalVar( "temp.objective.1", 0 ) == 1 ) and IsSomeBodyAlive( 1, 101 ) == 0 then
		Wait( 3 );
		CompleteObjective( 1 );
		return 1;
	end;
end;

function AreaManager()
	for i = 1, area_state.n do
		StartThread( AreaState, i );
	end;
end;

function AreaState( n )
local k=0;
	while 1 do
		if area_state[n] == 1 then
			while k < 3 do
			 if IsSomeUnitInArea ( 0, area[n], 0 ) == 1 and IsSomeUnitInArea ( 1, area[n], 0 ) == 0 then
				k = k + 1;
			 else
				k = 0;
			 end;
			 Wait(5);
			end;
			area_state[n] = 0; 
			Trace("area_state[%g]=%g - our", n, area_state[n] );
		else
			while k < 3 do
			 if IsSomeUnitInArea ( 1, area[n], 0 ) == 1 and IsSomeUnitInArea ( 0, area[n], 0 ) == 0 then
				k = k + 1;
			 else
				k = 0;
			 end;
			 Wait(5);
			end;
			area_state[n] = 1; -- 1 = area failed
			Trace("area_state[%g]=%g - enemy", n, area_state[n] );
		end;
		k = 0;
		Wait( 2 );
	end;
end;

function DeadTank()
local HP = 0;
local array = GetObjectListArray( 99 );
	ChangePlayerForScriptGroup( 99, 1 );
	Wait( 1 );
	StartThread( AttackObject, 99, 98 );
	Wait( 2 );
	HP = GetObjectHPs ( array[1] );
	Trace("HP = %g", HP );
	DamageScriptObject ( 99, HP + 1 );
	DamageScriptObject ( 98, 0 );
end;

function AttackObject( id, id1 )
	Cmd( ACT_ATTACKUNIT, id, id1 );
end;

function Defence()
	local n = "0";
	local k = 0;
	local id = 1000;
	local m = 0;
	local coord1 = { { 6713, 5378 }, { 4313, 5322 }, { 4240, 3956 } };
	local coord0 = { { 1363, 6657 }, { 2198, 4886 }, { 4240, 3956 } };
	local t = 0;
	
	while m < 6 do
		t = GetNUnitsInArea ( 1, area[1], 0 );
		while ( t - GetNUnitsInArea ( 1, area[1], 0 ) ) < 3 do
			Wait( 5 );
		end;
		Wait( Random( 10 ) + 10 );
		if Random( 2 ) == 1 then
			n = "2";
		else
			n = "0";
		end;
		k = RandomInt( 2 ); Trace("%g", k);
		LandReinforcementFromMap( 1, n, k, id );
		Wait(1);
		if k == 0 then
			StartThread( Reinf, coord0, id );
		else
			StartThread( Reinf, coord1, id );
		end;
		id = id + 1;
		m = m + 1;
		Wait( Random( 90 ) + 90 );
	end;
end;

function Alarm( id )
local coord = { { 5536, 6808 }, { 3697, 7094 } };
local i = 1;
local y = 0;
if id == 119 then
	i = 1;
else
	i = 2;
end;
	while 1 do
		if IsUnitNearScriptObject ( 0, 121, 800 ) == 1 or IsUnitNearScriptObject ( 0, 122, 800 ) == 1 then
			Wait( Random( 3 ) + 3 );
			if id == 119 then
				Wait( Random( 5 ) + 5 );
			end;
			Cmd ( ACT_LEAVE, id , 200, coord[i][1], coord[i][2] );
			Wait( 2 );
			ChangeFormation( id, 0 );
			Cmd( ACT_SWARM, id , 200, coord[i][1], coord[i][2] );
			return 1;
		end;
		Wait(3);
	end;
end;

function Patrol( id )
	local coord = {};
	local k = 1;
	if id == 125 then
		coord = { { 5162, 6771 }, { 5758, 6713 }, { 6858, 7476 },{ 7306, 6860 } };
	else
		coord = { { 3361, 7061 }, { 1990, 7684 }, { 985, 7982 },{ 1356, 6808 } };
	end;
	while IsSomeBodyAlive ( 1, id ) do
		while k < 4 do
			QCmd( ACT_SWARM, id, 50, coord[k][1], coord[k][2] );
			Wait(1);
			k = k + 1;
		end;
		Wait( 10 );
		while k > 1 do
			QCmd( ACT_SWARM, id, 50, coord[k][1], coord[k][2] );
			Wait(1);
			k = k - 1;
		end;
		Wait( 20 );
	end;
end;

function Reinf( array, id )
	local trench = { 199, 198, 197 };
	local coord = {};
	local d = 100;
	local units = GetObjectListArray ( id );
	local inf = {};
	local mech = {};
	local hh, segment;
	
	mech = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
	inf = GetUnitsByParam( units, PT_TYPE, TYPE_INF );
	ChangeFormation( id, 1 );
	Cmd( ACT_SWARM, id, 100, array[1][1], array[1][2] );
	for i = 2, 3 do
		QCmd( ACT_SWARM, id, d, array[i][1], array[i][2] );
		d = d + 100;
	end;
	while GetNScriptUnitsInArea ( id, area[1], 0 ) <= 0 and IsSomeBodyAlive ( 1, id ) == 1 do
		Wait( 1 );
	end;
	Trace("Enter to Defence");
	ChangeFormation( id, 0 );
	Wait( Random( 3 ) + 3 );
	if NumUnitsAliveInArray( inf ) > 0 then
		for i = 1, inf.n do
			if Random( 4 ) == 1 then
				StartThread( Form, inf[i], id );
			elseif IsUnitNearScriptObject ( 0, id, 1000 ) == 1 then
				hh = Random( 2 ) + 1;
				segment = trench_segments[ hh ][ Random( trench_segments[ hh ].n ) ];
				UnitCmd( ACT_SWARM, inf[i], 64, ObjectGetCoord( segment ) );
				UnitQCmd( ACT_ENTER, inf[i], segment );
			else
				hh = Random( 3 );
				segment = trench_segments[ hh ][ Random( trench_segments[ hh ].n ) ];
				UnitCmd( ACT_SWARM, inf[i], 64, ObjectGetCoord( segment ) );
				UnitQCmd( ACT_ENTER, inf[i], segment );
			end;
		end;
	end;
	if NumUnitsAliveInArray( mech ) > 0 then
		for i = 1, inf.n do
			UnitCmd( ACT_SWARM, mech[i], 700, GetScriptAreaParams( area[1]) );
			if Random( 2 ) == 1 then
				UnitQCmd( ACT_ENTRENCH, mech[i], 1 );
			end;
		end;
	end;
end;

function Form( unit, id )
	Wait( Random( 10 ) + 10 );
	UnitCmd( ACT_STOP, unit );
	ChangeFormation( id, 2 );
end;

function Art()
	local rnd = Random(2);
	local coord = {{ 1977, 3738 },{ 7055, 3628 }};
	Cmd( ACT_SUPPRESS, 101, 500, coord[rnd][1], coord[rnd][2] );
	Wait( Random( 15 ) + 15 );
	Cmd( ACT_STOP, 101 );
end;

Objectives = { Objective0, Objective1 };
Objectives_Count = 2;

StartAllObjectives( Objectives, Objectives_Count );
GiveObjective( 0 );
StartThread( Alarm, 119 );
StartThread( Alarm, 120 );
StartThread( Patrol, 125 );
StartThread( Patrol, 126 );
StartThread( Defence );
StartThread( DeadTank );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( AreaManager );
Wait( Random( 15 ) + 15 );
Art();
GiveObjective( 1 );