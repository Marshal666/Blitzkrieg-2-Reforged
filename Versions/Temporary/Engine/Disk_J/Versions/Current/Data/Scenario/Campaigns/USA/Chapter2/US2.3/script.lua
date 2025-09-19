c1=0
c2=0
c3=0
c4=0
c5=0
a1=0
a2=0
Objective0=0
Objective1=0
-----------------------Defeat
function Caput ()
    while 1 do
        Wait( 3 );
        if ( GetNUnitsInPlayerUF ( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
		Wait(2);
		Win(1);
		return 1;
		end;
	end;
end;
-----------------------Victory
function Victory ()

    while 1 do
        Wait ( 3 );
        if  Objective0 == 1 and Objective1 == 1 then
        Wait (2);
        Win (0);
        return 1;
        end;
    end;
end;
-----------------------Transition 
function Change1 ()
    while 1 do
     Wait (1)
         if (GetNUnitsInArea ( 0, "F", 0) > 0) then
         ChangePlayerForScriptGroup (99, 0);
         c1=1;
         break;
        end;
    end;
end;
    
function Change2 ()
    while 1 do
     Wait (1)
         if (GetNUnitsInArea ( 0, "A", 0) > 0) then
         ChangePlayerForScriptGroup (100, 0);
         c2=1;
         break;
        end;
    end;
end;    
    
function Change3 ()
    while 1 do
     Wait (1)
         if (GetNUnitsInArea ( 0, "B", 0) > 0) then
         ChangePlayerForScriptGroup (101, 0);
         c3=1;
         break;
        end;
    end;
end;     

function Change4 ()
    while 1 do
     Wait (1)
         if (GetNUnitsInArea ( 0, "C", 0) > 0) then
         ChangePlayerForScriptGroup (102, 0);
         c4=1;
         break;
        end;
    end;
end;     

function Change5 ()
    while 1 do
     Wait (1)
         if (GetNUnitsInArea ( 0, "D", 0) > 0) then
         ChangePlayerForScriptGroup (103, 0);
         c5=1;
         break;
        end;
    end;
end; 
---------------------------------------------Attack
function Attack1 ()
    while 1 do
     Wait (1)
        if (GetNUnitsInArea ( 0, "Attack", 0) > 0) then
         Wait (1)
         StartThread (Step11)
         break;
        end;
    end;
end;

function Step11 ()
    while 1 do 
     Wait (60+Random(60))
        if a1<1 and (GetNUnitsInScriptGroup (2000, 1) < 1) then
          LandReinforcementFromMap (1, 'JTI', 0, 2000 )
          a1=a1+1
          Cmd (3, 2000, 300, 3837, 3722);
          QCmd (3, 2000, 600, 779, 7093);
        end;
    end;
end;

function Attack2 ()
    while 1 do
     Wait (1)
        if (GetNUnitsInArea ( 0, "Attack", 0) > 0) then 
         Wait (1)
         StartThread (Step22);
         break;
        end;
    end;
end;

function Step22 ()
    while 1 do
     Wait (10+Random(20))
        if a2<2 and (GetNUnitsInScriptGroup (3000, 1) < 1) then
         LandReinforcementFromMap (1, 'JTI', 1, 3000 )
         a2=a2+1
         Cmd (3, 3000, 300, 3837, 3722);
         QCmd (3, 3000, 600, 779, 7093);
        end;
    end;
end;
---------------------------------------------Trucks
function Trucks ()
    while 1 do
     Wait (3)
        if a1==1 and (GetNUnitsInScriptGroup (2000, 1) < 1) then
         Wait (3)
         Cmd (0, 4, 50, 3774, 1688);
         QCmd (0, 4, 50, 3881, 3826);
         QCmd (0, 4, 50, 4622, 4861);
         QCmd (0, 4, 50, 5811, 5734);
         QCmd (0, 4, 50, 6632, 6647);
         QCmd (0, 4, 50, 8072, 7180)
         QCmd (ACT_DISAPPEAR, 4);
         break;
        end;
    end;
end;   
--------------------------------------------Artillery
function Artillery1 ()
    while 1 do
     Wait (2)
      if (GetNUnitsInArea (0, "Artillery", 0) > 0) then 
         Cmd (56, 501, 401);
         Cmd (56, 502, 402);
         Cmd (56, 503, 403);
         Cmd (56, 504, 404);
         Cmd (56, 505, 405);
         Cmd (56, 506, 406);
         Wait (5);
         StartThread (Artillery2);
         break;
        end;
    end;
end;

function Artillery2 ()
    while 1 do 
     Wait (2)
     if (GetNUnitsInArea (0, "Artillery", 0) > 0) then 
         Cmd (ACT_SUPPRESS, 401, 500, 1802, 5765);
         QCmd (ACT_SUPPRESS, 401, 500, 2235, 6837);
         Cmd (ACT_SUPPRESS, 402, 500, 1802, 5765);
         QCmd (ACT_SUPPRESS, 402, 500, 2235, 6837);
         Cmd (ACT_SUPPRESS, 403, 500, 1802, 5765);
         QCmd (ACT_SUPPRESS, 403, 500, 2235, 6837);
         Cmd (ACT_SUPPRESS, 404, 500, 1802, 5765);
         QCmd (ACT_SUPPRESS, 404, 500, 2235, 6837);
         Cmd (ACT_SUPPRESS, 405, 500, 1802, 5765);
         QCmd (ACT_SUPPRESS, 405, 500, 2235, 6837);
         Cmd (ACT_SUPPRESS, 406, 500, 1802, 5765);
         QCmd (ACT_SUPPRESS, 406, 500, 2235, 6837);
        end;
    end;
end;
---------------------------------------------Allied units
function Change ()
    while 1 do
     Wait (1)
        if c1==1 and c2==1 and c3==1 and c4==1 and c5==1 then
         Wait (1)
         CompleteObjective(0)
         Objective0=1
         DamageScriptObject (10, 100);
         Wait (3)
         GiveObjective(1)
         Wait (1)
         DamageScriptObject (20, 10);
         break;
        end;
    end;
end;
---------------------------------------------Village
function Village ()
    while 1 do
     Wait (1)
        if  ( GetNUnitsInArea ( 1, "Village", 0 ) <1 ) then
          CompleteObjective(1)
          Objective1=1
          DamageScriptObject (20, 100);
          break;
        end;
    end;
end;
---------------------------------------------
GiveObjective (0);
StartThread (Caput);
StartThread (Victory);
StartThread (Change1);
StartThread (Change2);
StartThread (Change3);
StartThread (Change4);
StartThread (Change5);
StartThread (Change);
StartThread (Village);
StartThread (Attack1);
StartThread (Attack2);
StartThread (Trucks);
StartThread (Artillery1);
