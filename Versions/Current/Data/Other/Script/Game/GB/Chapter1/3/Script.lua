missionend = 0;
JeepID = 300;
JeepPassangerID = 302;
ParaID = 301;
JeepPlaced = 0;
ParaPlaced = 0;
Jeep_reinfID = '3'; --1119;
JeepPassanger_reinID = '4';--1009;
Para_reinfID = '5';--1086;
AI_reinfID = '1'; --1085;
AI_ID = 100;
AI_ADD1 = 190;
AI_ADD2 = 191;
AI_ADD3 = 192;
Disp = 100;
AI_patrolID = 101;
PatrolArea = "Patrol";
areaname = 1;
J = 0;
P = 0;
 
function RandomS()
	Wait(5);
	while GetNUnitsInCircle(0, 347, 6764, 900) == 3 do
		Wait(1);
	end;
	Trace("%g", GetNUnitsInCircle(0, 347, 6764, 900));
	J = Random( 3 ); -- JeepArea 1-3

	while GetNUnitsInCircle(0, 347, 6764, 1200) == 3 do
		Wait(1);
	end;
	Trace("%g", GetNUnitsInCircle(0, 347, 6764, 1200));
	P = Random( 4 ) + 3; -- ParaArea 4-7
	StartThread( ArtAction );
end;

function Patrol( id )
	local rnd = Random(2);
	Trace("rnd=%g",rnd);
	while GetNUnitsInScriptGroup( id ) > 0 do
		if rnd == 1 then
			local k = 7;
			Wait( Random( 15 ) + 5 );
			while k >= 1  do
				Cmd( ACT_SWARM, id, 20, GetScriptAreaParams( PatrolArea .. k ) );
				WaitForGroupAtArea( id, PatrolArea .. k );
				Wait( 1 );
				if k == 5 or k == 3 or k == 8 then
					Wait(Random( 3 ) + 3);
				end;
				k = k - 1;
			end;
			k = 7;
			Wait( 3 );
		else		
			local k = 1;
			Wait( Random( 15 ) + 5 );
			while k <= 8  do
				Cmd( ACT_SWARM, id, 20, GetScriptAreaParams( PatrolArea .. k ) );
				WaitForGroupAtArea( id, PatrolArea .. k );
				Wait( 1 );
				if k == 5 or k == 3 or k == 8 then
					Wait(Random( 3 ) + 3);
				end;
				k = k + 1;
			end;
			k = 1;
			Wait( 3 );
		end;
	end;
end;

function AreaChange()
	while GetNUnitsInScriptGroup(101) > 0 do
		if ( GetIGlobalVar( "temp.objective.0", 0 ) == 2 ) then
			PatrolArea = "APatrol";
			Trace("AreaChanged to APatrol");
			return 1;
		end;
		Wait(5);
	end;
	PatrolArea = "APatrol";
	Trace("AreaChanged to APatrol");
end;

function ArtAction()
	art_pos = {{4912, 950},{4693, 1946},{5090, 2618}};
	art_pos.n = 3;
	local b = Random(3);
	local c = Random(2);
	Cmd(ACT_AMBUSH,180);
	Cmd(ACT_AMBUSH,181);
	Wait(5);
	if b == 2 then
		Cmd(ACT_MOVE,180,20,art_pos[1][1],art_pos[1][2]);
		Trace("Art 180 going to x=%g, y=%g",art_pos[1][1],art_pos[1][2]);
	elseif b == 3 then
		Cmd(ACT_MOVE,180,20,art_pos[2][1],art_pos[2][2]);
		Trace("Art id 180 going to x=%g, y=%g",art_pos[2][1],art_pos[2][2]);
	end;
		QCmd(ACT_ROTATE,180,Disp,GetScriptAreaParams("Attack4"));
		QCmd(ACT_AMBUSH,180);
	if c == 2 then
		Cmd(ACT_MOVE,181,20,art_pos[3][1],art_pos[3][2]);
		Trace("Art id 181 going to x=%g, y=%g",art_pos[3][1],art_pos[3][2]);
	end;
		QCmd(ACT_ROTATE,181,Disp,GetScriptAreaParams("Attack4"));
		QCmd(ACT_AMBUSH,181);
	while 1 do
		local coord = {};
		local units = GetObjectListArray( 182 );
		local art = GetObjectListArray( 181 );
		coord[1], coord[2] = ObjectGetCoord ( units[ Random( units.n ) ] );
		coord[3], coord[4] = ObjectGetCoord ( art[ Random( art.n ) ] );
		if GetNUnitsInCircle ( 0,  coord[1], coord[2], 1000 ) > 0 or GetNUnitsInCircle ( 0,  coord[3], coord[4], 1000 ) then
			ChangeFormation ( 182, 1 )
			Cmd(ACT_MOVE,182,Disp,coord[3], coord[4]);
			return 1;
		end;
		Wait(Random(3));
	end;
end;

function EnemyAction( reinfid, id )
	while ( GetIGlobalVar( "temp.objective.0", 0 ) ~= 2 ) do
		Wait(5);
	end;
	LandReinforcementFromMap( 1, reinfid, 0, id );
	Wait( 2 );
	
	StartThread( Unload, id );
	
	if id == 111 then
		StartThread( EnemyActionAdd, AI_ADD1 );
--		StartThread( EnemyActionAdd, AI_ADD2 );
--		StartThread( EnemyActionAdd, AI_ADD3 );
	end;
	
	local k = 1;
	while k <= 4 do
		areaname = k;
		Cmd( ACT_SWARM, id, 20, GetScriptAreaParams( "Attack" .. k ) );
		WaitForGroupAtArea( id, "Attack" .. k );
		k = k + 1;
	end;
	areaname = 5;
	if id == 111 or id == 112 then 
		while GetNUnitsInScriptGroup(id) > 0 do
			Cmd( ACT_SWARM, id, 400, GetScriptAreaParams( "Attack4" ) );
			Wait(Random(20));
			if ( GetIGlobalVar( "temp.objective.1", 0 ) == 2 ) then
				break;
			end;
		end;
	end;
	while ( GetIGlobalVar( "temp.objective.1", 0 ) ~= 2 ) do
		Wait(1);
	end;
	Cmd( ACT_SWARM, id, 600, GetScriptAreaParams( "Attack" .. areaname ) );
end;

function EnemyActionAdd( id )
	while GetIGlobalVar( "temp.objective.1", 0 ) ~= 1 do
		Wait(2);
	end;
	Wait(10);
	while GetNUnitsInScriptGroup( AI_ID ) > 0 or GetNUnitsInScriptGroup( 111 ) > 0 or GetNUnitsInScriptGroup( 112 ) > 0 
									or GetNUnitsInScriptGroup( 181 ) > 0 or GetNUnitsInScriptGroup( 180 ) > 0 do
		Wait(2);
	end;
	if GetIGlobalVar( "temp.objective.1", 0 ) == 2 then
		Wait(Random(1));
	else
		Wait(Random(10) + 10);
	end;
	if id == AI_ADD1 then
		LandReinforcementFromMap( 1, '2', 1, id ); --1128
		Wait(1);
		StartThread( Unload, id );
	else
		LandReinforcementFromMap( 1, '3', 1, id ); --1130
	end;
	
	Wait(Random(2));
	Cmd( ACT_SWARM, id, Disp, GetScriptAreaParams( "Attack3" ) );
	WaitForGroupAtArea( id, "Attack3" );
	Cmd( ACT_SWARM, id, Disp, GetScriptAreaParams( "Attack4" ) );
	WaitForGroupAtArea( id, "Attack4" );
	Cmd( ACT_SWARM, id, 600, GetScriptAreaParams( "Attack5" ) );
	WaitForGroupAtArea( id, "Attack5" );
	StartThread( Patrol, id );
end;

function EnemyAttackFinal( id )
	local m = 0;
	while GetIGlobalVar( "temp.objective.1", 0 ) ~= 2 do
		Wait(2);
	end;
	if id < 175 then
		if id == 173 then
			LandReinforcementFromMap( 1, '0', 0, id ); --1140
		else
			if id == 174 then
				LandReinforcementFromMap( 1, '2', 0, id ); --1128
				Wait(1);
				StartThread( Unload, id );
			else
				LandReinforcementFromMap( 1, '3', 0, id ); --1130
			end;
			Wait(Random(2));
			Cmd( ACT_SWARM, id, 600, GetScriptAreaParams( "Attack5" ) );
			Wait(20);
		end;
		while GetNUnitsInScriptGroup(id) > 0 do
			Cmd( ACT_SWARM, id, 1000, GetScriptAreaParams( "Attack5" ) );
			Wait(Random(20));
		end;
	else	
		if id == 177 then
			LandReinforcementFromMap( 1, '0', 1, id ); --1140
		else
			if id == 178 then
				LandReinforcementFromMap( 1, '2', 1, id ); --1128
				Wait(1);
				StartThread( Unload, id );
			else
				LandReinforcementFromMap( 1, '3', 1, id ); --1130
			end;
		end;
		Wait(Random(2));
		Cmd( ACT_SWARM, id, Disp, GetScriptAreaParams( "Attack3" ) );
		WaitForGroupAtArea( id, "Attack3" );
		Cmd( ACT_SWARM, id, Disp, GetScriptAreaParams( "Attack4" ) );
		WaitForGroupAtArea( id, "Attack4" );
		Cmd( ACT_SWARM, id, 600, GetScriptAreaParams( "Attack5" ) );
		Wait(20);
		while GetNUnitsInScriptGroup(id) > 0 and m < 2 do
			Cmd( ACT_SWARM, id, 1000, GetScriptAreaParams( "Attack5" ) );
			Wait(Random(20));
			m = m + 1;
		end;
			StartThread( Patrol, id );
	end;
end;

function Unload( id )
	while 1 do
		local unload_inf = {};
		local units = GetObjectListArray( id );
		local attackers = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
			unload_inf[1], unload_inf[2] = ObjectGetCoord ( attackers[ Random( attackers.n ) ] );
		if GetNUnitsInCircle ( 0,  unload_inf[1], unload_inf[2], 1184 ) > 0 or GetNUnitsInCircle ( 2,  unload_inf[1], unload_inf[2], 1000 ) > 0 then
			Trace("ours units near attackers = %g",GetNUnitsInCircle ( 0,  unload_inf[1], unload_inf[2], 1184 ));
			for i = 1, attackers.n do
				unload_inf[1], unload_inf[2] = ObjectGetCoord ( attackers[ i ] );
				UnitCmd( ACT_UNLOAD, attackers[ i ], 0, unload_inf[1], unload_inf[2] );
			end;
			Wait(4);
			ChangeFormation( id, 0 );
			Wait(1);
			Cmd( ACT_SWARM, id, Disp, GetScriptAreaParams( "Attack" .. areaname ) );
			Trace("ScriptID=%g unloaded and swarming to Attack%g", id, areaname);
			return 1;
		end;
		Wait(1);
	end;
end;

function Finding_Jeep()
	local going_pos_jeep = { };
	local ours_units_near_jeep = { };
	local a = 0;
	while ( GetIGlobalVar( "temp.objective.0", 0 ) ~= 2 ) do
		Wait(a);
		a = 5
		if JeepPlaced == 1 and GetNUnitsInArea( 0, "JeepArea"..J, 0 ) > 0 then
			Cmd(ACT_LOAD, JeepPassangerID, JeepID );
			ours_units_near_jeep = GetUnitListInAreaArray( 0, "JeepArea"..J );
			Trace("our units near jeep=%g", ours_units_near_jeep.n);
			Wait( Random(2) + 2 );
			going_pos_jeep[1], going_pos_jeep[2] = ObjectGetCoord ( ours_units_near_jeep[ Random( ours_units_near_jeep.n ) ] ); 
			Trace("near jeep x=%g; y=%g", going_pos_jeep[1], going_pos_jeep[2]);
			Cmd(ACT_MOVE, JeepID, Disp, going_pos_jeep[1], going_pos_jeep[2]);
			Wait(1);
			ChangePlayerForScriptGroup( JeepPassangerID, 0 );
			ChangePlayerForScriptGroup( JeepID, 0 );
			Trace("Jeep is found");
			return 1;
		end;
	end;
end;

function Finding_Para()
	local going_pos_para = { };
	local ours_units_near_para = { };
	local a = 0;
	
	while ( GetIGlobalVar( "temp.objective.1", 0 ) ~= 2 ) do
		Wait(a);
		a = 5;
		local k = 0;
		if ParaPlaced == 1 and GetNUnitsInArea( 0, "ParaArea"..P, 0 ) > 0 then 
			ours_units_near_para = GetUnitListInAreaArray( 0, "ParaArea"..P );
			for i=1, ours_units_near_para.n do
				if NumUnitsAliveInArray(GetArray(GetPassangers( ours_units_near_para[i], 0 ))) > 0 then
					k = i;
				end;
			end
			Trace("our units=%g", ours_units_near_para.n);
			ChangeFormation(ParaID,1);
			if k == 0 then
				going_pos_para[1], going_pos_para[2] = ObjectGetCoord( ours_units_near_para[ Random( ours_units_near_para.n ) ] ); 
			else
				going_pos_para[1], going_pos_para[2] = ObjectGetCoord( ours_units_near_para[ k ] ); 
			end;
			Trace("near para x=%g; y=%g", going_pos_para[1], going_pos_para[2]);
			Cmd(ACT_SWARM, ParaID, Disp, going_pos_para[1], going_pos_para[2]);
			Wait(1);
			ChangePlayerForScriptGroup( ParaID, 0);
			Trace("Para is found");
			return 1;
		end;
	end;
end;

function Enemy_Dead_J_P( id )
	local DeadID = 128;
	local coord = { };
	local coord_to = { };
	local unit = { };
	local spy = { };
	local enemy = { };
	local J_P = J;
	local xxx = Random(50);
	if id ~= 300 then
		DeadID = 129;
		J_P = P;
	end;
	unit = GetArray( GetObjectList ( id ) );
	Trace("Enemy placed for ID=%g",id);
	coord[1], coord[2] = ObjectGetCoord( unit[ 1 ] );
	LandReinforcementFromMap( 3, '0', J_P, DeadID ); --1128
	Wait(1);
	if xxx > 30 and xxx < 45 then
		LandReinforcementFromMap( 3, '0', J_P, DeadID ); --1128
	end;
	if xxx > 45 then
		LandReinforcementFromMap( 3, '0', J_P, DeadID ); --1128
		Wait(1);
		LandReinforcementFromMap( 3, '0', J_P, DeadID ); --1128
	end;
	enemy = GetArray( GetObjectList ( DeadID ) );
	
	for i = 1, enemy.n do
		coord_to[1] = coord[1] + RandomInt( 2*600 ) - 600;
		coord_to[2] = coord[2] + RandomInt( 2*600 ) - 600;
		while len( coord_to[1] - coord[1], coord_to[2] - coord[2] ) < 300 do
			coord_to[1] = coord[1] + RandomInt( 2*600 ) - 600;
			coord_to[2] = coord[2] + RandomInt( 2*600 ) - 600;
		end;
		Trace("Dead going to x=%g, y=%g",coord_to[1], coord_to[2]);
		Wait(1);
		UnitCmd( ACT_SWARM, enemy[i], 0, coord_to[1], coord_to[2] );
		UnitQCmd( ACT_ROTATE, 0, coord[1], coord[2]);
	end;
	Wait(5);
	for i = 1, enemy.n do
		DamageObject( enemy[i], 100 );
	end;
	if id == 300 then
		spy = GetArray( GetObjectList ( JeepPassangerID ) );
		DamageObject( unit[1], Random(15) + 15 );
		DamageObject( spy[1], Random(7) + 7 );
	else
		DamageObject( unit[1], Random(5) + 5 );
	end;
end;

function EliteEnemy()
	local k = P; 
	local rnd = Random(2);
	local m = 0;
	if rnd == 1 then
		k = k + 1;
	else
		k = k - 1;
	end;	
	if k < 4 then
		k = 7;
	end;
	if k > 7 then
		k = 4;
	end;
	LandReinforcementFromMap( 3, '1', k, 199 ); --1138
	Wait( 1 );
	LandReinforcementFromMap( 3, '2', k, 199 ); --1139
	Wait( 1 );
	ChangePlayerForScriptGroup( 199, 1);
	Wait( 1 );
	ChangeFormation( 199, 2 );
	while ( GetIGlobalVar( "temp.objective.1", 0 ) ~= 2 ) do
		Wait( Random( 10 ) );
	end;
	ChangeFormation( 199, 1 );
	Cmd( ACT_SWARM, 199, 600, GetScriptAreaParams( "Attack5" ) );
	Wait(10);
	ChangeFormation( 199, 0 );
	while GetNUnitsInScriptGroup( 199 ) > 0 or m < 3 do
		Cmd( ACT_SWARM, 199, 1000, GetScriptAreaParams( "Attack5" ) );
		Wait(Random(20));
		m = m + 1;
	end;
end;

function Objective0()
	if JeepPlaced == 0 then
		LandReinforcementFromMap(3, Jeep_reinfID, J, JeepID);
		Wait(1);
		StartThread( Enemy_Dead_J_P, JeepID );
		Cmd( ACT_SWARM, JeepID, Disp, GetScriptAreaParams( "JeepArea"..J ) );
		Wait(1);
		LandReinforcementFromMap(3, JeepPassanger_reinID, J, JeepPassangerID);
		Wait(1);
		Cmd( ACT_SWARM, JeepPassangerID, Disp, GetScriptAreaParams( "JeepArea"..J ) );
		Trace("J=%g P=%g",J,P);
		Wait(2);
		JeepPlaced = 1;
		Trace("JeepPlaced");
	end;
	
	if ( GetNUnitsInScriptGroup( 300, 3 ) == 0 ) and ( GetNUnitsInScriptGroup( 300, 0 ) > 0 ) and ( GetIGlobalVar( "temp.objective.0", 0 ) ~= 2 ) and missionend == 0 then
		Wait( 3 );
		CompleteObjective( 0 );
		if ( GetIGlobalVar( "temp.objective.1", 0 ) == 0 ) then
			GiveObjective( 1 );
		end;
	end;
	
	if JeepPlaced == 1 and ( GetNUnitsInScriptGroup( 302 ) == 0 ) and ( GetNUnitsInScriptGroup( 300 ) == 0 ) then -- scouts has killed
		FailObjective( 0 );
		Trace("Objective0 failed");
		return 1;
	end;
end;

function Objective1()
	if ParaPlaced == 0 then
		LandReinforcementFromMap(3, Para_reinfID, P, ParaID);
		StartThread( EliteEnemy );
		Wait(2);
		StartThread( Enemy_Dead_J_P, ParaID );
		ChangeFormation(ParaID,2);
		ParaPlaced = 1;
		Trace("ParaPlaced");
	end;
	
	if ( GetNUnitsInScriptGroup( 301, 3 ) == 0 ) and ( GetNUnitsInScriptGroup( 301, 0 ) > 0 ) and ( GetIGlobalVar( "temp.objective.1", 0 ) ~= 2 ) and missionend == 0 then
		Wait( 3 );
		CompleteObjective( 1 );
		if ( GetIGlobalVar( "temp.objective.2", 0 ) == 0 ) then
			GiveObjective( 2 );
		end;
	end;
	
	if ( GetNUnitsInScriptGroup( 301 ) == 0 ) and ParaPlaced == 1 then -- para has destroyed
		FailObjective( 1 );
		Trace("Objective1 failed");
		return 1;
	end;
end;

function Objective2()
	local going_pos_survive = { };
	local ours_units_near_survive = { };
	local k = 1;
	if ( GetIGlobalVar( "temp.objective.2", 0 ) == 1 ) then
		if ( GetNScriptUnitsInArea( JeepID, "Survive", 0 ) > 0 or GetNScriptUnitsInArea( JeepPassangerID, "Survive", 0 ) > 0 ) and  GetNScriptUnitsInArea( ParaID, "Survive", 0 ) > 0 then
			ours_units_near_survive = GetUnitListInAreaArray( 0, "Survive" );
			for i=1, ours_units_near_survive.n do
				if NumUnitsAliveInArray(GetArray(GetPassangers( ours_units_near_survive[i], 0 ))) > 0 then
					k = i;
				end;
			end
			Trace("our units near survive=%g", ours_units_near_survive.n);
			LandReinforcementFromMap(3, '6', 8, 10); --1156
			Wait(1);
			LandReinforcementFromMap(3, '7', 8, 11); --1157
			Wait(1);
			if k == 0 then
				going_pos_survive[1], going_pos_survive[2] = ObjectGetCoord( ours_units_near_survive[ Random( ours_units_near_survive.n ) ] );
			else
				going_pos_survive[1], going_pos_survive[2] = ObjectGetCoord( ours_units_near_survive[ k ] );
			end;
			Trace("near survive x=%g; y=%g", going_pos_survive[1], going_pos_survive[2]);
			
			ChangeFormation(11,0);
			Cmd(ACT_SWARM, 10, Disp, going_pos_survive[1], going_pos_survive[2]);
			Wait(1);
			Cmd(ACT_MOVE, 11, Disp, going_pos_survive[1], going_pos_survive[2]);
			Wait(1);
			ChangePlayerForScriptGroup( 10, 0);
			Wait(1);
			ChangePlayerForScriptGroup( 11, 0);
			Wait(5);
			CompleteObjective( 2 );
			return 1;
		end;
			
		if ( GetNUnitsInScriptGroup( 301 ) == 0 ) and ParaPlaced == 1 then -- para has destroyed
			FailObjective( 2 );
			Trace("para has destroyed -- Objective2 failed");
			return 1;
		end;
			
		if JeepPlaced == 1 and ( GetNUnitsInScriptGroup( 302 ) == 0 ) and ( GetNUnitsInScriptGroup( 300 ) == 0 ) then -- scouts has killed
			FailObjective( 2 );
			Trace("scouts has destroyed -- Objective2 failed");
			return 1;
		end;
	end;
end;

function WinCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( GetIGlobalVar( "temp.objective.2", 0 ) == 2 ) then
			missionend = 1;
			Wait( 3 );
			Win( 0 ); -- player wins
		end;
	end;
end;

function LooseCheck()
	while ( missionend == 0 ) do
		Wait( 2 );
		if ( ( IsSomePlayerUnit( 0 ) <= 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) ) then
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

function Oficer()
	local hum = GetObjectListArray( 98 );
	local k = 1;
	while NumUnitsAliveInArray(GetArray(GetPassangers( hum[1], 0 ))) > 0 do
		Wait( 2 );
		if k > 10 then
			return 1;
		end;
		k = k + 1;
	end;
	Cmd(ACT_MOVE,99,0,464,6170); 
	QCmd(ACT_SPYGLASS,99,0,1500,4883); 
	Wait( 10 ); 
	Cmd(ACT_MOVE,99,0,460,6150); 
	QCmd(ACT_SPYGLASS,99,0,1500,4850); 
end;

function Final()
local k = 170;
	while k < 178 do
		StartThread( EnemyAttackFinal, k );
		k = k + 1;
	end;
end;

Objectives = { Objective0, Objective1, Objective2 };
Objectives_Count = 3;
SetIGlobalVar("temp.general_reinforcement", 0);
SetIGlobalVar("temp.nogeneral_sript", 1);
StartThread( Oficer );
GiveObjective( 0 ); -- find jeep
RandomS();
StartThread( Patrol, AI_patrolID );
StartAllObjectives( Objectives, Objectives_Count );
StartThread( Final );
StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( EnemyAction, AI_reinfID, AI_ID );
StartThread( EnemyAction, '0', 111 ); --1140
StartThread( EnemyAction, '0', 112 ); --1140
StartThread( AreaChange );
StartThread( Finding_Jeep );
StartThread( Finding_Para );
