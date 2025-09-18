

function RevealObjectives()
	Wait(3);
	ObjectiveChanged(0, 1);
	Wait(12);
	ObjectiveChanged(1, 1);
	StartThread( Sity );
	StartThread( Oil );
end;

function Sity()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "Sity") >= 1) and (GetNUnitsInArea(1, "Sity") <=0)) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.Sity,objective", 2 );   
			break;
		end;	
	end;
end;

function Oil()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "Oil") >= 1) and (GetNUnitsInArea(1, "Oil") <=0)) then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.Oil,objective", 2 );   
			break;
		end;	
	end;
end;

-------------------------------------

function Casual_winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.Sity,objective", 1) == 2) and (GetIGlobalVar("temp.Oil,objective", 1) == 2)) then
		Wait(3);
		Win(0);
		break;
		end;
	end;
end;

function Casual_caput()
        while 1 do
            if (( GetNUnitsInParty(0) < 1) and  ( GetReinforcementCallsLeft( 0 ) == 0 )) then
				Wait(3);
                Win(1);
         return 1;
	end;
	Wait(5);
	end;
end;

--Main

StartThread( Casual_winner );
StartThread( Casual_caput );
StartThread( RevealObjectives );

