Objective0 = 0
Objective1 = 0
function Patrol ()
	while 1 do
		Wait( 5 );
		if ( GetNScriptUnitsInArea(111, "A1", 0) > 0 ) then
		Wait( 2 );
		Cmd(3, 111, 50, GetScriptAreaParams("A2"));
		QCmd(3, 111, 50, GetScriptAreaParams("A3"));
		QCmd(3, 111, 50, GetScriptAreaParams("A4"));
		QCmd(3, 111, 50, GetScriptAreaParams("A5"));
		QCmd(3, 111, 50, GetScriptAreaParams("A6"));
		QCmd(3, 111, 50, GetScriptAreaParams("A7"));
		QCmd(3, 111, 50, GetScriptAreaParams("A8"));
		end;
		Wait( 1 );
		if ( GetNScriptUnitsInArea(111, "A8", 0) > 0 ) then
		Wait( 2 );
		Cmd(3, 111, 50, GetScriptAreaParams("A7"));
		QCmd(3, 111, 50, GetScriptAreaParams("A6"));
		QCmd(3, 111, 50, GetScriptAreaParams("A5"));
		QCmd(3, 111, 50, GetScriptAreaParams("A4"));
		QCmd(3, 111, 50, GetScriptAreaParams("A3"));
		QCmd(3, 111, 50, GetScriptAreaParams("A2"));
		QCmd(3, 111, 50, GetScriptAreaParams("A1"));
		end;
	end;
end;
function Alarm ()
	while 1 do
		Wait( 4 );
		if ( GetNUnitsInArea(0, "Alarm", 0) > 0 and Objective0 == 0) then
		Wait( 2 );
		LandReinforcementFromMap( 1, "Ship", 0, 300 );
		LandReinforcementFromMap( 1, "Bomb", 0, 301 );
		Wait(3);
		Cmd(3, 300, 50, GetScriptAreaParams("Alarm"));
		Cmd(3, 301, 50, GetScriptAreaParams("Alarm"));
		break;
		end;
	end;
end;

---------------------------------------Тревога
function Attack ()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 100, 1 ) < 9 ) then
			Wait( 2 );
			Cmd(3, 110, 50, GetScriptAreaParams("Mayak"));
			break;	
		end;
	end;
end;
---------------------------------------Objective0
function CompleteObjective0 ()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInArea(1, "Mayak", 0) < 1 ) then
			Wait( 2 );
			CompleteObjective( 0 );
			Wait ( 2 );
            Objective0 = 1
			break;	
		end;
	end;
end;

----------------------------------------Objective1
function CompleteObjective1 ()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 200, 1 ) < 1 ) then
			Wait( 2 );
			CompleteObjective( 1 );
			Wait ( 2);
			Objective1 = 1;
			break;	
		end;
	end;
end;
-------------------------------------------Условия поражения 
function Caput()
    while 1 do
        Wait ( 1 );
        if ( (GetNUnitsInScriptGroup( 1, 0 ) < 1 or GetNUnitsInScriptGroup( 2, 0 ) < 1) and  GetReinforcementCallsLeft( 0 ) == 0 ) then
		Wait(5);
		Win(1);
		return 1;
		end;
	end;
end;
-------------------------------------------Условия победы
function Victory ()
    while 1 do
        Wait ( 1 );
        if (Objective0 == 1 and Objective1 == 1) then
        Wait (5);
        Win (0);
        return 1;
        end;
    end;
end;
-----------------------------------------------
SetIGlobalVar( "temp.nogeneral_sript", 1 ); --end AI
GiveObjective( 0 );
Wait (3);
GiveObjective( 1 );
StartThread( Patrol );
StartThread( Alarm );
StartThread( Caput );
StartThread( Victory );
StartThread( CompleteObjective0 );
StartThread( CompleteObjective1 );
StartThread( Attack );