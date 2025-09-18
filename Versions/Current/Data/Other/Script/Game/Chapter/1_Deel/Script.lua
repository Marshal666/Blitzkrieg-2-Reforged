function RevealObjective1()
	Trace("StartMission DEEL Run!");
	Wait(10);
	ObjectiveChanged(1, 1);
	StartThread( Lose );
	StartThread( Winner );
	Trace("Objective1 is reveal. Destroy all enemy!.");
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
				ObjectiveChanged(1, 2);
				Wait(2);
				Win (0);
         return 1;
	end;
	Wait(5);
	end;
end;




--Main
StartThread( RevealObjective1 );

