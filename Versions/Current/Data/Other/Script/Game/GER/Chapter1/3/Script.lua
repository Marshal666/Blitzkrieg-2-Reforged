OX = {};
OY = {};
-----------------------Mine
function Mine()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 0 , "Go1" , 0 ) > 0)  then
			Wait( 3 );
			Trace ("mine");
			n = 5; m = 4; z = 1; OX [1] = 6947; OY [1] = 3476;
			StartThread( Mine1 );
			n1 = 4; m1 = 5; z1 = 2; OX [2] = 6578; OY [2] = 3429;
			StartThread( Mine1 );
			StartThread( Mine2 );
			StartThread( Mine0 );
			break;
		end;
	end;
end;
function Mine0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 0 , "Go2" , 0 ) > 0)  then
			Wait( 3 );
			n2 = 4; m2 = 4; z2 = 3; OX [3] = 4567; OY [3] = 5237;
			StartThread( Mine11 );
			n3 = 4; m3 = 4; z3 = 4; OX [4] = 4267; OY [4] = 5159;
			StartThread( Mine11 );
			StartThread( Mine21 );
			StartThread( Mine00);
			break;
		end;
	end;
end
function Mine00()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 0 , "Go3" , 0 ) > 0)  then
			Wait( 3 );
			n4 = 5; m4 = 3; z4 = 5; OX [5] = 2695; OY [5] = 7884;
			StartThread( Mine12 );
			n5 = 5; m5 = 3; z5 = 5; OX [6] = 2381; OY [6] = 7470;
			StartThread( Mine12 );
			StartThread( Mine22 );
			break;
		end;
	end;
end;
function Mine12()
	Wait( 3 );
	Cmd ( 11 , 104 , 0 , OX [z4] , OY [z4] )
	for a4 = 1 , m4 do
		Wait( 3 );
		for b4 = 1 , n4 do
			Wait( 3 );
			QCmd ( 11 , 104 , 0 , OX [z4] + 2*(b4-1) , OY [z4] - 102*(b4-1) )
		end;
		OX [z4] = OX [z4] + 100*a4; OY [z4] = OY [z4] + 2*a4;
	end;
end;
function Mine22()
	Wait( 3 );
	Cmd ( 11 , 105 , 0 , OX [z5] , OY [z5] )
	for a5 = 1 , m5 do
		Wait( 3 );
		for b5 = 1 , n5 do
			Wait( 3 );
			QCmd ( 11 , 105 , 0 , OX [z5] + 4*(b5-1) , OY [z5] + 80*(b5-1) )
		end;
		OX [z5] = OX [z5] + 60*a2; OY [z5] = OY [z5] + 20*a5;
	end;
end;
function Mine11()
	Wait( 3 );
	Cmd ( 11 , 102 , 0 , OX [z2] , OY [z2] )
	for a2 = 1 , m2 do
		Wait( 3 );
		for b2 = 1 , n2 do
			Wait( 3 );
			QCmd ( 11 , 102 , 0 , OX [z2] - 60*(b2-1) , OY [z2] - 15*(b2-1) )
		end;
		OX [z2] = OX [z2] + 10*a2; OY [z2] = OY [z2] - 90*a2;
	end;
end;
function Mine21()
	Wait( 3 );
	Cmd ( 11 , 103 , 0 , OX [z3] , OY [z3] )
	for a3 = 1 , m3 do
		Wait( 3 );
		for b3 = 1 , n3 do
			Wait( 3 );
			QCmd ( 11 , 103 , 0 , OX [z3] + 65*(b3-1) , OY [z3] + 10*(b3-1) )
		end;
		OX [z3] = OX [z3] + 5*a2; OY [z3] = OY [z3] - 90*a3;
	end;
end;
function Mine1()
	Wait( 3 );
	Trace ("mine1");
	Cmd ( 11 , 100 , 0 , OX [z] , OY [z] )
	for a = 1 , m do
		Wait( 3 );
		for b = 1 , n do
			Wait( 3 );
			QCmd ( 11 , 100 , 0 , OX [z] - 65*(b-1) , OY [z] + 25*(b-1) )
		end;
		OX [z] = OX [z] + 28*a; OY [z] = OY [z] + 75*a;
	end;
end;
function Mine2()
	Wait( 3 );
	Cmd ( 11 , 101 , 0 , OX [z1] , OY [z1] )
	for a1 = 1 , m1 do
		Wait( 3 );
		for b1 = 1 , n1 do
			Wait( 3 );
			QCmd ( 11 , 101 , 0 , OX [z1] - 51*(b1-1) , OY [z1] + 17*(b1-1) )
		end;
		OX [z1] = OX [z1] + 45*a1; OY [z1] = OY [z1] + 83*a1;
	end;
end;
function Repair()
	Wait( 10 );
	ChangePlayerForScriptGroup( 110, 0 );
end;
function Timer()
	while 1 do
		Wait( 3 );
		if GetGameTime (  ) > 900 then
			LandReinforcementFromMap ( 1 , "0" , 0 , 700 );
			Cmd ( 3 , 700 , 300 , GetScriptAreaParams "town")
			break;
		end;	
	end;
end;
-----------------------Objective
function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0", 1 );
	StartThread( CompleteObjective0 );
	Wait( 3 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInScriptGroup ( 104 ) < 1) and (GetNUnitsInScriptGroup ( 105 ) < 1) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0", 2 );
			StartThread( Repair );
			StartThread( Objective1 );
			Wait( 3 );
			break;
		end;	
	end;
end;
function Objective1()
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1", 1 );
	StartThread( CompleteObjective1 );
	Wait( 3 );
end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 1, "town" , 0 ) < 1) then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.objective1", 2 );
			Wait( 3 );
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Winner()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 1, "town" , 0 ) < 1) then
			Wait( 5 );
			Win(0);
			break;
		end;
	end;

end;
function Unlucky()
	while 1 do
		Wait( 3 );
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Wait( 3 );
			Win(1);
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Unlucky );
StartThread( Winner );
StartThread( Objective );

StartThread( Mine );
StartThread( Timer );