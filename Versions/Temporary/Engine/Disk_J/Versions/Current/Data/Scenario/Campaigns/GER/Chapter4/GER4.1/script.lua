missionend = 0;
__difficulty = GetDifficultyLevel();

pt_gap = { 5, 1, 6 };
gap_id = 7000;
towns_1 = { "town1", "town2", "town3" };

graph1 = {};
graph1["para1"] = { "town1", "town2"; n = 2 };
graph1["para2"] = { "town1", "town2", "town3"; n = 3 };
graph1["para3"] = { "town1", "town3"; n = 2 };
graph1["para4"] = { "town2", "town3"; n = 2 };
 
graph2 = {};
graph2[ 1 ] = { "para3", "para4" };
graph2[ 2 ] = { "para1", "para2" };
 
graph3 = {};
graph3["town1"] = { "para1", "para2", "para3"; n = 3 };
graph3["town2"] = { "para1", "para2", "para4"; n = 3 };
graph3["town3"] = { "para2", "para3", "para4"; n = 3 };
 
graph4 = {};
graph4["para1"] = { 1, 5, 6; n = 3 };
graph4["para2"] = { 0, 1, 3, 4, 5, 6; n = 6 };
graph4["para3"] = { 0, 3, 4; n = 3 };
graph4["para4"] = { 0, 1, 3, 4, 5, 6; n = 6 };
 
towns = { 1, 1, 1 };
 
pseudoname = {};
pseudoname["town1"] = 1;
pseudoname["town2"] = 2;
pseudoname["town3"] = 3;
 
currentattack = 0;
 
mortars_list = {};
mortars_list.push = function( array, atk ) 
	if ( mortars_list[atk] == nil ) then 
		mortars_list[atk] = {};
	end;
	mortars_list[atk] = ConcatArray( mortars_list[atk], array );
end;
 
troops_list = {};
troops_list.push = function( array, atk ) 
	if ( troops_list[atk] == nil ) then 
		troops_list[atk] = {};
	end;
	troops_list[atk] = ConcatArray( troops_list[atk], array );
end;
 
function gettown() 
	local j = 0;
	local tlist = {};
	for i = 1, 3 do 
		if ( towns[i] == 1 ) then 
			j = j + 1;
			tlist[j] = "town"..i;
		end;
	end;
	local a = Random( j );
	return tlist[a];
end;
 
function Attack1( sid, sid1 ) 
	LandReinforcementFromMap( 1, "0", 0, sid );
	Cmd( ACT_MOVE, sid, 200, GetScriptAreaParams( "bomb2" ) );
 
	Wait( 15 + Random( 5 ) );
	LandReinforcementFromMap( 1, "0", 1, sid1);
	Cmd( ACT_MOVE, sid1, 200, GetScriptAreaParams( "bomb1" ) );
end;
 
function Para_Assault( sid, point, dest, atk ) 
local graph = {};
local units = {};
local inf = {};
local sid_ = sid;
 
	LandReinforcementFromMap( 1, "1", point, sid_ );
	Cmd( ACT_UNLOAD, sid_, 500, GetScriptAreaParams( dest ) );
	Wait( 1 );
	units = GetObjectListArray( sid_ );
	inf = GetUnitsByParam( units, PT_TYPE, TYPE_INF );
	
	--Trace( "ass state1 = %g", GetUnitState( inf[1]) );
	WaitWhileStateArray( inf, 1 );
	--Trace( "ass state1 = %g", GetUnitState( inf[1]) );
	WaitWhileStateArray( inf, 27 );
	--Trace( "ass state1 = %g", GetUnitState( inf[1]) );
	
	if ( towns[pseudoname[atk]] == 0 ) then 
		atk = gettown();
	end;
	Cmd( ACT_SWARM, sid_, 200, GetScriptAreaParams( atk ) );
	 
	troops_list.push( inf, atk );
	-- building capture 
end;
 
function AssaultManager() 
local buildings = {};
local check = { 0, 0, 0 };
	while ( missionend == 0 ) do	 
		Wait( 5 );
		for i = 1, 3 do 
			if ( ( GetNUnitsInScriptGroup( 500 + i, 1 ) == 1 ) and ( check[i] == 0 ) ) then 
				--Trace( "%g = %g", 500 + i, 1 );
				buildings = GetObjectListArray( 600 + i );
				for j = 1, troops_list["town"..i].n do 
					if ( IsAlive( troops_list["town"..i][j] ) == 1 ) then 
					if ( GetUnitState( troops_list["town"..i][j] ) == STATE_SWARM ) then 
						UnitQCmd( ACT_ENTER, troops_list["town"..i][j], buildings[Random( buildings.n )] );
					elseif ( GetUnitState( troops_list["town"..i][j] ) ~= STATE_REST_BUILDING ) then 
						UnitCmd( ACT_ENTER, troops_list["town"..i][j], buildings[Random( buildings.n )] );
					end;
					end;
				end;
				towns[i] = 0;
				check[i] = 1;
			elseif ( ( GetNUnitsInScriptGroup( 500 + i, 1 ) == 0 ) and ( check[i] == 1 ) ) then 
				--Trace( "%g = %g", 500 + i, 0 );
				towns[i] = 1;
				check[i] = 0;
			end;
		end;
	end;
end;
 
function Para_Elite( sid, point, dest, atk ) 
	LandReinforcementFromMap( 1, 2, point, sid );
	Cmd( ACT_UNLOAD, sid, 200, GetScriptAreaParams( dest ) );
end;
 
function Para_Mortar( sid, point, dest, atk ) 
local sid1 = sid + 100;
local sid_ = sid;
local atk_x, atk_y, pos_x, pos_y, vec_x, vec_y;
local koef = 0.3;
	LandReinforcementFromMap( 1, "4", 2, sid1 );
	Cmd( ACT_MOVE, sid1, 0, 1000, 1000 );
 
	Wait( 5 );
	LandReinforcementFromMap( 1, "3", point, sid_ );
	Cmd( ACT_UNLOAD, sid_, 200, GetScriptAreaParams( dest ) );
 
	local units = GetUnitListInAreaArray( 1, "mortar", 0 );
	local gunners = GetUnitsByParam( units, PT_TYPE, TYPE_INF );
	local plane = GetObjectListArray( sid_ );
	local plane1 = GetUnitsByParam( plane, PT_CLASS, CLASS_PARADROPPER );
	 
	Wait( 1 );
 
	Trace( "gunners.n = %g",gunners.n);
	Trace( "plane1.n = %g",plane1.n);
	CmdArray( ACT_LOAD_NOW, gunners, plane1[1] );
	 
	Wait( 2 );
	--Trace( "gunners state1 = %g", GetUnitState( gunners[1]) );
	WaitWhileStateArray( gunners, 3 );
	--Trace( "gunners state2 = %g", GetUnitState( gunners[1]) );
	WaitWhileStateArray( gunners, 27 );
	Wait( 2 );
	 
	units = GetUnitListInAreaArray( 1, dest, 0 );
	if ( units.n > 0 ) then 
	 
	local mortars = GetUnitsByParam( units, PT_CLASS, CLASS_MORTAR );
--	move to attack position 
	if ( mortars.n > 0 ) then 
		if ( towns[pseudoname[atk]] == 0 ) then 
			atk = gettown();
			koef = 0.5;
		end;
		atk_x, atk_y = GetScriptAreaParams( atk );
		pos_x, pos_y = GetObjCoordMedium( mortars );
		vec_x = ( atk_x - pos_x ) * koef + pos_x;
		vec_y = ( atk_y - pos_y ) * koef + pos_y;
--	Cmd( ACT_MOVE, sid_, 300, vec_x, vec_y );
 
		CmdArrayDisp( ACT_MOVE, mortars, 300, vec_x, vec_y );
		--mortars_list.push( mortars, atk );
	end;
	 
	end;
	 
	Wait( 1 );
	units = GetObjectListArray( sid_ );
	if ( units.n > 0 ) then 
	 
	local ainf = GetUnitsByParam( units, PT_CLASS, CLASS_ASSAULT_SQUAD );
	if ( ainf.n > 0 ) then 
	--CmdArrayDisp( ACT_SWARM, ainf, 300, vec_x, vec_y );
		CmdArrayDisp( ACT_SWARM, ainf, 200, GetScriptAreaParams( atk ) );
		troops_list.push( ainf, atk );
	end;
	 
	end;
end;
 
function KillAA() 
	local units = GetUnitListOfPlayerArray( 0 );
	local guns = GetUnitsByParam( units, PT_CLASS, CLASS_HEAVY_AA_GUN );
	DamageObjectArray( guns, 0 );
end;

function AirStrike2( sid )
local pt = graph4["para1"][Random( graph4["para1"].n )];
	LandReinforcementFromMap( 1, "0", pt, sid );
	Cmd( ACT_MOVE, sid, 2000, GetScriptAreaParams( "as1" ) );
	Wait( 5 );
	sid = sid + 1;
	pt = graph4["para3"][Random( graph4["para3"].n )];
	LandReinforcementFromMap( 1, "0", pt, sid );
	Cmd( ACT_MOVE, sid, 2000, GetScriptAreaParams( "as2" ) );
end;
 
function Attack_Manager2( sid ) 
local pt, pt1, dest, atk;
 
	while ( missionend == 0 ) do
		if ( RandomInt( 4 ) == 1 ) then
			StartThread( AirStrike2, sid );
			Wait( 35 + RandomInt( 15 ) );
		else
		atk = gettown();
		--Trace( atk.."1" );
		currentattack = atk;
		dest = graph3[ atk ][ Random( graph3[ atk ].n ) ];
		pt = graph4[ dest ][ Random( graph4[ dest ].n ) ];
--		pt = RandomInt( 2 );
--		pt1 = Random( 2 );
--		dest = graph2[pt + 1][ pt1 ];
--		atk = graph1[ dest ][ Random( graph1[ dest ].n ) ];
		 
		StartThread( Para_Mortar, sid, pt, dest, atk );
		 
		Wait( 10 + RandomInt( 3 ) );
		sid = sid + 1;		 
		 
		StartThread( Para_Assault, sid, pt, dest, atk );
		 
		Wait( 5 + RandomInt( 3 ) );
		sid = sid + 1;		 
		 
		StartThread( Para_Assault, sid, pt, dest, atk );
		 
		Wait( 25 + RandomInt( 5 ) );
		sid = sid + 1;
		 
		atk = gettown();
		--Trace( atk.."2" );
		dest = graph3[ atk ][ Random( graph3[ atk ].n ) ];
		pt = graph4[ dest ][ Random( graph4[ dest ].n ) ];
--		pt = RandomInt( 2 );
--		pt1 = Random( 2 );
--		dest = graph2[pt + 1][ pt1 ];
--		atk = graph1[ dest ][ Random( graph1[ dest ].n ) ];
		 
		StartThread( Para_Assault, sid, pt, dest, atk );
		Wait( 70 + RandomInt( 20 ) );
		end;
		sid = sid + 1;
	end;
end;
 
function Attack_Manager() 
	Wait( 5 + Random( 5 ) );
	StartThread( Attack1, 18000, 18001 );
	Wait( 50 );
	StartThread( Attack_Manager2, 18002 );
end;
 
function Objective0() 
local num1 = GetNUnitsInScriptGroup( 360 );
local num2 = GetNUnitsInScriptGroup( 361 );
--local time = GetGameTime();
 
	--if ( ( num == 0 ) and ( time >= 900 ) ) then 
	--	CompleteObjective( 0 );
	--	return 1;
    --end;
	--if ( num == 3 ) or ( ( num > 0 ) and ( time >= 900 ) ) then 
	--	FailObjective( 0 );
	--	return 1;
	--end;
	if ( (num1 * num2) == 0 ) then
		FailObjective( 0 );
		return 1;
	end;
end;

function Objective2()
local num1 = 0;
local num2 = GetNUnitsInScriptGroup( 501, 1 ) + GetNUnitsInScriptGroup( 502, 1 ) + 
	GetNUnitsInScriptGroup( 503, 1 );
	--if ( ( num == 0 ) and ( time >= 900 ) ) then 
	--	CompleteObjective( 0 );
	--	return 1;
    --end;
	--if ( num == 3 ) or ( ( num > 0 ) and ( time >= 900 ) ) then 
	--	FailObjective( 0 );
	--	return 1;
	--end;
	for i = 8001, 8036 do
		num1 = num1 + IsSomeBodyAlive( 1, i );
	end;
	if ( num1 == 0 ) then
		CompleteObjective( 2 );
		return 1;
	end;
	if ( num2 >= 1 ) then
		FailObjective( 2 );
		return 1;
	end;
end;
 
function LooseCheck() 
	while ( missionend == 0 ) do 
		Wait( 2 );
		if ( ( IsSomePlayerUnit( 0 ) == 0 ) and ( ( GetReinforcementCallsLeft( 0 ) == 0 ) 
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

function SecretObj()
	if ( IsSomeBodyAlive( 1, 1828 ) == 0 ) then
		CompleteObjective( 1 );
		Wait( 3 );
		LandReinforcementFromMap( 0, "afv", 2, 9999 );
		return 1;
	end;
end;

function Para_Task( id, atk )
local graph_ass = {};
graph_ass["town1"] = { "as2", "as3"};
graph_ass["town2"] = { "as1", "as2"};
graph_ass["town3"] = { "as1", "as3"};
--local inf = GetUnitsByParam( GetObjectListArray( id ), PT_TYPE, TYPE_INF );
	--Trace( "ass state1 = %g", GetUnitState( inf[1]) );
	--WaitWhileStateArray( inf, 1 );
	--Trace( "ass state1 = %g", GetUnitState( inf[1]) );
	--WaitWhileStateArray( inf, 27 );
	--Trace( "ass state1 = %g", GetUnitState( inf[1]) );
	
	--if ( towns[pseudoname[atk]] == 0 ) then 
	--	atk = gettown();
	--end;
	
	--CmdArrayDisp( ACT_SWARM, inf, 1200, atk );
	if ( Random( 3 ) == 1 ) then
		Cmd( ACT_SWARM, id, 1000, atk );
	else
		Cmd( ACT_SWARM, id, 500, graph_ass[atk][Random(2)] );
		QCmd( ACT_SWARM, id, 1000, atk );
	end;
	
	--troops_list.push( inf, atk );
	
	--Wait( 40 );
	Trace( "id = %g; pt = " .. atk, id );
end;

function Descent()
local cnt_id_s = 8000;
local cnt_id = cnt_id_s;
local tbl = { 0, 3, 4, 7 };
local wave_num;
local atk;
local obj1 = 0;
	Wait( 8 + Random( 2 ) );
	for wave = 1, 4 do
		--atk = gettown();
		if ( wave >= 3 ) then
			wave_num = 2;
		else
			wave_num = 1;
		end;
		for i = 1, wave_num do
			for j = 1, 4 do
				cnt_id = cnt_id + 1;
				LandReinforcementFromMap( 1, "1", tbl[j], cnt_id );
				Cmd( ACT_UNLOAD, cnt_id, 400, "p" .. tbl[j] );
				--QCmd( ACT_MOVE, cnt_id, 200, "exit" .. tbl[j] );
				--QCmd( ACT_DISAPPEAR, cnt_id );
				Wait( 3 );
				--pt = Random( 3 );
				--StartThread( Para_Task, cnt_id, atk );
			end;
		end;
		Wait( 30 + Random( 10 ) );
		
		StartThread( GAPCall, gap_id, 2 );
		
		Wait( 50 + Random( 10 ) );
	end;
	CompleteObjective( 1 );
	Wait( 3 );
	atk = gettown();
	for i = cnt_id_s + 1, cnt_id do
		if ( IsSomeBodyAlive( 1, i ) == 1 ) then
			Sleep( 5 );
			StartThread( Para_Task, i, atk );
			obj1 = 1;
		end;
	end;
	if ( obj1 == 1 ) then
		GiveObjective( 2 );
		StartCycled( Objective2 );
	else
		Win( 0 );
	end;
end;

function GAPCall( id, dest )
	for i = 1, __difficulty + 1 do
		gap_id = gap_id + 1;
		LandReinforcementFromMap( 1, "gap", pt_gap[Random( 3 )], gap_id );
		if ( dest == 1 ) then
			Cmd( ACT_SWARM, gap_id, 500, towns_1[Random( 3 )] );
		else
			Cmd( ACT_SWARM, gap_id, 500, "as2" );
		end;
		Wait( 5 + Random( 5 ) );
	end;
end;

function Airstrike()
local cnt_id = 9000;
local tbl = {{ 0, 3, 4, 7 }, {4, 0, 7, 3}, {7, 4, 0, 3}};
local wave_num = {2, 2, 2, 2};
local atk, r;
local planesx2 = { 1, 2, 2, 3 };

	Wait( 30 + Random( 5 ) );
	for wave = 1, 4 do
		for i = 1, wave_num[wave] do
			r = Random( 3 );
			for j = 1, planesx2[ wave ] do
				pt = tbl[r][j];
				cnt_id = cnt_id + 1;
				LandReinforcementFromMap( 1, "0", pt, cnt_id );
				Cmd( ACT_MOVE, cnt_id, 600, "bomba" .. pt );
				QCmd( ACT_MOVE, cnt_id, 100, "exit" .. pt );
				QCmd( ACT_DISAPPEAR, cnt_id );
				Wait( 3 + RandomInt( 3 ) );
				--pt = Random( 3 );
				--StartThread( Para_Task, cnt_id, atk );
			end;
		end;
		Wait( 30 + Random( 5 ) );

		StartThread( GAPCall, gap_id, 1 );
		
		Wait( 40 + Random( 5 ) );
	end;
	CompleteObjective( 0 );
	Wait( 3 );
	GiveObjective( 1 );
	StartThread( Descent );
end;

---------------------------------- 
Objectives = { Objective0 };
Objectives_Count = 3;

StartAllObjectives( Objectives, 1 );

Wait( 1 );
GiveObjective( 0 );
--StartCycled( Objective0 );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( Airstrike );
--StartThread( Attack_Manager );
--StartThread( AssaultManager );
--StartCycled( SecretObj );
--StartThread( FlagManager, 1 );