
-----------------------------------------------Artillery fire1

function ArtAction160()
	local x = 3400;
	local y = 1000;
	Wait( 20 );
		while x > 2000 do 
			Cmd( ACT_SUPPRESS, 160, 5, x, y );
			Wait( 35 );
			x = x - 200;
				if (GetNUnitsInScriptGroup ( 160, 0 )==1) then
				QCmd (ACT_STOP, 160);
				return 1
				end;
		end;
	Trace("Kannon1Complete");
	Cmd( ACT_STOP, 160 );
end;

-----------------------------------------------Artillery fire2

function ArtAction161()
	local x = 3400;
	local y = 1200;
		Wait( 20 );
	while x > 2000 do 
		Cmd( ACT_SUPPRESS, 161, 5, x, y );
		Wait( 35 );
		x = x - 200;
			if (GetNUnitsInScriptGroup ( 161, 0 )==1) then
			QCmd (ACT_STOP, 161);
			return 1
			end;
	end;
	Trace("Kannon2Complete");
	Cmd( ACT_STOP, 161 );
end;

-----------------------------------------------Artillery fire3

function ArtAction162()
	local x = 3400;
	local y = 1500;
		Wait( 35 );
	while x > 2000 do 
		Cmd( ACT_SUPPRESS, 162, 5, x, y );
		Wait( 25 );
		x = x - 200;
			if (GetNUnitsInScriptGroup ( 162, 0 )==1) then
			QCmd (ACT_STOP, 162);
			return 1
			end;
	end;
	Trace("Kannon3Complete");
	Cmd( ACT_STOP, 162 );
end;

-----------------------------------------------Artillery fire4

function ArtAction163()
	local x = 3400;
	local y = 1700;
		Wait( 35 );
	while x > 2000 do 
		Cmd( ACT_SUPPRESS, 163, 5, x, y );
		Wait( 35 );
		x = x - 200;
			if (GetNUnitsInScriptGroup ( 163, 0 )==1) then
			QCmd (ACT_STOP, 163);
			return 1
			end;
	end;
	Trace("Kannon4Complete");
	Cmd( ACT_STOP, 163 );
end;
-----------------------------------------------Patrol1
function Patrol1()
	Wait( 5 );
	while 1 do
			QCmd(ACT_SWARM, 200, 0, 3736, 2544);
			Wait( 2 );
			QCmd(ACT_SWARM, 200, 0, 4020, 4000);
			Wait( 2 );
			QCmd(ACT_SWARM, 200, 0, 3525, 2285);
			Wait( 2 );
			QCmd(ACT_SWARM, 200, 0, 4020, 1500);
			Wait( 5 );
		if ( GetNUnitsInScriptGroup( 200 ) <= 0 ) then
			Trace("Patrol1_Defeated")
			Wait(2)
			return 1;
		end;
	end;
end;

-----------------------------------------------Patrol2
function Patrol2()
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
			Trace("Patrol2_Defeated")
			Wait(2)
			return 1;
		end;
	end;
end;

-----------------------------------------------Bomber Strike
function Bomb_Strike()
	while 1 do
		if ( GetNUnitsInScriptGroup( 102 ) <= 0 ) and ( GetNUnitsInScriptGroup( 104 ) <= 0 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 1001 );
			Wait (3);
			QCmd (ACT_MOVE, 1001, 0, 2487, 3023 );
			Trace("Bombimg_srike");
			return 1;
		end;
	Wait (4);
	end;
end;
-----------------------------------------------Enemies Attack

function Attack_GO()
	while 1 do
		Wait ( 45 );
		QCmd(ACT_SWARM, 104, 0, 1024, 1018);
		Wait ( 15 );
	end;
end;

function Attack_1_GO()
	while 1 do
		Wait ( 45 );
		QCmd(ACT_SWARM, 102, 0, 1024, 1018);
		Wait ( 15 );
	end;
end;

function Attack_2_GO()
	Wait( 25 );
		QCmd(ACT_SWARM, 111, 0, 4400, 1068);
		Wait( 35)
	while 1 do	
		QCmd(ACT_SWARM, 111, 0, 1024, 1018);
		Wait (15);
	end;
end;

function Attack_3_GO()
	Wait( 5 );
	while 1 do
		QCmd(ACT_SWARM, 110, 0, 1024, 1018);
	Wait (5);
	end
end;

function Attack_4_GO()
	while 1 do
		QCmd(ACT_SWARM, 112, 0, 1024, 1018);
	Wait (5);
	end
end;
------------------------------------------------------Attack_Wawe2
function Wawe2()
	while 1 do
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
        if ( GetNUnitsInScriptGroup( 110 ) <= 1 ) and ( GetNUnitsInScriptGroup( 111 ) <= 1 )then
            Wait(2);
			StartThread( Attack_4_GO );
			Trace("Third_Wawe");
			return 1;
		end	
		Wait( 2 );
	end;
end;

------------------------------------------------------Defeat
function LooseCheck()
	local missionend = 0
	while ( missionend == 0 ) do
		Wait( 3 );
		if ( GetNUnitsInArea( 1, "City", 0 ) >= 1 ) and ( GetNUnitsInArea( 0, "City", 0 ) <= 0 ) then
			missionend = 1;
			Wait( 3 );
			Trace( "mission failed EnemyInCity=%g", GetNUnitsInArea( 1, "City", 0 ));
			Win( 1 );
			return 1;
		end;
	end;
end;
-----------------------------------------------------Tobruk

function CompleteObjective0()
	while 1 do
        if ( GetNUnitsInParty( 1 ) <= 8 ) then
            Wait(5);
			CompleteObjective( 0 );
			Trace("Win!");
			Win( 0 );
			return 1;
		end	
		Wait( 6 );
	end;
end;
------------------------------------------------------KV
function KV()
	while 1 do
		if ( GetNUnitsInArea( 0, "KV", 0 ) >= 1 ) then
		ChangePlayerForScriptGroup (1001, 0);
		return 1;
		end;
		Wait (3);	
	end;
end;
------------------------------------------------------Main
GiveObjective( 0 );
StartThread(Patrol1);
StartThread(Patrol2);
StartThread( ArtAction160 );
StartThread( ArtAction161 );
StartThread( ArtAction162 );
StartThread( ArtAction163 );
StartThread( Attack_GO );
StartThread( Attack_1_GO );
StartThread( Bomb_Strike );
StartThread( Wawe2 );
StartThread( Wawe3 );
StartThread( CompleteObjective0 );
StartThread( LooseCheck );
--StartThread( KV );