Objective0 = 0;
Objective1 = 0;
Obj2 = 0
Obj3 = 0
T1 = 0 T2 = 0;
x=0
-------------------------------------------Caput
function Caput()
     while 1 do
        Wait ( 1 );
        if ( GetNUnitsInParty ( 0 ) < 1) and ( GetReinforcementCallsLeft ( 0 ) == 0 ) or T1 == 1 or T2 == 1  then
 		  Win ( 1 );
 		  return 1;
 		end;
    end;
end;
-------------------------------------------Victory 
function Victory ()
     while 1 do 
        Wait ( 1 );
         if Obj3 == 1 then
         Wait (2);
         Win (0);
         return 1;
         end;
     end;
end; 
--------------------------------------------First Column 
function Trucks01 () 
Wait (2);
     while 1 do
        Wait (1);
        LandReinforcementFromMap( 1, "Trucks", 0, 1000 );
 	   Wait ( 5 );
 	   Cmd ( 0, 1000, 50, 6582, 2846 );
 	   QCmd ( 0, 1000, 50, 6363, 3164 );
 	   QCmd ( 0, 1000, 50, 6674, 5065 );
 	   QCmd ( 0, 1000, 50, 6490, 6193 );
	   QCmd ( 0, 1000, 50, 6072, 6455 );
 	   QCmd ( 0, 1000, 50, 5305, 6225 );
 	   QCmd ( 0, 1000, 50, 2369, 6738  );
 	   QCmd ( 0, 1000, 50, 1192, 7341  );
 	   break;
 	end;
end; 
------------------------Checking of the ariving of the first column 
function Check1 () 
    while 1 do
 		Wait( 1 );
 		if ( GetNScriptUnitsInArea ( 1000, "Finish", 0 ) > 1 ) then
         T1=1       
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
        Wait (5);
        if ( GetNUnitsInScriptGroup ( 1000 ) < 3 )  and T1 <1 then
         Wait (3)
            CompleteObjective( 0 );
 		    Objective0 = 1;
            Wait ( 3 );
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
          Wait ( 10 );
           LandReinforcementFromMap( 1, "Trucks", 1, 2000 );
           Wait ( 5 );
 	       Cmd ( 0, 2000, 50, 5305, 6225 );
 	       QCmd ( 0, 2000, 50, 2369, 6738  );
 	       QCmd ( 0, 2000, 50, 1192, 7341  );
 	       break;
        end;
    end;
end; 
------------------------------Checking of the ariving of the second column 
function Check2 ()
 
    while 1 do
		Wait( 1 );
 		if ( GetNScriptUnitsInArea ( 2000, "Finish", 0 ) > 1 )  then
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
        if ( GetNUnitsInScriptGroup( 2000 ) < 2 ) and T2 <3 then 
         Wait (1)
         CompleteObjective ( 1 );
    	 Wait ( 1 );
         Objective1 = 1
         Wait (5)
         GiveObjective(2)
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
----------------------------Recon 1
function Recon1 ()
   while 1 do
       Wait (1)
       if ( GetNUnitsInScriptGroup( 1000 ) > 0 ) then
         LandReinforcementFromMap( 2, "R", 0, 777 );
 	     Cmd ( 0, 777, 100, 6466, 2921 );
 	     Wait (23);
 	     QCmd (0, 777, 100, 6370, 6583)
 	     Wait (26);
 	     QCmd (0, 777, 100, 3510, 6658)
 	     break;
 	    end;
    end;
end;


function Recon1_1 ()
   while 1 do
      Wait (3)
      if Objective0==1 then 
         Wait (3)
         Cmd (0, 777, 100, 6038, 254);
         QCmd (ACT_DISAPPEAR, 777);
         break;
        end
    end
end;

function Recon2 ()
    while 1 do
       Wait (1)
       if Objective0==1 then
          Wait (2)
          LandReinforcementFromMap( 2, "R", 0, 888 ); 
          Cmd  ( 0, 888, 100, 6346, 6572 );
          Wait (30)
          QCmd (0, 888, 100, 3510, 6658);
          break;
        end;
    end;
end;

function Recon3 ()
    while 1 do
       Wait (3)
       if Objective1==1 and (GetNUnitsInScriptGroup (889) < 1) and x < 2 and (GetNUnitsInScriptGroup (444) > 0) then
          Wait (5)
          LandReinforcementFromMap( 2, "R", 0, 889 ); 
          x=x+1
          Cmd  ( 0, 889, 100, 1696, 4465 );
          break;
        end;
    end;
end;

function Artillery () 
    while 1 do 
      Wait (3)
        if (GetNUnitsInScriptGroup (444, 1) == 0) then
          Wait (3) 
          CompleteObjective (2) 
          Obj2=1
          Wait (5) 
          GiveObjective (3)
          StartThread (Landing)
          StartThread (Landing2)
          StartThread (Landing22)
          StartThread (Landing222)
          break;
        end;
    end;
end;

function Landing ()
   while 1 do 
      Wait (2)
       if Obj2==1 then
         Wait (5)
         LandReinforcementFromMap (2, "Boat", 2, 707);
         Cmd (0, 707, 100, 2142, 2847);
         QCmd (0, 707, 100, 1046, 212);
         QCmd (ACT_DISAPPEAR, 707);
         Wait (20)
         LandReinforcementFromMap (2, "Boat", 2, 708);
         Cmd (0, 708, 100, 2142, 2847);
         QCmd (0, 708, 100, 1046, 212);
         QCmd (ACT_DISAPPEAR, 708);
         Wait (20)
         LandReinforcementFromMap (2, "Boat", 2, 709);
         Cmd (0, 709, 100, 2142, 2847);
         QCmd (0, 709, 100, 1046, 212);
         QCmd (ACT_DISAPPEAR, 709);
         break
        end;
    end;
end;
  
function Landing2 ()
    while 1 do
      Wait (1)
       if (GetNScriptUnitsInArea (707, "Land", 0) > 0) then
          Wait (3) 
          LandReinforcementFromMap (2, "Infantry", 1, 807);
          ChangePlayerForScriptGroup (807, 0);
          ChangeFormation (807, 3);
          break;
        end;
    end;
end;

function Landing22 ()
    while 1 do
      Wait (1)
       if (GetNScriptUnitsInArea (708, "Land", 0) > 0) then
          Wait (3) 
          LandReinforcementFromMap (2, "Infantry", 1, 808);
          ChangePlayerForScriptGroup (808, 0);
          ChangeFormation (808, 3);
          break;
        end;
    end;
end;

function Landing222 ()
    while 1 do
      Wait (1)
       if (GetNScriptUnitsInArea (709, "Land", 0) > 0) then
          Wait (3) 
          LandReinforcementFromMap (2, "Infantry", 1, 809);
          ChangePlayerForScriptGroup (809, 0);
          ChangeFormation (809, 3);
          break;
        end;
    end;
end;

function KeyPoint ()
    while 1 do 
      Wait (3)
        if (GetNUnitsInScriptGroup (345, 0) > 0) then
         Wait (3)
         CompleteObjective (3)
         Obj3 = 1
         break
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
--StartThread( AA );
StartThread (Recon1);
StartThread (Recon1_1);
StartThread (Recon2);
StartThread (Recon3);
StartThread (Artillery)
StartThread (KeyPoint);
