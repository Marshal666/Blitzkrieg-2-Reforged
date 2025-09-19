missionend = 0;
__difficulty = GetDifficultyLevel();

function Objective0()
	if ( IsSomeUnitInArea( 0, "Exits", 0 ) > 0 ) and ( IsSomeUnitInArea( 1, "Exits", 0 ) == 0 ) and 
		( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		if ( GetUnitsByParam( GetUnitListInAreaArray( 0, "Exits", 0 ), PT_TYPE, TYPE_MECH ).n > 0 ) then
			CompleteObjective( 0 );
			return 1;
		end;
	end;
end;

function NearBridge()
	if ( IsSomeUnitInArea( 0, "bridge", 0 ) == 1 ) then
		return 1;
	end;
end;

function CounterAttack()
	Wait( 2 + Random( 2 ) );
	LandReinforcementFromMap( 1, "counter", 4, 2000 );
	Cmd( ACT_SWARM, 2000, 200, "before_bridge" );
	Wait( 2 );
	if ( __difficulty >= 1 ) then
		LandReinforcementFromMap( 1, "gap", 4, 50 );
		Cmd( ACT_MOVE, 50, 200, "before_bridge" );
	end;
	StartCycled( Objective0 );
end;

function Dot()
	if ( IsSomeBodyAlive( 0, 300 ) == 1 ) then
		return 1;
	end;
end;

function DotAttack()
	Wait( 2 + Random( 2 ) );
	LandReinforcementFromMap( 1, "assinf", 4, 2001 );
	Cmd( ACT_ENTER, 2001, 300 );
	Wait( 2 );
	ChangeFormation( 2001, 3 );
end;

function SecretObj()
	if ( IsSomeBodyAlive( 0, 911 ) ~= 0 ) then
		CompleteObjective( 1 );
		--ChangePlayerForScriptGroup( 110, 3 );
		--Cmd( ACT_STOP, 110 );
		Wait( 3 );
		EnablePlayerSuperWeapon( 0, 1 );
		return 1;
	end;
end;

-- destroy bridge on hard and very hard
function bridge888()
	Wait( 1 );
	if __difficulty >= 1 then
		DamageScriptObject( 888, 0 );
	end;
end;

function inf_attack()
	if __difficulty == 0 then
		return 1;
	end;
	Wait( 60 + Random( 30 ) );
	LandReinforcementFromMap( 1, "assinf", 3, 60 );
	Wait( 1 );
	ChangeFormation( 60, 3 );
	Wait( 1 );
	Cmd( ACT_SWARM, 60, 200, "inf" );
	QCmd( ACT_ENTER, 60, 61 );
end;

----------------------------------
Objectives = { Objective0 };
Objectives_Count = 1;

--StartAllObjectives( Objectives, Objectives_Count );
--StartCycled( SecretObj );
if __difficulty >= 1 then
	SetCatchArtFlag( 120, CATCH_ALL );
end;
GiveObjective( 0 );
StartThread( LooseCheck );
StartThread( WinCheck );
Trigger( NearBridge, CounterAttack );
Trigger( Dot, DotAttack );
StartThread( bridge888 );
StartThread( inf_attack );