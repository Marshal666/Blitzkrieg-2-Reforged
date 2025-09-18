id = 1000;
missionend = 0;
F_MARCHING = 1;
F_OFFENSIVE = 3;
F_DEFENSIVE = 2;
escaped_num = 0;
spawned_num = 0;
path = { { "p00", "p01" }, { "p00", "p01" }, { "p10", "p11" }, { "p10", "p11" } };
path2 = { { "p00", "z01" }, { "p00", "z01" }, { "p10", "z11" }, { "p10", "z11" } };
currpoint = 0;
total_escaped = 0;
__difficulty = GetDifficultyLevel();

function IsGun( unit )
local type, id, class, price, maxhp, weight, towforce = GetUnitRPGStats( unit );
	if ( class == CLASS_LIGHT_AA_GUN ) or ( class == CLASS_HEAVY_AA_GUN ) or 
		( class == CLASS_ANTITANK_GUN ) or ( class == CLASS_FIELD_ARTILLERY ) then
		return 1;
	end;
	return 0;
end;

function Reinf( _id, rnf, pt, exitarea, prob )
local units, inf, mech, u, i;
local cnt = 0;
	LandReinforcementFromMap( 1, rnf, pt, _id );
	Wait( 1 );
	spawned_num = spawned_num + GetNUnitsInScriptGroup( _id );
	Cmd( ACT_MOVE, _id, 0, path[pt+1][1]  ); -- if _Disperion_ > 0 then no formation
	QCmd( ACT_MOVE, _id, 0, path[pt+1][2] );
	QCmd( ACT_MOVE, _id, 0, exitarea );
	Sleep( 5 );
	Cmd( ACT_SWARM, _id, 0, path[pt+1][1]  );
	QCmd( ACT_SWARM, _id, 0, path[pt+1][2] );
	QCmd( ACT_SWARM, _id, 0, exitarea );
	
	u = GetObjectListArray( _id );
	while ( IsSomeBodyAlive( 1, _id ) == 1 ) do
		Wait( 1 );
		for i = 1, u.n do
			x, y, r = GetScriptAreaParams( exitarea );
			if ( ( IsObjectInArea( u[i], x, y, r ) == 1 ) or 
				( ( IsGun( u[i] ) == 1 ) and ( IsObjectInArea( u[i], x, y, r + 150 ) == 1 ) ) ) then
				UnitCmd( ACT_DISAPPEAR, u[i] );
				escaped_num = escaped_num + 1;
				cnt = cnt + 1;
			end;
		end;
		--if ( cnt == u.n ) then
		--	Trace( "left _id = %g", _id );
		--	Trace( "u.n = %g", GetObjectListArray( _id ).n );
		--	break;
		--end;
	end;
end;

function Reinf_Manager()
local wave1 = { 3, 3, 3, 1};
local wave2 = { 2, 2, 3, 9};
local delays2 = { 10, 10, 10, 20 };
local delays1 = { 30, 30, 20, 0 };
local probs = { { 0, 0.4, 0.4, 0.6 }, { 0.1, 0.4, 0.5, 0.6 }, { 0.2, 0.5, 0.6, 0.7 } };
local probs_tanks = { { 0, 0, 0, 0.1 }, { 0, 0.1, 0.1, 0.2 }, { 0.1, 0.2, 0.3, 0.4 } };
local probs_heavytanks = { { 0, 0, 0, 0 }, { 0, 0, 0.1, 0.1 }, { 0, 0.1, 0.1, 0.1 } };
local wavedelays = { 60, 60, 70, 80 };
local p_ht, prob;
	for i = 0, 3 do
		currpoint = i;
		Wait( 5 );
		GiveObjective( i );
		Wait( 5 );
		escaped_num = 0;
		spawned_num = 0;
		for big = 1, wave1[i + 1] do
			for cnt = 1, wave2[i + 1] do
				id = id + 1;
				
				if ( RandomFloat() < probs[__difficulty + 1][i + 1] ) then
					rnf = "comb2"..Random( 3 );
				else
					rnf = "comb1"..Random( 3 );
				end;
				
				StartThread( Reinf, id, rnf, i, "exit"..i );
				
				Sleep( 40 + Random( 40 ) );

				id = id + 1;				
				-- tanks
				prob = RandomFloat();
				p_ht = probs_heavytanks[__difficulty + 1][i + 1];
				if ( prob < p_ht ) then
					rnf = "tank2"..Random( 2 );
					StartThread( Reinf, id, rnf, i, "exit"..i );
				elseif ( prob < ( p_ht + probs_tanks[__difficulty + 1][i + 1] ) ) then
					rnf = "tank1"..Random( 2 );
					StartThread( Reinf, id, rnf, i, "exit"..i );
				end;
				-- tanks
				
				local d = delays2[i + 1];
				Sleep( d * 16 + Random( d * 8 ) );
			end;
			Wait( delays1[i + 1] );
		end;
		Wait( wavedelays[i + 1] );
		Trace( "spawned = %g, escaped = %g", spawned_num, escaped_num );
		if ( escaped_num / spawned_num ) <= 0.5 then
			CompleteObjective( i );
		else
			FailObjective( i );
		end;
		total_escaped = total_escaped + escaped_num;
	end;
	if ( total_escaped == 0 ) then
		CompleteObjective( 4 );
	end;
end;

function AssaultManager()
local assid = 3000;
local reinfs = { "assault", "assault2"};
local reinf = reinfs[1];
local k = 1;
local tanks = {};
	if ( __difficulty == 2 ) then
		reinf = reinfs[2];
	end;
	while missionend == 0 do
		Wait( 90 );
		assid = assid + 1;
		if ( __difficulty == 1 ) then
			reinf = reinfs[k + 1];
			k = 1 - k;
		end;
		LandReinforcementFromMap( 1, reinf, currpoint, assid );
		ChangeFormation( assid, 3 ); -- switch to aggressive formation
		Wait( 1 );
		
		if ( Random( 2 ) == 1 ) then
			Cmd( ACT_SWARM, assid, 0, path2[currpoint+1][1]  ); -- if _Disperion_ > 0 then no formation
			QCmd( ACT_SWARM, assid, 0, path2[currpoint+1][2] );
			QCmd( ACT_SWARM, assid, 0, "attack2" );
			QCmd( ACT_SWARM, assid, 0, "attack1" );
		else
			Cmd( ACT_SWARM, assid, 0, path2[currpoint+1][1]  ); -- if _Disperion_ > 0 then no formation
			QCmd( ACT_SWARM, assid, 0, "attack1" );
		end;
		
		if ( __difficulty >= 1 ) then
			tanks = GetUnitsByParamScriptId( assid, PT_TYPE, TYPE_MECH );
			if ( Random( 2 ) == 1 ) then
				CmdArrayDisp( ACT_SWARM, tanks, 200, path2[currpoint+1][1]  ); -- if _Disperion_ > 0 then no formation
				QCmdArrayDisp( ACT_SWARM, tanks, 200, path2[currpoint+1][2] );
				QCmdArrayDisp( ACT_SWARM, tanks, 200, "attack2" );
				QCmdArrayDisp( ACT_SWARM, tanks, 200, "attack1" );
			else
				CmdArrayDisp( ACT_SWARM, tanks, 200, path2[currpoint+1][1]  ); -- if _Disperion_ > 0 then no formation
				QCmdArrayDisp( ACT_SWARM, tanks, 200, "attack1" );
			end;
		end;
		
		Wait( 90 );
	end;
end;

function ReconManager()
local reconid1 = 2001;
local reconid2 = 2002;
local secondpart = 0;
local obj = 0;
	Wait( 3 );
	while missionend == 0 do
		for i = reconid1, reconid2 do
			if ( secondpart == 0 ) and ( GetObjectiveState( 2 ) ~= 0 ) then
				Cmd( ACT_MOVE, i, 400, Random( 6000) + 1000, 0 );
				QCmd( ACT_DISAPPEAR, i );
				secondpart = 1;
				obj = 1;
			end;
			if ( IsSomeBodyAlive( 2, i ) == 0 ) then
				LandReinforcementFromMap( 2, "recon", 0, i );
				a = RandomInt( 2 );
				Cmd( ACT_PATROL, i, 400, "recon"..obj..a );
				QCmd( ACT_PATROL, i, 400, "recon"..obj..(1 - a) );
			end;
		Wait( 5 );
		end;
	end;
end;

--
StartThread( AssaultManager );
StartThread( ReconManager );
StartThread( Reinf_Manager );
StartThread( LooseCheck, 4 );
StartThread( WinCheck, 4 );