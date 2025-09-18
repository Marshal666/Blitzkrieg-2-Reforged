-------------------------------------------------------Landing_Operation

--------------------------------------------------------SeaPatrol
function SeaPatrol()
	Wait( 5 );
	while 1 do
		Wait (2);
		QCmd(ACT_SWARM, 150, 15, 2311, 3344);
		Wait( 15 );
		QCmd(ACT_SWARM, 150, 15, 1309, 2606);
		Wait( 15 );
		QCmd(ACT_SWARM, 150, 15, 1045, 4865);
		Wait( 15 );
	end;
end;
-------------------------------------------------------SeaAttack170
function SeaAttack170()
	Wait( 5 );
	while 1 do
		Wait (1);
		QCmd(ACT_SWARM, 170, 1, 2280, 3235);
		Wait( 15 );
		QCmd(ACT_SWARM, 170, 1, 1076, 4041);
		Wait( 15 );
		QCmd(ACT_SWARM, 170, 1, 1259, 2051);
		Wait( 15 );
	end;
end;
-------------------------------------------------------SeaAttack171
function SeaAttack171()
	Wait( 5 );
	while 1 do
		Wait (1);
		QCmd(ACT_SWARM, 171, 1, 1970, 3940);
		Wait( 15 );
		QCmd(ACT_SWARM, 171, 1, 765, 3962);
		Wait( 15 );
		QCmd(ACT_SWARM, 171, 1, 668, 2270);
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
		if ( GetNUnitsInParty ( 2 ) <= 2 ) then
			LandReinforcementFromMap ( 2, "Ship", 0, 900 );
			Wait (3);
			QCmd (ACT_MOVE, 900, 2, 3715, 2018);
			Wait (35);
			QCmd (ACT_MOVE, 900, 2, 1227, 673);
			Wait (35);
			ChangePlayerForScriptGroup (900,3);
			Wait (1);
			RemoveScriptGroup (900);
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
--------------------------------------------------------USMC
function USMC()
local m=0
	while m<=1 do
	Wait (1);
		if ( GetNScriptUnitsInArea( 900, "LZ2", 0 ) >= 1 ) then
		Wait (2);
			LandReinforcementFromMap ( 2, "Tank", 1, 800 );
			Trace ("TanksLanding");
			Wait (5);
			QCmd (ACT_SWARM, 800, 10, 4815, 5030);
			Wait (25);
			QCmd (ACT_SWARM, 800, 10, 5825, 6724);
			Wait (25);
			m=m+1;
		end;
		
	end;
end;
--------------------------------------------------------USMC2
function USMC2()
local d=0
	while d<=3 do
	Wait (1);
		if ( GetNScriptUnitsInArea( 901, "LZ1", 0 ) >= 1 ) then
		Wait (2);
			LandReinforcementFromMap ( 2, "Tank", 2, 801 );
			Trace ("TanksLanding2");
			Wait (3);
			QCmd (ACT_SWARM, 801, 10, 5825, 6724);
			Wait (25);
			d=d+1;
		end;
		
	end;
end;
-------------------------------------------------------Main
GiveObjective (0);
StartThread ( SeaPatrol );
StartThread ( SeaAttack170 );
StartThread ( SeaAttack171 );
StartThread ( Victory );
StartThread ( Lost0 );
StartThread ( Landing );
StartThread ( Landing1 );
StartThread ( USMC );
StartThread ( USMC2 );
StartThread ( Armors );