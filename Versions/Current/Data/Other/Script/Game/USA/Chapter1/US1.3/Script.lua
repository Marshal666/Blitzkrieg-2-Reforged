Objective0 = 0
Objective1 = 0
B1 = 0
B2 = 0
-------------------------------------------Условия поражения 
function Caput()
    while 1 do
        Wait ( 1 );
        if ( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
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
        if B1 == 1 and B2 == 1 then
        Wait (5);
        Win (0);
        return 1;
        end;
    end;
end;
---------------------------------------Тревога 1
function Warning1 ()
while 1 do
		Wait( 1 );
		if ( GetNUnitsInArea ( 0, "Fight1", 0 ) > 0 ) then
			Wait( 2 );
			LandReinforcementFromMap( 1, "Squad1", 0, 1000 );
			Wait ( 1 );
			Cmd( 3, 1000, 500, 6341, 4594 );
			break;
		end;	
	end;
end;
---------------------------------------Тревога 2
function Warning2 ()
while 1 do
        Wait ( 1 )
        if ( GetNUnitsInArea ( 0, "Fight2", 0 ) > 0 ) then
           Wait ( 2 );
           LandReinforcementFromMap( 1, "Squad1", 1, 1100 );
           Wait ( 1 );
           Cmd  ( 3, 1100, 500, 3236, 1531 );
           break;
        end;
    end;
end;
---------------------------------------Уничтожение зениток 1
function AA_Artillery1 ()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 100, 1 ) < 1 ) then
			Wait( 2 );
			CompleteObjective( 0 );
			Wait ( 2 );
            Objective0 = 1
			break;	
		end;
	end;
end;

----------------------------------------Уничтожение зениток 2
function AA_Artillery2 ()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 150, 1 ) < 1 ) then
			Wait( 2 );
			CompleteObjective( 1 );
			Wait ( 2);
			Objective1 = 1;
			break;	
		end;
	end;
end;
----------------------------------------Бомбардировщик 1
function Bomber1 ()
 while 1 do
      Wait ( 1 ); 
      if Objective0 == 1 and Objective1 == 1 then
        Wait ( 5 ); 
        LandReinforcementFromMap( 2, "Bomber1", 0 , 400 );
        Cmd (0, 400, 0, 1624, 4989 );
        Wait ( 20 );
        B1 = 1;
        end;
    end;
end;
----------------------------------------Бомбардировщик 2
function Bomber2 ()
 while 1 do
      Wait ( 1 ); 
      if Objective0 == 1 and Objective1 == 1  then
        Wait ( 5 );
        LandReinforcementFromMap( 2, "Bomber2", 1, 450 );
        Cmd (0, 450, 0, 2741, 6267 );
        Wait ( 20 );
        B2 = 1;
        end;
    end;
end;
------------------------------------------------Запускаем функции
GiveObjective( 0 );
GiveObjective( 1 );
StartThread( Caput );
StartThread( Victory );
StartThread( Warning1 );
StartThread( Warning2 );
StartThread( AA_Artillery1 );
StartThread( AA_Artillery2 );
StartThread( Bomber1 );
StartThread( Bomber2 );