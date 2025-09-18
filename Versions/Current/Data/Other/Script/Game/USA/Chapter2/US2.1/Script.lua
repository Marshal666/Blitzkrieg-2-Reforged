Objective0 = 0
Objective1 = 0
T1 = 0
T2 = 0
-------------------------------------------Caput 
function Caput()
    while 1 do
        Wait ( 1 );
        if ( GetNUnitsInParty ( 0 ) < 1) and ( GetReinforcementCallsLeft ( 0 ) == 0 ) or T1 == 1 or T2 == 1  then
		Wait ( 1 );
		Win ( 1 );
		return 1;
		end;
		Wait ( 2 );
	end;
end;
-------------------------------------------Victory
function Victory ()
    while 1 do
        Wait ( 1 );
        if Objective0 == 1 and Objective1 == 1 then
        Wait (2);
        Win (0);
        return 1;
        end;
    end;
end;
--------------------------------------------First Column
function Trucks01 ()
Wait (10);
    while 1 do
       Wait (1);
       LandReinforcementFromMap( 1, "Trucks1", 0, 1000 );
	   Wait ( 1 );
	   Cmd ( 0, 1000, 50, 6593, 2847 );
	   Wait ( 10 );
	   QCmd ( 0, 1000, 50, 6332, 3522 );
	   Wait ( 10 );
	   QCmd ( 0, 1000, 50, 6697, 5240 );
	   Wait ( 10 );
	   QCmd ( 0, 1000, 50, 6358, 6577 );
	   Wait ( 15 );
	   QCmd ( 0, 1000, 50, 5227, 6218 );
	   Wait ( 15 );
	   QCmd ( 0, 1000, 50, 2681, 6701 );
	   Wait ( 15 );
	   QCmd ( 0, 1000, 50, 93, 7926  );
	   QCmd  ( ACT_DISAPPEAR, 1000 );
	   break;
	end;
end;
------------------------Checking of the ariving of the first column
function Check1 ()
    while 1 do
		Wait( 1 );
		if ( GetNScriptUnitsInArea ( 1000, "Finish", 0 ) >= 1 ) and ( GetNUnitsInScriptGroup ( 1000 ) >= 2 ) then
			Wait( 1 );
			T1 = 1;
			break;
		end;	
	end;
end;
------------------------Checking of the destruction of the first column - part 1
function Check3 ()
    while 1 do
        Wait (1);  
        if ( GetNScriptUnitsInArea ( 1000, "Start1", 0 ) > 0 ) then
         StartThread( Destroing1 );
        break;
        end;
    end;
end;
------------------------Checking of the destruction of the first column - part 2 
function Destroing1 ()
    while 1 do
        Wait (1);
        if ( GetNUnitsInScriptGroup ( 1000 ) <= 0 ) then
           Wait (1);
           CompleteObjective( 0 );
		   Wait ( 1 );
           Objective0 = 1;
           Wait ( 1 );
           GiveObjective( 1 );
           break;
        end;
    end;
end; 
---------------------------------------------Second column
function Trucks02 ()
    while 1 do
        Wait ( 1 );
        if Objective0 == 1 then
          Wait ( 25 );
          LandReinforcementFromMap( 1, "Trucks2", 1, 2000 );
          Wait ( 5 );
          Cmd  ( 0, 2000, 50, 6346, 6572 );
          Wait ( 10 );
          QCmd ( 0, 2000, 50, 5247, 6244 );
          Wait ( 10 );
          QCmd ( 0, 2000, 50, 3642, 6545 );
          Wait ( 10 );
          QCmd ( 0, 2000, 50, 2413, 6723 );
          Wait ( 15 );
          QCmd ( 0, 2000, 50, 93, 7926 );
	      QCmd  ( ACT_DISAPPEAR, 2000 );
        break;
        end;
    end;
end;
------------------------------Checking of the ariving of the second column
function Check2 ()
    while 1 do
		Wait( 1 );
		if ( GetNScriptUnitsInArea ( 2000, "Finish", 0 ) >= 1 ) and ( GetNUnitsInScriptGroup ( 2000 ) >= 2 ) then
			Wait( 2 );
			T2 = 1;
			break;
		end;	
	end;
end;
-----------------------------Checking of the destruction of the second column - part 1
function Check4 ()
    while 1 do
        Wait (1);  
        if ( GetNScriptUnitsInArea ( 2000, "Start2", 0 ) > 0 ) then
         StartThread( Destroing2 );
         break;
        end;
    end;
end;
------------------------------Checking of the destruction of the second column - part 2
function Destroing2 ()
    while 1 do
        Wait (1);
        if ( GetNUnitsInScriptGroup( 2000 ) <= 1 ) then
           Wait (1)
           CompleteObjective ( 1 );
		   Wait ( 1 );
           Objective1 = 1
           break;
        end;
    end;
end; 
------------------------------AA Artillery
function AA ()
    while 1 do
       Wait ( 1 );
        if ( GetNUnitsInScriptGroup ( 1000 ) <= 1 ) then
         Wait ( 3 );
         LandReinforcementFromMap( 1, "AA_0", 2, 50 );
         Wait ( 2 );
         LandReinforcementFromMap( 1, "AA_1", 2, 60 );
		 Wait ( 2 )
         LandReinforcementFromMap( 1, "AA_2", 2, 70 );
         Wait ( 2 );
         Cmd (0, 50, 3550, 6854 );
         Wait ( 10 );
         Cmd (3, 50, 2359, 6898 );
         Wait ( 10 );
         Cmd (0, 60, 3550, 6854);
         Wait ( 10 );
         QCmd (3,60, 4096, 6521);
         Wait ( 10 );
         Cmd (3, 70, 3723, 6888); 
        return
        end;
    end;
end;

--------------------------------------------STARTING FUNCTIONS
GiveObjective( 0 );
StartThread( Caput );
StartThread( Victory );
StartThread( Trucks01 );
StartThread( Check1 );
StartThread( Check3 );
StartThread( Trucks02 );
StartThread( Check2 );
StartThread( Check4 );
StartThread( AA );