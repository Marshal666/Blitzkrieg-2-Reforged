function RevealObjective0()
	Trace("StartMission Aut Run!");
	Wait(5);
	ObjectiveChanged(0, 1);
	StartThread( Lose );
	StartThread( Winner );
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
        while 1 do
            if ( GetNUnitsInParty(1) < 1) then
				ObjectiveChanged(0, 2);
				Wait(2);
				Win (0);
         return 1;
	end;
	Wait(5);
	end;
end;




--Main
StartThread( RevealObjective0 );

