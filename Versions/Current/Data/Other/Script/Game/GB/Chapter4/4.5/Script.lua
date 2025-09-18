function RevealObjective0()
	Wait(2);
	GiveObjective( 0 );
	Wait(2);
	StartThread( CompleteObjective0 );
end;


function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (IsSomeUnitInArea(0, "Exits", 0) > 0)then
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.objective0", 2 );
			Wait(2);
			Win(0);
			break;
		end;	
	end;
end;
--------------------------------------------------------
function Lose1()
    while 1 do
        if (( IsSomeUnitInArea(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(2);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;

function Lose2()
	while 1 do
		Wait(2);
		if ( GetNUnitsInScriptGroup( 290 ) < 3 ) then
			Wait(2);
			Win(1);
			break
		end;
	end;
end;




-------------------Main

StartThread( RevealObjective0 );
StartThread( Lose1 );
StartThread( Lose2 );
--StartThread( Start_Patrol );
--StartThread( Start_Patrol1 );









