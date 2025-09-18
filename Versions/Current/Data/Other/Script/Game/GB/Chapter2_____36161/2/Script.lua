-- enemy reinf id consts
Reinf_Enemy_MediumTanks = 1;
Reinf_Enemy_HeavyTanks = 2;
Reinf_Enemy_LightTanks = 0;

-- map objects scriptid
Objective1Units = 100;
Objective2Units = 101;
UnitsId = 2000;

-- other
MINRADIUS = 50;
SIGHTRANGE = 37 * 32;
RADIUS = 512;
DISPERSION = 1024;

giveall = 0;
missionend = 0;

function TanksAttack()
	Wait( 60 );
	Cmd( ACT_SWARM, Objective4Units, 256, GetScriptAreaParams( "TanksAttack" ) );
end;

function CheckArea()
	for i = 1, 4 do
	if ( GetNUnitsInArea( 0, "Check" .. i, 0 ) > 0 ) then
		return 1;
	end
	end;
end;

function Attack0()
	Wait( 20 );
	Cmd( ACT_SWARM, 101, 256, GetScriptAreaParams( "Attack" .. "11" ) );
	for i = 2, 5 do
		QCmd( ACT_SWARM, 101, 256, GetScriptAreaParams( "Attack" .. 1 .. i ) );
	end;
	Cmd( ACT_SWARM, 102, 256, GetScriptAreaParams( "Attack" .. "21" ) );
	for i = 2, 5 do
		QCmd( ACT_SWARM, 102, 256, GetScriptAreaParams( "Attack" .. 2 .. i ) );
	end;
end;

function Attack()
local Reinfs_Enemy = { Reinf_Enemy_LightTanks, Reinf_Enemy_MediumTanks, Reinf_Enemy_HeavyTanks };
local cnt = 2;
local hp_sum = 0;
	UnitsId = UnitsId + 1;
	local CurrentId = UnitsId;
	--if ( GetIGlobalVar( "Bonus.El_Alamein.4", 0) == 1 ) then
	--	cnt = 3;
	--end;
	Reinforcement = Reinfs_Enemy[ Random( cnt ) ];
	LandReinforcementFromMap( 1, Reinforcement, 0, CurrentId );
	local dir = Random( 2 );
	Wait( 2 );
	local units = GetObjectListArray( CurrentId );
	for i = 1, units.n do
		hp_sum = hp_sum + GetObjectHPs( units[i] );
	end;
	local hp = hp_sum;
	Cmd( ACT_SWARM, CurrentId, 256, GetScriptAreaParams( "Attack" .. dir .. "1" ) );
	for i = 2, 5 do
		QCmd( ACT_SWARM, CurrentId, 256, GetScriptAreaParams( "Attack" .. dir .. i ) );
	end;
	while ( hp > ( hp_sum / 2.0 ) ) do
		Wait( 1 );
		hp = 0;
		for i = 1, units.n do
			local _hp = GetObjectHPs( units[i] );
			if ( _hp > 0 ) then
				hp = hp + _hp;
			end;
		end;  
	end;
	if ( Random( 2 ) == 1 ) then
		Cmd( ACT_ENTRENCH, CurrentId, 1 );
	else
		RetreatGroup( units, GetScriptAreaParams( "Defence" .. Random( 3 ) ) );
		Wait( 60 );
		if ( GetNUnitsInScriptGroup( CurrentId ) > 0 ) then
			dir = Random( 2 );
			Cmd( ACT_SWARM, CurrentId, 256, GetScriptAreaParams( "Attack" .. dir .. "1" ) );
			for i = 2, 5 do
				QCmd( ACT_SWARM, CurrentId, 256, GetScriptAreaParams( "Attack" .. dir .. i ) );
			end;
		end
	end;
end;

function StartAttacks()
local RecycleTime = 80;
local RecycleTimeRandom = 20;

	while ( ( missionend == 0 ) and ( ( GetNUnitsInScriptGroup( 502, 1 ) + GetNUnitsInScriptGroup( 502, 2 ) ) == 1 ) ) do
		StartThread( Attack );
		Wait( RecycleTime + Random( RecycleTimeRandom ) );
	end;
end;

function CompletePriObjective( objnum )
	ObjectiveChanged( objnum, 2 );
	SetIGlobalVar( "temp.objective.p" .. objnum, 2 );
end;

function FailPriObjective( objnum )
	ObjectiveChanged( objnum, 3 );
	SetIGlobalVar( "temp.objective.p" .. objnum, 3 );
end;

function GivePriObjective( objnum )
	ObjectiveChanged( objnum, 1 );
	SetIGlobalVar( "temp.objective.p" .. objnum, 1 );
	StartThread( PriObjectives[ objnum ] );
end;

function PriObjective1() -- defend the town
	while 1 do
		Wait( 2 );
		if ( IsSomeUnitInArea( 0, "Town1", 0 ) == 0 ) and ( IsSomeUnitInArea( 1, "Town1", 0 ) > 0 ) and 
		( GetNUnitsInScriptGroup( 501, 1 ) == 1 ) then
			FailPriObjective( 1 );
			break;
		end;
	end;
end;

function PriObjective2() -- capture enemy town
	while 1 do
		Wait( 2 );
		if ( IsSomeUnitInArea( 1, "Town2", 0 ) == 0 ) and ( IsSomeUnitInArea( 0, "Town2", 0 ) > 0 ) and 
		( GetNUnitsInScriptGroup( 502, 0 ) == 1 ) then
			CompletePriObjective( 1 );
			CompletePriObjective( 2 );
			break;
		end;
	end;
end;


function WinCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( GetIGlobalVar( "temp.objective.p2", 0 ) == 2 ) then
			missionend = 1;
			Wait( 3 );
			--SetIGlobalVar( "Bonus.El_Alamein.2", 1);
			Win( 0 ); -- player wins
		end;
	end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( IsSomePlayerUnit( 0 ) == 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) ) then
			Win( 1 );
			missionend = 1;
		end;
		for u = 1, Primary_Objectives_Count do
			if ( GetIGlobalVar( "temp.objective.p" .. u, 0 ) == 3 ) then
				missionend = 1;
				Wait( 3 );
				Win( 1 ); -- player looses
				break;
			end;
		end;
		--for u = 1, Secondary_Objectives_Count do
		--	if ( GetIGlobalVar( "temp.objective.s" .. u, 0 ) == 3 ) then
		--		Wait( 3 );
		--		Win( 1 ); -- player looses
		--		break;
		--	end;
		--end;
	end;
end;

-----
function KeyBuilding_Flag()
local tmpold = { 0, 1 };
local tmp;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 2 do
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

-- Main Script --
PriObjectives = { PriObjective1, PriObjective2 };
Primary_Objectives_Count = 2;

--CheckBonuses();
Wait( 1 );
GivePriObjective( 1 );
GivePriObjective( 2 );
Sleep( 10 );

Trigger( CheckArea, StartAttacks ) ;

StartThread( Attack0 );
StartThread( WinCheck );
StartThread( LooseCheck );
StartThread( KeyBuilding_Flag );
