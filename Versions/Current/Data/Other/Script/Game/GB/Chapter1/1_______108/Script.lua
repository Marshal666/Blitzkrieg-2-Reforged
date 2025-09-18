missionend = 0;
Total_1 = GetNUnitsInScriptGroup( 1, 1 );
Total_911 = GetNUnitsInScriptGroup( 911, 1 );

function Patrol1()
local pt = 6;
	while ( IsSomeBodyAlive( 1, 100 ) > 0 ) do
		if ( pt > 8 ) then
			pt = 1;
		end;
		Cmd( ACT_SWARM, 100, 192, GetScriptAreaParams( "P" .. pt ) );
		WaitForGroupAtArea( 100, "P" .. pt );
		Wait( Random( 10 ) );
		pt = pt + 1;
	end;
end;

function Patrol2()
local pt = 1;
	while ( IsSomeBodyAlive( 1, 101 ) > 0 ) do
		if ( pt > 8 ) then
			pt = 1;
		end;
		Cmd( ACT_SWARM, 101, 192, GetScriptAreaParams( "P" .. pt ) );
		WaitForGroupAtArea( 101, "P" .. pt );
		Wait( Random( 10 ) );
		pt = pt + 1;
	end;
end;

function Objective0()
	if ( IsSomeBodyAlive( 1, 1 ) == 0 ) then
		CompleteObjective( 0 );
		missionend = 1;
		Wait( 3 );
		Win( 0 );
		return 1;
    end;
end;

function Objective1()
	if ( GetNUnitsInScriptGroup( 501, 0 ) == 1 ) then
		CompleteObjective( 1 );
		SetIGlobalVar( "temp.general_reinforcement", 0 );
		return 1;
    end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( IsSomePlayerUnit( 0 ) == 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) ) then
			missionend = 1;
			Wait( 3 );
			Win( 1 );
			return
		end;
	end;
end;

function CheckReinf()
	while ( GetNUnitsInScriptGroup( 1, 1 ) >= Total_1 ) do
		Wait( 2 );
	end;
	SetIGlobalVar( "temp.general_reinforcement", 1 );
end;

function CheckLight()
	while ( GetNUnitsInScriptGroup( 911, 1 ) >= Total_911 ) do
		Wait( 2 );
	end;
	Wait( 5 + Random( 5 ) );
	SwitchSquadLightFX( 2712, 1 );
end;

-----
function KeyBuilding_Flag()
local tmpold = { 1 };
local tmp;
local count = 1;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, count do
		if ( GetNUnitsInScriptGroup( i + 500, 0 ) == 1 ) then
			tmp = 0;
		elseif ( GetNUnitsInScriptGroup( i + 500, 1 ) == 1 ) then
			tmp = 1;
		end;
		if ( tmp ~= tmpold[i] ) then
			if ( tmp == 0 ) then
				SetScriptObjectHPs( 700 + i, 50 );
			else
				SetScriptObjectHPs( 700 + i, 100 );
			end;
			tmpold[i] = tmp;
		end;
	end;
	end;
end;
-----

Objectives = { Objective0, Objective1 };
Objectives_Count = 2;

SwitchSquadLightFX( 2712, 0 );
SetIGlobalVar( "temp.general_reinforcement", 0 );
StartAllObjectives( Objectives, Objectives_Count );
Wait( 1 );
GiveObjective( 0 );
GiveObjective( 1 );
StartThread( LooseCheck );
StartThread( Patrol1 );
--StartThread( Patrol2 );
StartThread( CheckReinf );
StartThread( CheckLight );
StartThread( KeyBuilding_Flag );
