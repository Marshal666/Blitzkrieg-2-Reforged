-----------------------------------------------CompleteAllies
function Connect()
	while 1 do
		Wait ( 3 );
		if (GetNUnitsInScriptGroup (300, 3) <= 0) and (GetNUnitsInScriptGroup (301, 3) <= 0) then
			Wait (2);
			CompleteObjective ( 2 );
			Wait ( 2 );
			Trace ("Unified");
			Wait ( 2 );
			GiveObjective ( 0 );
			Wait ( 1 );
			GiveObjective ( 1 );
			Wait ( 2 );
			return 1;
		end;
		Wait ( 2 );
	end;
end;
-----------------------------------------------TankAssault
function TankAssault()
	while 1 do
		if ( GetNUnitsInScriptGroup ( 201 ) <= 0 ) then
			Wait ( 2 );
			LandReinforcementFromMap (1, "Tanks", 0, 1001 );
			Wait ( 1 );
			Trace ( "Tank Assault" );
			Wait ( 3 );
			QCmd (ACT_SWARM, 1001, 200, 842, 5005 );
			Wait ( 3 );
			QCmd (ACT_SWARM, 1001, 200, 810, 825 );
			Trace ( "RussianTanksAssault" );
			Wait ( 90 )
--			return 1;
		end;
	Wait (4);
	end;
end;

-----------------------------------------------Patrol
function Patrol()
	Wait( 5 );
	while 1 do
			QCmd(ACT_SWARM, 201, 0, 1675, 5024);
			Wait( 2 );
			QCmd(ACT_SWARM, 201, 0, 2666, 5294);
			Wait( 2 );
			QCmd(ACT_SWARM, 201, 0, 3100, 3818);
			Wait( 3 );
			QCmd(ACT_SWARM, 201, 0, 1460, 4475);
			Wait( 3 );
			QCmd(ACT_SWARM, 201, 0, 1120, 3888);
			Wait( 3 );
		if ( GetNUnitsInScriptGroup( 201 ) <= 0 ) then
			Trace("Patrol_Defeated")
			Wait(2)
			return 1;
		end;
	end;
end;
-----------------------------------------------------Allies
function Allies()
	while 1 do
	Wait ( 2 );
		if ( IsSomeUnitInArea ( 0, "Re", 0 ) == 1 ) then
		Wait ( 2 );
		ChangePlayerForScriptGroup ( 300, 0 );
		Wait ( 2 );
		Trace ("United!");
		Wait ( 2 );
		return 1;
		end;
	Wait ( 2 );
	end;
end;
-----------------------------------------------------Allies1
function Allies1()
	while 1 do
	Wait ( 2 );
		if ( IsSomeUnitInArea ( 0, "Re1", 0 ) == 1 ) then
		Wait ( 2 );
		ChangePlayerForScriptGroup ( 301, 0 );
		Wait ( 2 );
		Trace ("United!");
		Wait ( 2 );
		return 1;
		end;
	Wait ( 2 );
	end;
end;
-----------------------------------------------------Victory
function Victory()
	local mission = 0
	while ( mission == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "V1", 0 ) <=0 ) and ( GetNUnitsInArea( 0, "V1", 0 ) > 0 ) then
			missionend = 1;
			Wait ( 1 );
			CompleteObjective ( 0 );
			Wait ( 3 );
			Trace( "Victory-EnemyV1=%g", GetNUnitsInArea( 2, "V1", 0 ));
			Wait ( 2 );
			StartThread ( VictoryComplete );
			return 1;
		end;
	end;
end;

------------------------------------------------------VictoryComplete
function VictoryComplete()
	local mission = 0
	while ( mission == 0 ) do
		Wait( 20 );
		if ( GetNUnitsInArea( 1, "V2", 0 ) <=0 ) and ( GetNUnitsInArea( 0, "V2", 0 ) > 0 ) then
			missionend = 1;
			Wait ( 5 );
			CompleteObjective ( 1 );
			Wait ( 3 );
			Trace( "Victory-EnemyV2=%g", GetNUnitsInArea( 2, "V2", 0 ));
			Win( 0 );
			return 1;
		end;
	end;
end;
------------------------------------------------------Defeat
function LooseCheck()
	local missionend = 0
	while ( missionend == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInParty ( 0 ) <= 1 ) then
			missionend = 1;
			Wait( 3 );
			Trace( "mission failed" );
			Win( 1 );
			return 1;
		end;
	end;
end;
------------------------------------------------------Main
GiveObjective ( 2 );
StartThread ( Connect );
StartThread ( Patrol );
StartThread ( TankAssault );
StartThread ( Allies );
StartThread ( Allies1 );
StartThread ( Victory );
StartThread ( LooseCheck );