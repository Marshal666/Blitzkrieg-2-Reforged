function Obj1()
	Wait(10);
	StartThread( Lose );
	StartThread( Win1 );
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


function Win1()
        while 1 do
            if ( GetNUnitsInScriptGroup(100) < 1) then
               	Wait(2);
				ObjectiveChanged(0, 2);
				StartThread( Obj3 );
				return 1;
	end;
	Wait(5);
	end;
end;


function Obj2()
    Wait(15);
	StartThread( Win2 );
	ObjectiveChanged(1, 1);
end;

function Win2()
        while 1 do
            if ( GetNUnitsInScriptGroup(101) < 1) then
               	Wait(2);
				ObjectiveChanged(1, 2);
				return 1;
	end;
	Wait(5);
	end;
end;

function Obj3()
    Wait(5);
	StartThread( Win3 );
	ObjectiveChanged(2, 1);
end;

function Win3()
        while 1 do
            if ( GetNUnitsInScriptGroup(102) < 1) then
                Wait(2);
				ObjectiveChanged(2, 2);
				return 1;
	end;
	Wait(5);
	end;
end;

function erebus()
        while 1 do
            if ( GetNUnitsInScriptGroup(100) < 1) then
                Wait(2);
				Cmd (9, 10)
				return 1;
	end;
	Wait(5);
	end;
end;

function Camera()
	StartSequence();
	ViewZone( "battery", 1 );
	ViewZone( "battery2", 1 );
	ViewZone( "ship", 1 );
	CameraMove( 0, 2000 );
	Wait( 7 );
	CameraMove( 1, 9000 );
    Wait( 7 );
	CameraMove( 2, 10000 );
	Wait( 10 );
	EndSequence();
	StartThread( Obj1 );
    StartThread( Obj2 );
    StartThread( erebus );
end;


--Main
StartThread( Camera );