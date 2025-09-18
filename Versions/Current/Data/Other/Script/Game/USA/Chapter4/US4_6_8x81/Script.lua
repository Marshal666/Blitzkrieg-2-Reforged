-----------------------------------------------Artillery fire1

function ArtAction160()
	local x = 7300;
	local y = 4700;
	Wait( 35 );
		while x > 6290 do 
			Cmd( ACT_SUPPRESS, 160, 5, x, y );
			Wait( 35 );
			x = x - 200;
			y = y + 100;
		end;
	Trace("Kannon1Complete");
	Cmd( ACT_STOP, 160 );
end;

-----------------------------------------------Artillery fire2

function ArtAction161()
	local x = 6090;
	local y = 4050;
		Wait( 35 );
	while x > 5090 do 
		Cmd( ACT_SUPPRESS, 161, 5, x, y );
		Wait( 35 );
		x = x - 200;
		y = y + 100;
	end;
	Trace("Kannon2Complete");
	Cmd( ACT_STOP, 161 );
end;

-----------------------------------------------Artillery fire3

function ArtAction162()
	local x = 1209;
	local y = 5252;
		Wait( 35 );
		while y < 7100 do 
		Cmd( ACT_SUPPRESS, 162, 100, x, y );
		Wait( 25 );
		x = x - 10;
		y = y + 200;
	end;
	Trace("Kannon3Complete");
	Cmd( ACT_STOP, 162 );
end;

-----------------------------------------------Artillery fire4

function ArtAction163()
	local x = 1209;
	local y = 5252;
		Wait( 35 );
	while y < 7100 do 
		Cmd( ACT_SUPPRESS, 163, 100, x, y );
		Wait( 35 );
		x = x - 10;
		y = y + 200;
	end;
	Trace("Kannon4Complete");
	Cmd( ACT_STOP, 163 );
end;

-----------------------------------------------Enemies Attack

function Attack_GO()
	Wait ( 5 );
	QCmd(ACT_SWARM, 104, 0, 3882, 7250);
	Wait ( 5 );
end;

function Attack_1_GO()
	Wait ( 5 );
	QCmd(ACT_SWARM, 102, 0, 3882, 7250);
	Wait ( 5 );
end;

function Attack_2_GO()
	Wait( 15 );
	while 1 do
		Wait (1);
		QCmd ( ACT_SWARM, 111, 0, 961, 6280 );
		Wait (15);
	end;
end;

function Attack_3_GO()
	Wait( 1 );
	while 1 do
	Wait (1);
		QCmd ( ACT_SWARM, 110, 50, 3721, 6729 );
	Wait (5);
	end
end;

function Attack_4_GO()
	Wait (2);
	while 1 do
	Wait (1);
		QCmd(ACT_SWARM, 500, 0, 7505, 7427);
	Wait (5);
	end
end;

function Attack_5_GO()
	Wait (2);
	while 1 do
	Wait (1);
		QCmd(ACT_SWARM, 510, 0, 3721, 6729);
	Wait (5);
	end
end;

function Attack_6_GO()
	Wait (2);
	while 1 do
	Wait (1);
		QCmd(ACT_SWARM, 511, 0, 830, 5977);
	Wait (5);
	end
end;
------------------------------------------------------Attack_Wawe2
function Wawe2()
	while 1 do
	Wait (1);
        if ( GetNUnitsInScriptGroup( 102 ) <= 0 ) and ( GetNUnitsInScriptGroup( 104 ) <= 0 ) then
            Wait(5);
			StartThread( Attack_2_GO );
			StartThread( Attack_3_GO );
			Trace("Second_Wawe");
			return 1;
		end	
		Wait( 2 );
	end;
end;

------------------------------------------------------Attack_Wawe3
function Wawe3()
	while 1 do
		Wait ( 1 );
        if ( GetNUnitsInScriptGroup ( 110 ) <= 1 ) and ( GetNUnitsInScriptGroup( 111 ) <= 1 ) then
            Wait (2);
			StartThread ( Attack_4_GO );
			StartThread ( Attack_5_GO );
			StartThread ( Attack_6_GO );
			Trace ("Third_Wawe");
			return 1;
		end	
		Wait( 2 );
	end;
end;

------------------------------------------------------Defeat1
function LooseCheck()
	local missionend = 0
	while ( missionend == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "HQ", 0 ) >= 1 ) and ( GetNUnitsInArea( 0, "HQ", 0 ) <= 0 ) then
			missionend = 1;
			Wait( 3 );
			Trace( "mission failed EnemyInCity=%g", GetNUnitsInArea( 1, "HQ", 0 ));
			Win( 1 );
			return 1;
		end;
	end;
end;

------------------------------------------------------Defeat2
function LooseCheck2()
	local missionend = 0
	while ( missionend == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "Store", 0 ) >= 1 ) and ( GetNUnitsInArea( 0, "Store", 0 ) <= 0 ) then
			missionend = 1;
			Wait( 3 );
			Trace( "mission failed EnemyInCity=%g", GetNUnitsInArea( 1, "Store", 0 ));
			Win( 1 );
			return 1;
		end;
	end;
end;
-----------------------------------------------------Defeat3
function LooseCheck3()
	local missionend = 0
	while ( missionend == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "Store2", 0 ) >= 1 ) and ( GetNUnitsInArea( 0, "Store2", 0 ) <= 0 ) then
			missionend = 1;
			Wait( 3 );
			Trace( "mission failed EnemyInCity=%g", GetNUnitsInArea( 1, "Store2", 0 ));
			Win( 1 );
			return 1;
		end;
	end;
end;

-----------------------------------------------------Defend

function CompleteObjective0()
	while 1 do
        if ( GetNUnitsInParty ( 1 ) <= 13 ) then
            Wait(3);
			CompleteObjective( 0 );
			Trace("Win!");
			Win( 0 );
			return 1;
		end	
		Wait( 6 );
	end;
end;

------------------------------------------------------Main
GiveObjective ( 0 );
StartThread( ArtAction160 );
StartThread( ArtAction161 );
StartThread( ArtAction162 );
StartThread( ArtAction163 );
StartThread( Attack_GO );
StartThread( Attack_1_GO );
StartThread( Wawe2 );
StartThread( Wawe3 );
StartThread( CompleteObjective0 );
StartThread( LooseCheck );
StartThread( LooseCheck2 );
StartThread( LooseCheck3 );
