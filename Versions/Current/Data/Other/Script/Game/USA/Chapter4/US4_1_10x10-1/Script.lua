-------------------------------------------------------Landing_Operation

--------------------------------------------------------SeaPatrol
function SeaPatrol()
	Wait( 5 );
	while 1 do
		Wait (2);
		QCmd(ACT_SWARM, 200, 15, 3372, 3512);
		Wait( 15 );
		QCmd(ACT_SWARM, 200, 15, 1618, 3360);
		Wait( 15 );
		QCmd(ACT_SWARM, 200, 15, 2572, 4250);
		Wait( 15 );
	end;
end;

--------------------------------------------------------SeaPatrol2
function SeaPatrol2()
	Wait( 5 );
	while 1 do
		Wait (2);
		QCmd(ACT_SWARM, 201, 15, 5620, 1000);
		Wait( 15 );
		QCmd(ACT_SWARM, 201, 15, 7123, 1347);
		Wait( 15 );
		QCmd(ACT_SWARM, 201, 15, 5111, 2314);
		Wait( 15 );
		QCmd(ACT_SWARM, 201, 15, 4420, 3683);
		Wait( 15 );
	end;
end;
------------------------------------------------------Victory
function Victory()
	local mission = 0
	while ( mission == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "HQ", 0 ) <=0 ) and ( GetNUnitsInArea( 2, "HQ", 0 ) > 0 ) then
			missionend = 1;
			Wait ( 1 );
			CompleteObjective ( 0 );
			Wait ( 3 );
			Trace( "Victory-EnemyHQ=%g", GetNUnitsInArea( 2, "HQ", 0 ));
			Win( 0 );
			return 1;
		end;
	end;
end;

-----------------------------------------------------Coastdefeat

function Lost0()
	while 1 do
	Wait (1);
        if ( GetNUnitsInParty ( 2 ) <= 2 ) and (IsReinforcementAvailable (2) ==0 ) and (IsReinforcementAvailable (0) == 0 ) then
				Wait(15);
				Trace("Defeat");
				Win( 1 );
			return 1;
		end	
		Wait( 6 );
	end;
end;
-------------------------------------------------------ArmorS
function Armors()
local k=0
	while k<=3 do
	Wait (1);
		if ( IsSomeBodyAlive ( 1, 100 ) == 0 ) then
		Wait (10);
			LandReinforcementFromMap ( 1, "Tank", 0, 100 );
			Wait (3);
			k=k+1;
		end;
	end;
end;
-------------------------------------------------------Landingstorm
function Landing()
local k=0
	while k<=6 do
	Wait (1);
		if ( GetNUnitsInParty ( 1 ) <= 1 ) then
			LandReinforcementFromMap ( 2, "Ship", 0, 900 );
			Wait (3);
			QCmd (ACT_MOVE, 900, 2, 3715, 2018);
			Wait (35);
			QCmd (ACT_MOVE, 900, 2, 1227, 673);
			Wait (35);
			k=k+1;
		end;
	end;
end;
-------------------------------------------------------Landingstorm1
function Landing1()
local k=0
	while k<=6 do
	Wait (1);
		if ( GetNUnitsInParty ( 2 ) <= 2 ) then
		Wait (10);
			LandReinforcementFromMap ( 2, "Ship", 0, 901 );
			Wait (3);
			QCmd (ACT_MOVE, 901, 2, 1227, 673);
			Wait (25);
			ChangePlayerForScriptGroup (901,3);
			Wait (1);
			RemoveScriptGroup (901);
			k=k+1;
		end;
	end;
end;


-------------------------------------------------------Main
GiveObjective (0);
StartThread ( SeaPatrol );
StartThread ( Victory );
StartThread ( Lost0 );
--StartThread ( Landing );
--StartThread ( Landing1 );
StartThread ( SeaPatrol2 );