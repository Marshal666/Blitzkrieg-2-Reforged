----------------------------------------------------America advanced

-----------------------------------------------Artillery fire1

function ArtAction160()
	local x = 3400;
	local y = 1000;
	Wait( 20 );
		while x > 2050 do 
			Cmd( ACT_SUPPRESS, 160, 5, x, y );
			Wait( 35 );
			x = x - 100;
		end;
	Trace("Kannon1Complete");
	Cmd( ACT_STOP, 160 );
end;

-----------------------------------------------Artillery fire2

function ArtAction161()
	local x = 3400;
	local y = 1200;
		Wait( 20 );
	while x > 2050 do 
		Cmd( ACT_SUPPRESS, 161, 5, x, y );
		Wait( 35 );
		x = x - 100;
	end;
	Trace("Kannon2Complete");
	Cmd( ACT_STOP, 161 );
end;

-----------------------------------------------Artillery fire3

function ArtAction162()
	local x = 3400;
	local y = 1500;
		Wait( 35 );
	while x > 2050 do 
		Cmd( ACT_SUPPRESS, 162, 5, x, y );
		Wait( 25 );
		x = x - 100;
	end;
	Trace("Kannon3Complete");
	Cmd( ACT_STOP, 162 );
end;

-----------------------------------------------Artillery fire4

function ArtAction163()
	local x = 3400;
	local y = 1700;
		Wait( 40 );
	while x > 2050 do 
		Cmd( ACT_SUPPRESS, 163, 5, x, y );
		Wait( 35 );
		x = x - 100;
	end;
	Trace("Kannon4Complete");
	Cmd( ACT_STOP, 163 );
end;

-----------------------------------------------Artillery fire14

function ArtAction170()
	local x = 3400;
	local y = 1000;
	Wait( 45 );
		while x > 2050 do 
			Cmd( ACT_SUPPRESS, 170, 5, x, y );
			Wait( 35 );
			x = x - 100;
		end;
	Trace("Kannon1Complete");
	Cmd( ACT_STOP, 160 );
end;

-----------------------------------------------Artillery fire24

function ArtAction171()
	local x = 3400;
	local y = 1200;
		Wait( 20 );
	while x > 2050 do 
		Cmd( ACT_SUPPRESS, 171, 5, x, y );
		Wait( 35 );
		x = x - 100;
	end;
	Trace("Kannon2Complete");
	Cmd( ACT_STOP, 161 );
end;

-----------------------------------------------Artillery fire34

function ArtAction172()
	local x = 3400;
	local y = 1500;
		Wait( 25 );
	while x > 2050 do 
		Cmd( ACT_SUPPRESS, 172, 5, x, y );
		Wait( 25 );
		x = x - 100;
	end;
	Trace("Kannon3Complete");
	Cmd( ACT_STOP, 162 );
end;

-----------------------------------------------Artillery fire44

function ArtAction173()
	local x = 3400;
	local y = 1700;
		Wait( 30 );
	while x > 2050 do 
		Cmd( ACT_SUPPRESS, 173, 5, x, y );
		Wait( 35 );
		x = x - 100;
	end;
	Trace("Kannon4Complete");
	Cmd( ACT_STOP, 163 );
end;

------------------------------------------------------FrontAttack
function FrontAttack()
	Wait (2);
	while 1 do
		if (GetNUnitsInArea ( 0, "Crossroad", 0 )>=2 ) or (GetNUnitsInArea ( 0, "Pagoda", 0 )>=1 )then
			Wait (5);
			Trace ("FrontAttack");
			GiveObjective ( 1 );
			Cmd( ACT_SWARM, 200, 10, 4215, 1000 );
			Wait (5);
			return 1
		end;
		Wait(2);
	end;
end;
------------------------------------------------------FrontAttack2
function FrontAttack2()
	Wait (2);
	local k=5;
	while ( k<=0 ) do
		if (GetNUnitsInArea ( 0, "Crossroad", 0 )>=2 ) or (GetNUnitsInArea ( 0, "Pagoda", 0 )>=1 ) then
			Wait (5);
			Trace ("FrontAttack2");
			LandReinforcementFromMap (1, 0, 0, 201);
			Cmd( ACT_SWARM, 201, 10, 4215, 1000 );
			Wait (5);
		end;
		k=k-1;
		Wait(2);
		if (k<=0) then 
		CompleteObjective (1);
		end;
	end;
end;
------------------------------------------------------FlangStrike
function FlangStrike()
	while 1 do
		if (GetNUnitsInArea ( 0, "Crossroad", 0 )>=2 ) then
			Wait (5);
			Cmd( ACT_SWARM, 100, 10, 2181, 2801 );
			Wait (5)
			Cmd( ACT_SWARM, 100, 10, 4215, 1000 );
			Trace ("FlangStrike");
			return 1;
		end;
		Wait (2)
	end;
end;
------------------------------------------------------Defeat1
function FailedObjective0()
	while 1 do
        if ( GetNUnitsInParty( 0 ) <= 0 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
            Wait(10);
			Trace("Defeat");
			Win( 1 );
			return 1;
		end	
		Wait( 6 );
	end;
end;
------------------------------------------------------Defeat
function LooseCheck()
	local missionend = 0
	while ( missionend == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "Base", 0 ) >= 2 ) and ( GetNUnitsInArea( 0, "Base", 0 ) <= 0 ) then
			missionend = 1;
			Trace( "EnemyInBase=%g", GetNUnitsInArea( 1, "Base", 0 ));
			Wait( 3 );
			Trace( "mission failed EnemyInBase=%g", GetNUnitsInArea( 1, "Base", 0 ));
			Win( 1 );
			return 1;
		end;
	end;	
end;
------------------------------------------------------Wictory1
function Victory1()
	while 1 do
        if ( GetNUnitsInParty( 1 ) <= 0 ) and ( GetReinforcementCallsLeft( 1 ) == 0 )then
            Wait(5);
			Trace("Victory");
			Win( 0 );
			return 1;
		end	
		Wait( 6 );
	end;
end;
------------------------------------------------------CompleteObjective0
function CompleteObjective0()
	while 1 do
        if ( GetNUnitsInArea( 0, "Petrol Pump Complex", 0 ) >= 1 ) and ( GetNUnitsInArea( 1, "Petrol Pump Complex", 0 ) <= 0 ) then
            Wait(5);
			Trace("Victory");
			Win( 0 );
			return 1;
		end	
		Wait( 6 );
	end;
end;
--------------------------------------------------------Main
Wait(5);
GiveObjective ( 0 );
StartThread ( ArtAction160 );
StartThread ( ArtAction161 );
StartThread ( ArtAction162 );
StartThread ( ArtAction163 );
StartThread ( ArtAction170 );
StartThread ( ArtAction171 );
StartThread ( ArtAction172 );
StartThread ( ArtAction173 );
StartThread ( FlangStrike );
StartThread ( FrontAttack );
StartThread ( FrontAttack2 );
StartThread ( LooseCheck );
StartThread ( FailedObjective0 );
StartThread ( Victory1 );
StartThread ( CompleteObjective0 );