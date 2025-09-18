Obj0 = 0;
Obj1 = 0;
Obj2 = 0
Obj3 = 0
T1 = 0 
T2 = 0;
x=0;
s=0;
l=0;
LandingCompleted = 0;
-------------------------------------------Caput
function Caput()
     while 1 do
        Wait ( 1 );
        if (( GetNUnitsInPlayerUF ( 0 ) < 1) and ( GetReinforcementCallsLeft ( 0 ) == 0 ) and 
			((GetNUnitsInScriptGroup (1000) > 1) or (GetNUnitsInScriptGroup (2000) > 1) or (LandingCompleted == 1))) 
			or T1 == 1 or T2 == 1  then
			Win ( 1 );
			return 1;
 		end;
    end;
end;
-------------------------------------------Victory 
function Victory ()
     while 1 do 
        Wait ( 1 );
         if Obj2 == 1 then
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
 	   local delta = 0;
 	   if GetDifficultyLevel() == DLEVEL_VERY_EASY or GetDifficultyLevel() == DLEVEL_EASY then
		   delta = 15;
 	   end;
 	   Cmd ( 0, 1000, 50, 6582, 2846 );
 	   QCmd(ACT_STOP, 1000);
 	   QCmd(ACT_WAIT, 1000, delta);
 	   QCmd ( 0, 1000, 50, 6363, 3164 );
 	   QCmd ( 0, 1000, 50, 6674, 5065 );
 	   QCmd(ACT_STOP, 1000);
 	   QCmd(ACT_WAIT, 1000, delta);
 	   QCmd ( 0, 1000, 50, 6490, 6193 );
	   QCmd ( 0, 1000, 50, 6072, 6455 );
 	   QCmd(ACT_STOP, 1000);
 	   QCmd(ACT_WAIT, 1000, delta);
 	   QCmd ( 0, 1000, 50, 5305, 6225 );
 	   QCmd ( 0, 1000, 50, 2369, 6738  );
 	   QCmd(ACT_STOP, 1000);
 	   QCmd(ACT_WAIT, 1000, delta);
 	   QCmd ( 0, 1000, 50, 1334, 7230  );
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
         Wait (1)
         StartThread (Secret1);
         break;
        end;
    end; 
end; 
------------------------Checking of the destruction of the first column - part 2  
function Destroing1 () 
    while 1 do 
        Wait (5);
        if ( GetNUnitsInScriptGroup ( 1000 ) < 2 )  and T1 < 1 then
         Wait (3)
            CompleteObjective( 0 );
 		    Obj0 = 1;
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
        if Obj0 == 1 then 
          Wait ( 10 );
           LandReinforcementFromMap( 1, "Trucks", 1, 2000 );
           Wait ( 5 );
		   local delta = 0;
		   if GetDifficultyLevel() == DLEVEL_VERY_EASY or GetDifficultyLevel() == DLEVEL_EASY then
			   delta = 15;
		   end;
 	       Cmd ( 0, 2000, 50, 5305, 6225 );
		   QCmd(ACT_STOP, 2000);
		   QCmd(ACT_WAIT, 2000, delta);
 	       QCmd ( 0, 2000, 50, 2369, 6738  );
		   QCmd(ACT_STOP, 2000);
		   QCmd(ACT_WAIT, 2000, delta);
 	       QCmd ( 0, 2000, 50, 1334, 7230  );
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
         Wait (1)
         StartThread (Secret2);
         break;
        end;
    end;
end; 
------------------------------Checking of the destruction of the second column - part 2 
function Destroing2 () 
    while 1 do
        Wait (1);
        if ( GetNUnitsInScriptGroup( 2000 ) < 2 ) and T2 < 1 then 
         Wait (1)
         CompleteObjective ( 1 );
    	 Wait ( 1 );
         Obj1 = 1
         Wait (5)
         GiveObjective(2)
         Wait (1)
         StartThread (Landing)
         Wait (1)
         StartThread (Landing2)
         Wait (1)
         StartThread (Landing22)
         Wait (1)
         StartThread (Landing222)
         break;
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
 	     Wait (16);
 	     QCmd (0, 777, 100, 6370, 6583)
 	     Wait (33);
 	     QCmd (0, 777, 100, 3510, 6658)
 	     break;
 	    end;
    end;
end;


function Recon1_1 ()
   while 1 do
      Wait (3)
      if Obj0==1 then 
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
       if Obj0==1 then
          Wait (3)
          LandReinforcementFromMap( 2, "R", 0, 888 ); 
          Cmd  ( 0, 888, 100, 6346, 6572 );
          Wait (20)
          QCmd (0, 888, 100, 3510, 6658);
          break;
        end;
    end;
end;

function Recon3 ()
    while 1 do
       Wait (3)
       if Obj1==1 and (GetNUnitsInScriptGroup (889) < 1) and x < 1  then
          Wait (5)
          LandReinforcementFromMap( 2, "R", 0, 889 ); 
          x=x+1
          Cmd  ( 0, 889, 100, 1696, 4465 );
          break;
        end;
    end;
end;

function Recon33 ()
    while 1 do
     Wait (3)
        if (GetNUnitsInArea (0, "Check", 0) > 0) then
         Cmd (0, 889, 100, 6038, 254);
         QCmd (ACT_DISAPPEAR, 889);
         break;
        end;
    end;
end;


function Landing ()
   while 1 do 
      Wait (2)
       LandReinforcementFromMap (2, "Boat", 2, 707);
       Cmd (0, 707, 100, 2142, 2847);
       QCmd (0, 707, 100, 1046, 212);
       QCmd (ACT_DISAPPEAR, 707);
       Cmd (ACT_SUPPRESS, 788, 50, 1221, 1659);
       Cmd (ACT_SUPPRESS, 789, 50, 2476, 1402);
       Wait (15)
       LandReinforcementFromMap (2, "Boat", 2, 708);
       Cmd (0, 708, 100, 2142, 2847);
       QCmd (0, 708, 100, 1046, 212);
       QCmd (ACT_DISAPPEAR, 708);
       Wait (15)
       LandReinforcementFromMap (2, "Boat", 2, 709);
       Cmd (0, 709, 100, 2142, 2847);
       QCmd (0, 709, 100, 1046, 212);
       QCmd (ACT_DISAPPEAR, 709);
       Wait (1)
       SetIGlobalVar( "temp.general_reinforcement", 1 );
       break;
    end;
end;
  
function Landing2 ()
    while 1 do
      Wait (1)
       if (GetNScriptUnitsInArea (707, "Land", 0) > 0) then
          Wait (3) 
          LandReinforcementFromMap (2, "Infantry", 3, 807);
          ChangePlayerForScriptGroup (807, 0);
          ChangeFormation (807, 3);
          LandReinforcementFromMap (2, "Tanks", 1, 817);
          ChangePlayerForScriptGroup (817, 0);
          LandingCompleted = 1;
          break;
        end;
    end;
end;

function Landing22 ()
    while 1 do
      Wait (1)
       if (GetNScriptUnitsInArea (708, "Land", 0) > 0) then
          Wait (3) 
          LandReinforcementFromMap (2, "Infantry", 3, 808);
          ChangePlayerForScriptGroup (808, 0);
          ChangeFormation (808, 3);
          LandReinforcementFromMap (2, "Tanks", 1, 818);
          ChangePlayerForScriptGroup (818, 0);
          break;
        end;
    end;
end;

function Landing222 ()
    while 1 do
      Wait (1)
       if (GetNScriptUnitsInArea (709, "Land", 0) > 0) then
          Wait (3) 
          LandReinforcementFromMap (2, "Infantry", 3, 809);
          ChangePlayerForScriptGroup (809, 0);
          ChangeFormation (809, 3);
          LandReinforcementFromMap (2, "Tanks", 1, 819);
          ChangePlayerForScriptGroup (819, 0);
          l=1
          break;
        end;
    end;
end;

function KeyPoint ()
    while 1 do 
      Wait (3)
        if (GetNUnitsInScriptGroup (345, 0) > 0) and (GetNUnitsInArea (1, "Finish", 0) < 1) then
         Wait (3)
         CompleteObjective (2)
         Obj2 = 1
         break
        end;
    end;
end;

function At1 ()
    
  while 1 do 
    Wait (2)
       if (GetNUnitsInArea (0, "Attack", 0) > 0) then 
         Wait (1)
         LandReinforcementFromMap (1, "JTI", 3, 390);
         ChangeFormation (390, 3)
         Cmd (3, 390, 100, 3878, 4760);
         break;
        end;
    end;
end;

function At2 ()
    
  while 1 do 
    Wait (2)
       if (GetNUnitsInArea (0, "Attack", 0) > 0) then 
       Wait (1)
         LandReinforcementFromMap (1, "JTI", 2, 391);
         ChangeFormation (391, 3)
         Cmd (3, 391, 100, 3545, 6654);
         break;
        end;
    end;
end;
------------------------------------------------
function Secret1 ()

while 1 do
     Wait (2)
        if ( GetNUnitsInScriptGroup ( 1000 ) < 1 )  and T1 < 1 then
          s = s+1
         break;
        end;
    end;
end;
    
function Secret2 ()

while 1 do
     Wait (2)
        if ( GetNUnitsInScriptGroup ( 2000 ) < 1 )  and T1 < 1 then
          s = s+1
         break;
        end;
    end;
end;

function Secret ()

while 1 do 
     Wait (2)
        if s == 2 and l < 1 then
          Wait (3)
          CompleteObjective(3)
          break;
        end;
    end;
end;
    
--------------------------------------------STARTING FUNCTIONS 
SetIGlobalVar( "temp.general_reinforcement", 0 );
GiveObjective( 0 );
StartThread( Caput );
StartThread( Victory );
StartThread( Check1 ); 
StartThread( Check3 );
StartThread( Check2 ); 
StartThread( Check4 );
StartThread (Recon1);
StartThread (Recon1_1);
StartThread (Recon2);
StartThread (Recon3);
StartThread (Recon33);
StartThread (KeyPoint);
StartThread (At1);
StartThread (At2);
StartThread (Secret);
StartThread( Trucks01 );
StartThread( Trucks02 );