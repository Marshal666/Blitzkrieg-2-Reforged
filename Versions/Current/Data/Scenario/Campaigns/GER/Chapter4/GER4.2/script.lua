missionend = 0;
tanks_num = GetNUnitsInScriptGroup( 1000 );
hp1 = GetScriptObjectHPs( 1 );
tigers1 = {};
tigers1 = GetObjectListArray( 1000 );
unit_sid170 = GetObjectList( 170 );
__difficulty = GetDifficultyLevel();

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

function Shuher2()
local exit = 0;
	while exit == 0 do
		Wait( 2 );
		for i = 1, tigers1.n do
			if ( UnitCanSee( unit_sid170, tigers[i], 1 ) == 1 ) then
				exit = 1;
				break;
			end;
		end;
	end;
	Retreat( unit_sid170, GetScriptAreaParams( "170_retreat" ) );
end;

function Objective0()
--local units = GetUnitListOfPlayerArray( 0 );
--local heavytanks = GetUnitsByParam( units, PT_CLASS, CLASS_HEAVY_TANK );
--local num = GetNUnitsInScriptGroup( 1000 );

	--if ( heavytanks.n > tanks_num ) then
	--	tanks_num = heavytanks.n;
	--end;
	
	--if ( ( GetNScriptUnitsInArea( 1000, "exit" ) == tanks_num ) and
	--	if ( GetNArrayUnitsInArea( 0, "exit", heavytanks ) == heavytanks.n ) then
	if ( GetNScriptUnitsInArea( 1000, "exit" ) == 2 ) then
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjective( 1 );
		StartCycled( Objective1 )
		return 1;
    end;

	--if ( num < tanks_num ) or 
	--if ( heavytanks.n < tanks_num ) then
	if ( GetNUnitsInScriptGroup( 1000 ) < tanks_num ) then
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
	if ( ( GetNScriptUnitsInArea( 1000, "rush" ) + GetNScriptUnitsInArea( 1000, "bridge" ) ) >= 1 ) then
		return 1;
	end;
end;

function Rush()
	Wait( 3 + Random( 3 ) );
	LandReinforcementFromMap( 1, "sherman", 1, 2712 );
	Wait( 1 );
	LandReinforcementFromMap( 1, "comb", 1, 2712 );
	Cmd( ACT_SWARM, 2712, 200, "exit" );
	Wait( 3 );
	LandReinforcementFromMap( 1, "sherman2", 3, 2711 );
	--Wait( 1 );
	--LandReinforcementFromMap( 1, "sherman", 1, 2711 );
	Cmd( ACT_SWARM, 2711, 200, "exit" );
	
	Cmd( ACT_SWARM, 710, 200, "exit" );
	Cmd( ACT_SWARM, 810, 200, "exit" );
	Cmd( ACT_SWARM, 2, 200, "exit" );

	Wait( 150 );
	Cmd( ACT_SWARM, 2711, 200, "exit" );
	Cmd( ACT_SWARM, 710, 200, "exit" );
	Cmd( ACT_SWARM, 810, 200, "exit" );
	Cmd( ACT_SWARM, 2, 200, "exit" );
	Cmd( ACT_SWARM, 2712, 200, "exit" );
end;

function SecretObjCheck()
local cnt = 0;
	for i = 810, 812 do
		cnt = cnt + IsSomeBodyAlive( 1, i );
	end;
	if ( cnt == 0 ) then
		LandReinforcementFromMap( 1, "sherman", 2, 9910 );
		Wait( 1 );
		LandReinforcementFromMap( 1, "sherman", 2, 9910 );
		Cmd( ACT_SWARM, 9910, 0, "town" );
		StartCycled( SecretObj );
		return 1;
	end;
end;

function SecretObj()
	if ( IsSomeBodyAlive( 1, 9910 ) == 0 ) then
		CompleteObjective( 1 );
		return 1;
	end;
end;

function Objective1()
	if ( ( IsSomeBodyAlive( 1, 2712 ) + IsSomeBodyAlive( 1, 2711 ) + 
		IsSomeBodyAlive( 1, 810 ) + IsSomeBodyAlive( 1, 710 ) + 
		IsSomeBodyAlive( 1, 2 ) ) == 0 ) then
		CompleteObjective( 1 );
		return 1;
	end;
	if ( IsSomeBodyAlive( 0, 1000 ) == 0 ) then
		FailObjective( 1 );
		return 1;
	end;
end;

function BackAttack()
	Wait( 20 + Random( 30 ) );
	LandReinforcementFromMap( 1, "comb", 2, 8970 );
	Cmd( ACT_SWARM, 8970, 200, "back_attack" );
	QCmd( ACT_SWARM, 8970, 200, "back_attack2" );
end;

function ChaffeeAttack()
	Wait( 120 + Random( 30 ) );
	LandReinforcementFromMap( 1, "lt", 3, 4567 );
	Cmd( ACT_SWARM, 400, 200, "back_attack" );
	QCmd( ACT_SWARM, 400, 200, "back_attack2" );
	QCmd( ACT_SWARM, 400, 200, "deploy1" );
	QCmd( ACT_SWARM, 400, 200, "sherman" );
	QCmd( ACT_SWARM, 400, 200, "deploy1" );
	QCmd( ACT_SWARM, 400, 200, "back_attack2" );
	QCmd( ACT_SWARM, 400, 200, "back_attack" );
	QCmd( ACT_SWARM, 400, 200, "town" );
	QCmd( ACT_SWARM, 400, 200, "exit" );
end;

function Korolky()
	for i = 1, tigers1.n do
		if ( IsImmobilized( tigers1[i] ) == 1 ) then
			LandReinforcementFromMap( 0, "eng", 0, 10911 );
			Wait( 1 );
			StartCycled( Engineers );
			return 1;
		end;
	end;
end;

function Engineers()
	if ( IsSomeBodyAlive( 0, 10911 ) == 0 ) then
		Wait( 2 );
		LandReinforcementFromMap( 0, "eng", 0, 10911 );
	end;
end;

function AICalls()
local shermans_id = 10870;
local pt = 0;
local target;
	while GetObjectiveState( 0 ) ~= 2 do
		Wait( 140 - __difficulty * 40 );
		--GiveReinforcementCalls( 1, 1 );
		shermans_id = shermans_id + 1;
		target = GetObjectListArray( 1000 )[Random(2)];
		if ( IsUnitInArea( 0, "mountain", target ) == 1 ) then
			pt = 1;
		else
			pt = 3;
		end;
		LandReinforcementFromMap( 1, "sherman", pt, shermans_id );
		StartThread( Engagement, shermans_id, target );
	end;
end;

function Engagement( engage_id, target )
	while IsSomeBodyAlive( 1, engage_id ) == 1 do
		Cmd( ACT_SWARM, engage_id, 200, ObjectGetCoord( target ) );
		Wait( 3 );
	end;
end;

----------------------------------
--Objectives = { Objective0 };
Objectives_Count = 2;

StartCycled( Objective0 );
--SetAmmo( GetObjectList( 222 ), 0, 0, 0 );
Wait( 1 );
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( Defence, 1 );
--StartThread( Defence2 );
--StartThread( Shuher );
StartThread( Shuher1 );
StartThread( Shuher2 );
StartThread( BackAttack );
StartThread( ChaffeeAttack );
StartCycled( Korolky );
Trigger( CheckRush, Rush );
StartThread( AICalls );

Wait( 3 );
DamageScriptObject( 5, 40 );
ChangePlayerForScriptGroup( 5, 2 );
Wait( 1 );
DamageScriptObject( 5, 40 );