

function RevealObjective0()
	
	Wait(5);
	ObjectiveChanged(0, 1);
	
	StartThread( Obj0 );
end;

function RevealObjective1()
	
	ObjectiveChanged(1, 1);
	
end;

function RevealObjective2()
	
	ObjectiveChanged(2, 1);
	
end;

function Obj0()
        while 1 do
			
            if ( GetNUnitsInScriptGroup(101) < 3) then
				
                Cmd( 0, 101, 256, 5400,7000);
                StartThread( Choice );
				return 1;
			end;
			Wait(5);
		end;
end;

function Obj1()
        while 1 do
       
			
			--if ( GetNUnitsInScriptGroup(112) < 1) then
			if ( GetNUnitsInArea(1,"pereval",0) > 0) then
				
			end
			
			if ( GetNUnitsInArea(1,"pereval",0) < 1) then
				
                ObjectiveChanged(1, 2);
                StartThread( Winner );
				return 1;
			end;
			Wait(5);
		end;
end;

function Obj2()
        while 1 do
		    if ( GetNUnitsInArea(1,"village",0) > 0) then
				
			end
			
			if ( GetNUnitsInArea(1,"village",0) < 1) then
				
                ObjectiveChanged(2, 2);
                StartThread( Winner );
				return 1;
			end;
			
			Wait(5);
		end;
end;


function Choice()
        while 1 do
       
			
            if ( GetNUnitsInScriptGroup(101) < 1) then
                ObjectiveChanged(0, 2);
                RemoveScriptGroup(102);
                
				StartThread( RevealObjective2 );
				
                StartThread( ReinfP0 );
                
                StartThread( Obj2 );
				return 1;
			end;
			if ( GetNUnitsInArea(1,"away",0) > 0) then
				
                ObjectiveChanged(0, 2);
                RemoveScriptGroup(101);
                RemoveScriptGroup(103);
                
                StartThread( RevealObjective1 );
                
                
                StartThread( ReinfP0 );
                
                StartThread( Obj1 );
				return 1;
			end;
			Wait(1);
		end;
end;

function ReinfP0()
	LandReinforcement(0,1015,0,1);
	LandReinforcement(0,1016,1,2);
	LandReinforcement(0,1017,2,3);
	LandReinforcement(0,1018,3,4);
end;


function Patrol1()
local pt = 6;
	while ( GetNUnitsInScriptGroup( 100 ) > 0 ) do
		if ( pt > 6 ) then
			pt = 1;
		end;
		Cmd( ACT_SWARM, 100, 192, GetScriptAreaParams( "P" .. pt ) );
		WaitForGroupAtArea( 100, "P" .. pt );
		Wait( Random( 10 ) );
		pt = pt + 1;
	end;
end;

function Lose()
        while 1 do
            if ( GetNUnitsInParty(0) < 1) then
				Wait(3);
                Loose(0);
         return 1;
	end;
	Wait(5);
	end;
end;

function Winner()
        
				Wait(2);
				Win (0);
				return 1;
	
end;




--Main
StartThread( RevealObjective0 );
StartThread( Lose );

StartThread( Patrol1 );