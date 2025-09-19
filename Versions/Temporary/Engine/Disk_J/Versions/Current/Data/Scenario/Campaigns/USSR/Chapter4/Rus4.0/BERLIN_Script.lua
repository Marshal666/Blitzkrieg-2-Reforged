
function RevealObjective0()
	GiveObjective( 0 );
	Wait( 1 );
	GiveObjective( 1 );
	StartThread( Objective0 );
	StartThread( Objective1 );
end;

function Objective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "START", 0) > 0) and (GetNUnitsInArea(0, "START", 0) < 1)) then
			FailObjective( 0 );
			Wait( 1 );
			Win( 1 );
			break;
		end;	
	end;
end;

function Objective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(1, "HQ", 0) < 1) and (GetNUnitsInArea(0, "HQ", 0) > 0)) then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective1", 2 );
			Wait( 2 );
			GiveObjective( 2 );
			StartThread( Objective2 );
			break;
		end;	
	end;
end;

function Objective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "B1", 0) > 0) or (GetNUnitsInArea(0, "B2", 0) > 0) or (GetNUnitsInArea(0, "B3", 0) > 0)) then
			CompleteObjective( 2 );
			SetIGlobalVar( "temp.objective2", 2 );
			Wait( 2 );
			break;
		end;	
	end;
end;