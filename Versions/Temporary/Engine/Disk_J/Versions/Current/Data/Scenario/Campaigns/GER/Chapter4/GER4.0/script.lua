missionend = 0;
max_hps = {};
for i = 100001, 100003 do
	max_hps[i] = GetScriptObjectHPs( i );
end;
__difficulty = GetDifficultyLevel();


function Objective0()
	if ( IsSomeBodyAlive( 0, 502 ) ~= 0 ) then
		CompleteObjective( 0 );
		Wait( 3 );
		GiveObjective( 1 );
		return 1;
	end;
end;

function Objective1()
	if ( IsSomeBodyAlive( 0,503 ) ~= 0 ) then
		CompleteObjective( 1 );
		Wait( 3 );
		GiveObjective( 2 );
		return 1;
	end;
end;

function Objective2()
	if ( IsSomeBodyAlive( 1, 111 ) == 0 ) then
		CompleteObjective( 2 );
		Wait( 3 );
		GiveObjective( 3 );
		return 1;
	end;
end;

function Objective3()
	if ( IsSomeBodyAlive( 0, 504 ) ~= 0 ) then
		CompleteObjective( 3 );
		Wait( 3 );
		GiveObjective( 4 );
		return 1;
	end;
end;

function Objective4()
	if ( IsSomeBodyAlive( 0, 505 ) ~= 0 ) then
		CompleteObjective( 4 );
		Wait( 3 );
		Win( 0 );
		return 1;
	end;
end;

function SecretObjective()
	if ( IsSomeBodyAlive( 0, 506 ) ~= 0 ) then
		CompleteObjective( 5 );
		Wait( 3 );
		LandReinforcementFromMap( 0, "rocket", 0, 9991 );
		return 1;
	end;
end;

function BridgeHealing()
	while 1 do
		Sleep( 10 );
		for i = 100001, 100003 do
			if ( GetScriptObjectHPs( i ) < (max_hps[i] - 1) ) then
				DamageScriptObject( i, GetScriptObjectHPs( i ) - max_hps[i] );
			end;
		end;
	end;
end;

function Check_PanzerWerfer()
	if ( GetObjectiveState( 0 ) == 2 ) then
		return 1;
	end;
end;

function PanzerWerfer()
	LandReinforcementFromMap( 0, "rocket", 0, 9991 );
end;

function Check_Attack()
	if ( IsSomeUnitInArea( 0, "bridge", 0 ) == 1 ) then
		return 1;
	end;
end;

function USAttack()
	LandReinforcementFromMap( 0, "jagdtigers", 5, 9992 );
	Wait( 3 );
	LandReinforcementFromMap( 1, "attack", 2, 9900 );
	Cmd( ACT_SWARM, 9900, 200, "bridge" );
end;

function group10()
	if ( IsSomeBodyAlive( 1, 10 ) == 0 ) then
		LandReinforcementFromMap( 1, "attack", 3, 670 );
		Cmd( ACT_SWARM, 670, 100, "cliff1" );
		return 1;
	end;
end;

----------------------------------

Objectives = { Objective0, Objective1, Objective2, Objective3, Objective4 };
Objectives_Count = 5;

StartAllObjectives( Objectives, Objectives_Count );

if ( __difficulty >= 1 ) then
	SetCatchArtFlag( 160, CATCH_ALL );
end;
Wait( 1 );
GiveObjective( 0 );
StartCycled( SecretObjective );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( BridgeHealing );
if ( __difficulty >= 1 ) then
	StartCycled( group10 );
end;
--Trigger( Check_PanzerWerfer, PanzerWerfer );
Trigger( Check_Attack, USAttack );