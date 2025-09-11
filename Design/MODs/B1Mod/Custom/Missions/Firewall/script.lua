sid = 3000;
missionend = 0;
Objectives_Count = 4;
attacks2 = 0;

OldIsSomeBodyAlive = IsSomeBodyAlive;

function IsSomeBodyAlive( ... )
local res = 0;
local player = 0;
	if ( arg.n == 1 ) then
		while ( IsPlayerPresent( player ) == 1 ) and ( res == 0 ) do
			if OldIsSomeBodyAlive( player, arg[1] ) > 0 then
				res = 1;
			end;
			player = player + 1;
		end;
	else
		res = OldIsSomeBodyAlive( arg[1], arg[2] );
	end;
	return res;
end;

function WaitWhileAlive( pl, scriptid )
	while IsSomeBodyAlive( pl, scriptid ) == 1 do
		Wait( 3 );
	end;
end;

function AlliedRush()

	for i = 1, 3 do
		Cmd( ACT_SWARM, i, 0, "p1" );
		QCmd( ACT_SWARM, i, 0, "p2" );
		QCmd( ACT_SWARM, i, 0, "p3" );
	end;
	OfficerLook();
end;

function OfficerLook()
	for i = 1, 4 do
		Cmd( ACT_MOVE, 50, 200, "off"..i )
		QCmd( ACT_SPYGLASS, 50, 200, "off"..(i + 1) );
		if ( i < 4 ) then
			WaitWhileAlive( 1, 770 + i );
		end;
	end;
end;

function DeployDefenceAttack()
	maininf = { n = 0 };
	assinf = { n = 0 };
	ltanks = { n = 0 };
	
	for i = 1, 3 do
		sortedunits = GetSortedByClassUnits( GetObjectListArray( i ) );
		maininf = ConcatArray( maininf, sortedunits[ CLASS_MAIN_SQUAD ] );
		assinf = ConcatArray( assinf, sortedunits[ CLASS_ASSAULT_SQUAD ] );
		Trace( "2 : "..ltanks.n );
		ltanks = ConcatArray( ltanks, sortedunits[ CLASS_LIGHT_TANK ] );
	end;
	Trace( "maininf.n = %g", maininf.n );
	Trace( "assinf.n = %g", assinf.n );
	Trace( "ltanks.n = %g", ltanks.n );
	trenches = {};
	guns = {};
	
	k = 1;
	for i = 1, 4 do
		if ( IsSomeBodyAlive( 3, 110 + i ) == 1 ) then
			guns[k] = GetObjectList( 110 + i );
			k = k + 1;
		end;
	end;
	guns.n = k;
	
	for i = 1, 4 do
		trenches[ i ] = GetObjectListArray( 2000 + i );
	end;
	trenches.n = 4;
	
	for i = 1, ltanks.n do
		UnitCmd( ACT_MOVE, ltanks[i], 100, "tank_pos"..i );
		UnitQCmd( ACT_ROTATE, ltanks[i], 100, "tank_dir"..i );
		UnitQCmd( ACT_ENTRENCH, ltanks[i], 1 );
	end;
	
	if ( assinf.n <= guns.n ) then
		par = assinf.n;
	else
		par = guns.n;
	end;
	for i = 1, par do
		UnitCmd( ACT_TAKE_ARTILLERY, assinf[i], guns[i] );
	end;
	if ( par < assinf.n ) then
		for i = par + 1, assinf.n do
			UnitCmd( ACT_ENTER, assinf[i], GetObjectList( 2000 ) );
		end;
	end;
	
	if ( maininf.n <= trenches.n ) then
		par = maininf.n;
	else
		par = trenches.n;
	end;
	for i = 1, par do
		tr = trenches[i][Random( trenches[i].n )];
		Trace( "tr = %g", tr );
		UnitCmd( ACT_ENTER, maininf[i], tr );
	end;
	if ( par < maininf.n ) then
		for i = par + 1, maininf.n do
			UnitCmd( ACT_ENTER, maininf[i], GetObjectList( 2000 ) );
		end;
	end;
	
	Cmd( ACT_MOVE, 50, 200, "off5" )
	QCmd( ACT_SPYGLASS, 50, 200, "off6" );
end;

function Objective0()
	if ( ( IsSomeBodyAlive( 2, 1 ) + IsSomeBodyAlive( 2, 2 ) + IsSomeBodyAlive( 2, 3 ) ) == 0 ) then
		FailObjective( 0 );
		return 1;
	end;
	
	if ( ( IsSomeBodyAlive( 1, 10 ) + IsSomeBodyAlive( 1, 11 ) + IsSomeBodyAlive( 1, 12 ) + 
		IsSomeBodyAlive( 1, 13 ) + IsSomeBodyAlive( 1, 900 ) + IsSomeBodyAlive( 1, 901 ) +
		IsSomeBodyAlive( 1, 111 ) + IsSomeBodyAlive( 1, 112 ) + IsSomeBodyAlive( 1, 113 ) +
		IsSomeBodyAlive( 1, 114 ) + IsSomeBodyAlive( 1, 902 ) ) == 0 ) then
		StartThread( DeployDefenceAttack );
		Wait( 3 );
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjective( 1 );
		StartThread( AttackManager );
		Wait( 3 );
		LandReinforcementFromMap( 0, "reinf1", 1, 1000 );
		Wait( 3 );
		StartCycled( Objective1 );
		return 1;
	end;
end;

function AttackManager()
dest = { "tank_pos1", "tank_pos2" };

	for i = 1, 2 do
		pt = RandomInt( 2 );
		sid = sid + 1;
		LandReinforcementFromMap( 1, "atk"..Random( 2 ) , pt, sid );
		Cmd( ACT_SWARM, sid, 0, dest[pt + 1] );
		if ( i == 2 ) then
			attacks2 = 1;
		else
			Wait( 120 + Random( 20 ) );
		end;
	end;
end;

function AttackersDead()
	if ( attacks2 == 0 ) then
		return 0;
	end;
	for i = 3001, sid do
		if ( IsSomeBodyAlive( 1, i ) == 1 ) then
			return 0;
		end;
	end;
	return 1;
end;

function CheckOnTheHill()
	if ( IsSomeUnitInArea( 0, "hill", 0 ) == 1 ) then
		return 1;
	end;
end;

function GiveUnitsToPlayer()
	for i = 1, 3 do
		ChangePlayerForScriptGroup( i, 0 );
	end;
	for i = 1, 4 do
		if ( IsSomeBodyAlive( 2, 110 + i ) == 1 ) then
			ChangePlayerForScriptGroup( 110 + i, 0 );
		end;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 0, 1000 ) == 0 ) or ( ( ( IsSomeBodyAlive( 1 ) + IsSomeBodyAlive( 2 ) +
		IsSomeBodyAlive( 3 ) ) == 0 ) and ( IsSomeUnitInArea( 0, "hill", 0 ) == 0 ) ) then
		FailObjective( 1 );
		return 1;
	end;
	if ( IsSomeUnitInArea( 0, "hill", 0 ) == 1 ) and ( AttackersDead() == 1 ) then
		CompleteObjective( 1 );
		Wait( 3 );
		GiveObjective( 2 );
		StartCycled( Objective2 );
		Wait( 3 );
		LandReinforcementFromMap( 0, "reinf2", 1, 1001 );
		return 1;
	end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 1, 99 ) == 0 ) then
		CompleteObjective( 2 );
		Wait( 3 );
		GiveObjective( 3 );
		StartCycled( Objective3 );
		if ( GetNUnitsInScriptGroup( 1001 ) <= 5 ) then
			LandReinforcementFromMap( 0, "reinf2", 1, 1002 );
		end;
		return 1;
	end;
end;

function Objective3()
	if ( IsSomeBodyAlive( 1, 100 ) == 0 ) then
		CompleteObjective( 3 );
		return 1;
	end;
end;

function NearHill()
	if ( IsSomeUnitInArea( 2, "nearhill", 0 ) == 1 ) then
		Wait( 3 + Random( 3 ) );
		Cmd( ACT_MOVE, 10, 100, "p3" );
		for i = 11, 13 do
			Cmd( ACT_MOVE, i, 100, GetScriptObjCoord( 100 + i ) );
			QCmd( ACT_TAKE_ARTILLERY, i, 100 + i );
		end;
		Wait( 10 + Random( 10 ) );
		Cmd( ACT_MOVE, 901, 100, "z2" );
		Wait( 20 + Random( 10 ) );
		Cmd( ACT_MOVE, 900, 100, "z1" );
		QCmd( ACT_SWARM, 900, 200, "z2" );
		return 1;
	end;
end;

function NearRoad()
	if ( IsSomeUnitInArea( 2, "nearroad", 0 ) == 1 ) then
		Trace( "near road" );
		Cmd( ACT_MOVE, 202, 300, "p2" );
		Cmd( ACT_MOVE, 203, 300, "p2" );
		Wait( 5 + Random( 5 ) );
		Cmd( ACT_MOVE, 200, 0, "t1" );
		Cmd( ACT_SWARM, 201, 200, "atk1" );
		--Cmd( ACT_SWARM, 200, 0, "t1" );
		for i = 2, 4 do
			QCmd( ACT_MOVE, 200, 0, "t"..i );
			--QCmd( ACT_SWARM, 200, 0, "t"..i );
		end;
		return 1;
	end;
end;

function check_unit_id98()
	if ( PlayerCanSee( 0, GetObjectList( 98 ) ) == 1 ) then
		return 1;
	end;
end;

function unit_id98_move()
	Cmd( ACT_MOVE, 98, 0, "y1" );
	QCmd( ACT_MOVE, 98, 0, "y2" );
end;

GiveObjective( 0 );
StartThread( AlliedRush );
StartCycled( Objective0 );
StartCycled( NearHill );
StartCycled( NearRoad );
Trigger( CheckOnTheHill, GiveUnitsToPlayer );
Trigger( check_unit_id98, unit_id98_move );

StartThread( LooseCheck, 4 );
StartThread( WinCheck, 4 );