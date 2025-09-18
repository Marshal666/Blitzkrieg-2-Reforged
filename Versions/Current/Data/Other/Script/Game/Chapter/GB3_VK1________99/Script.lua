function RevealObjective1()
	Wait(10);
	StartThread( Lose );
	StartThread( Winner1 );
	ObjectiveChanged(0, 1);
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


function Winner1()
        while 1 do
            if ( GetNUnitsInArea(1, "most") < 1) then
                Wait(2);
				ObjectiveChanged(0, 2);
				StartThread( RevealObjective2 );
         return 1;
	end;
	Wait(5);
	end;
end;


function RevealObjective2()
    Wait(5);
	Wait(10);
	StartThread( Winner2 );
	ObjectiveChanged(1, 1);
	StartThread( Winner2 );
end;

function Winner2()
        while 1 do
            if ( GetNUnitsInArea(1, "gorod") < 1) then
               	Wait(2);
				ObjectiveChanged(1, 2);
				return 1;
	end;
	Wait(5);
	end;
end;

function ataka1()
        while 1 do
            if ( GetNUnitsInArea(0, "post1") > 2) then
                Wait(5);
				Cmd (3, 100, 7408, 7744)
				return 1;
	end;
	Wait(5);
	end;
end;

function ataka2()
        while 1 do
            if ( GetNUnitsInArea(0, "post2") > 2) then
                Wait(5);
				Cmd (3, 101, 3010, 7559)
				return 1;
	end;
	Wait(5);
	end;
end;


--Main
StartThread( RevealObjective1 );
StartThread( ataka1 );
StartThread( ataka2 );