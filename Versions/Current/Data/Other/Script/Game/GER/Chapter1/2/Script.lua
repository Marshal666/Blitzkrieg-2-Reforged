n = 1;
nom = {};
nom [1] = "1"; nom [2] = "2"; nom [3] = "3";
z = 1;

n1 = 1;
nom1 = {};
nom1 [1] = "1"; nom1 [2] = "2"; nom1 [3] = "3";
z1 = 1;

R1 = 0; R2 = 0;
-----------------------Reinforcement
function Reinforcement0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 0 , "R1" , 0 ) > 0 ) then
			Wait( 3 );
			LandReinforcementFromMap ( 1 , "0" , 2 , 600 );
			Cmd (3 , 600 , 0 , GetScriptAreaParams "R1");
			if (R1 == 0) then
				R1 = 1;
				Wait ( 90 );
				StartThread( Reinforcement1 );
			end;
			break;
		end;
		if (GetNUnitsInArea ( 0 , "R2" , 0 ) > 0) then
			Wait( 3 );
			LandReinforcementFromMap ( 1 , "0" , 2 , 600 );
			Cmd (3 , 600 , 0 , GetScriptAreaParams "R2");
			if (R2 == 0) then
				R2 = 1;
				Wait ( 90 );
				StartThread( Reinforcement2 );
			end;
			break;
		end;
	end;
end;
function Reinforcement1()
	while 1 do
		Wait( 3 );
		if GetNUnitsInScriptGroup ( 999 , 0 ) < 1 then
			Wait( 3 );
			StartThread( Reinforcement11 );
			break;
		end;
	end;
end;
function Reinforcement11()
	LandReinforcementFromMap ( 1 , nom[n] , 0 , 100 + z);
	Cmd ( 3 , 100 + z , 0 , 2762 , 5511 );
	QCmd ( 3 , 100 + z , 0 , 4092 , 4587 );
	if (n == 2) then
		n = 1;
	else
		n = n + 1;
	end;
	z = z + 1;
	Wait ( 90 );
	if (z < 6) then
		StartThread( Reinforcement1 );
	end;
	if (R2 == 0) then
		R2 = 1;
		StartThread( Waiting2  );
	end;
end;
function Reinforcement2()
	while 1 do
		Wait( 3 );
		if GetNUnitsInScriptGroup ( 998 , 0 ) < 1 then
			Wait( 3 );
			StartThread( Reinforcement22 );
			break;
		end;
	end;
end;
function Reinforcement22()
	LandReinforcementFromMap ( 1 , nom[n1] , 1 , 200 + z1);
	Cmd ( 3 , 200 + z1 , 0 , 4092 , 4587 );
	if (n1 == 2) then
		n1 = 1;
	else
		n1 = n1 + 1;	
	end;
	z1 = z1 + 1;
	Wait ( 90 );
	if (z1 < 6) then
		StartThread( Reinforcement2 );
	end;
	if (R1 == 0) then
		R1 = 1;
		StartThread( Waiting1  );
	end;
end;
-----------------------Waiting
function Waiting2()
	Wait ( 120 );
	StartThread( Reinforcement2 );
end;
-----------------------Waiting
function Waiting1()
	Wait ( 120 );
	StartThread( Reinforcement1 );
end;
-----------------------Shtab
function Shtab()
	while 1 do
		Wait( 3 );
		if (IsSomeUnitInArea ( 0 , "Shtab" , 0 ) > 1) and (IsSomeUnitInArea ( 1 , "Shtab" , 0 ) < 1) then
			Wait( 120 );
			StartThread( Check );
			break;
		end;
	end;
end;
function Check()
	while 1 do
		Wait( 3 );
		if (IsSomeUnitInArea ( 0 , "Shtab" , 0 ) > 1) and (IsSomeUnitInArea ( 1 , "Shtab" , 0 ) < 1) then
			Wait( 3 );
			StartThread( Winner );
			break;
		else
			StartThread( Shtab );
			break;
		end;
	end;
end;
-----------------------Objective
function Objective()
	Wait( 3 );
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0", 1 );
	StartThread( CompleteObjective0 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (IsSomeUnitInArea ( 1 , "Shtab" , 0 ) < 1) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0", 2 );
			Wait( 3 );
			Win(0);
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Winn()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInParty(1) == GetNUnitsInArea ( 1 , "Shtab" , 0 )) then
			Wait( 3 );
			StartThread( Winner );
			Win(0);
			break;
		end;
	end;
end;
function Winner()
	Wait( 3 );
	Win(0);
end;
function Unlucky()
	while 1 do
		Wait( 3 );
        if (( IsSomeUnitInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Unlucky );
StartThread( Winn );
StartThread( Shtab );
StartThread( Objective );

StartThread( Reinforcement0 );