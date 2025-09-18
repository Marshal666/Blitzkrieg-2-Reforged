missionend = 0;
cnt_id = 123000;
max_hps = {};
__difficulty = GetDifficultyLevel();
for i = 100, 103 do
	max_hps[i] = GetScriptObjectHPs( i );
end;
delay_table = { {0, 40, 70}, {110, 125, 140}, {180, 190, 200}, {270, 270, 270},
	{340, 340, 340}, {410, 450, 470}, {550, 560, 560} };
delay_order = {};
delays = {};
for i = 1, 7 do
table = { 1, 2, 3; n = 3 };
	delay_order[i] = {};
	delays[i] = {};
	for j = 1, 3 do
		delay_order[i][j] = table[ Random( table.n ) ];
		table = DeleteElement( table, delay_order[i][j] );
		Trace( table.n );
		if i > 1 then
			delays[i][j] = delay_table[i][delay_order[i][j]] - 
							delay_table[i-1][delay_order[i-1][j]];
		else
			delays[i][j] = delay_table[i][delay_order[i][j]];
		end;
	end;
end;

table = { 0, 1, 2; n = 3 };
stupid_number = {};
stupid_number[1] = table[ Random( table.n ) ];
table = DeleteElement( table, stupid_number[1] );
stupid_number[2] = table[ Random( table.n ) ];

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
	
	--if ( Random( 10 ) <= 3 ) then
		Cmd( ACT_SWARM, sid_, 200, GetScriptAreaParams( "factory" ) );
	--end;
end;

function Attack_Manager()
local pt, pt1, dest, atk;
local sid = 15000;
	Wait( 60 + Random( 20 ) );
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

function Para_descent()
	local pt = RandomInt( 3 );
	local dest = "para" .. Random( 3 );
	sid = 8710;
	StartThread( Para_Assault, sid, pt, dest );
end;

function Objective0()

	if ( GetNUnitsInScriptGroup( 501, 1 ) == 0 ) then
		if ( GetGameTime() >= 700 ) then
			CompleteObjective( 0 );
			return 1;
		end;
	else
		FailObjective( 0 );
		return 1;
	end;

	--for i = 100, 102 do
	--	if ( IsSomeBodyAlive( 2, i ) == 0 ) then
	--		FailObjective( 0 );
	--		return 1;
	--	end;
	--end;

	--if ( ( GetNUnitsInPlayerUF( 0 ) - GetNUnitsInScriptGroup( 404, 0 ) <= 0 ) 
	--	and ( ( GetReinforcementCallsLeft( 0 ) == 0 )
	--	or ( IsReinforcementAvailable( 0 ) == 0 ) ) ) then
	--	FailObjective( 0 );
	--	return 1;
	--end;

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

function BridgeHealing()
	while 1 do
		Sleep( 10 );
		for i = 100, 103 do
			if ( GetScriptObjectHPs( i ) < (max_hps[i] - 1) ) then
				DamageScriptObject( i, GetScriptObjectHPs( i ) - max_hps[i] );
			end;
		end;
	end;
end;


function SecretObj()
	while 1 do
		Wait( 1 );
		if ( IsUnitNearScriptObject( 0, 404, 200 ) == 1 ) then
			break;
		end;
	end;
	ChangePlayerForScriptGroup( 404, 0 );
	while 1 do
		Wait( 1 );
		if ( GetNScriptUnitsInArea( 404, "poezd" ) >= 1 ) then
			break;
		end;
	end;
	ChangePlayerForScriptGroup( 404, 2 );
	Cmd( ACT_MOVE, 404, 0, "end" );
	Wait( 2 );
	Cmd( ACT_DISAPPEAR, 404 );
	Wait( 1 );
	CompleteObjective( 2 );
	Wait( 3 );
	LandReinforcementFromMap( 0, "units", 1, 9999 );
end;

function Objective1()
	if ( GetNUnitsInScriptGroup( 502, 0 ) == 1 ) then
		CompleteObjective( 1 );
		Wait( 3 );
		Win( 0 );
		return 1;
	end;
end;

function MainAttack( point, reinf )
	cnt_id = cnt_id + 1;
	LandReinforcementFromMap( 1, reinf, point, cnt_id );
	Cmd( ACT_SWARM, cnt_id, 0, "para" .. ( point + 1 ) );
	QCmd( ACT_SWARM, cnt_id, 0, "factory" );
end;

function MainAttacksManager( pt )
local atk_cnt = 1;
local time1 = 75;
local df = __difficulty;
local diff = df;
	if df == 2 then
		df = 1;
	end;
local num_reinfs = { 1, 1, 1 + df, 1 + df, 2 + df, 1, 1 };

	--Wait( 7 + Random( 5 ) );
	while GetObjectiveState( 0 ) ~= 2 do
		if ( GetObjectiveState( 1 ) == 2 ) and ( pt ~= 0 )then
			return 1;
		end;
		
		if ( atk_cnt < 7 ) then
			Wait( delays[atk_cnt][pt+1] + Random( 5 ) );
			atk_cnt = atk_cnt + 1;
		else
			Wait( time1 + Random( 5 ) );
		end;
		
		if ( GetObjectiveState( 0 ) == 2 ) or ( ( GetObjectiveState( 1 ) == 2 ) and ( pt ~= 0 ) ) then
			return 1;
		end;
		
		for i = 1, num_reinfs[ atk_cnt ] do
			if ( atk_cnt >= 6 ) then
				for i = 1, 2 - diff, 1 do
					if ( pt == stupid_number[i] ) then
						return
					end;
				end;
				reinf = "comb" .. (Random( 2 ) + 4);
			elseif ( atk_cnt >= 3 ) then
				reinf = "comb" .. (Random( 2 ) + 2);
			else
				reinf = "comb" .. Random( 2 );
			end;
			StartThread( MainAttack, pt, reinf );
			Wait( 5 + Random( 5 ) );
		end;
	end;
end;

function M40Fire()
local pos = 2;
	if ( __difficulty == 0 ) then
		UnitRemove( GetObjectListArray( 2010 )[ Random( 2 ) ] );
		while ( IsSomeBodyAlive( 1, 2010 ) == 1 ) do
			Wait( 15 );
			Cmd( ACT_SUPPRESS, 2010, 700, "art_fire" );
		end;
	elseif ( __difficulty >= 1 ) then
		while ( IsSomeBodyAlive( 1, 2010 ) == 1 ) do
			--Wait( 15 );
			--Cmd( ACT_SUPPRESS, 2010, 700, "art_fire" );
			--Wait( 10 );
			--Cmd( ACT_STAND, 2010 );
			Wait( 60 );
			Cmd( ACT_MOVE, 2010, 500, "spg" .. pos );
			QCmd( ACT_STAND, 2010 );
			pos = 5 - pos;
		end;
	end;
end;

----------------------------------

Objectives = { Objective0, Objective1 };

Objectives_Count = 2;


SetIGlobalVar( "temp.general_reinforcement", 0 );
StartAllObjectives( Objectives, Objectives_Count );
StartThread( BridgeHealing );

Wait( 1 );

GiveObjective( 0 );
GiveObjective( 1 );

StartThread( LooseCheck );

StartThread( WinCheck );
StartThread( M40Fire );

--StartThread( Attack_Manager );
--Wait( 60 );
StartThread( SecretObj );
--StartThread( SecretObj2 );

for i = 0, 2 do
	StartThread( MainAttacksManager, i );
end;
Wait( 500 );
StartThread( Para_descent );