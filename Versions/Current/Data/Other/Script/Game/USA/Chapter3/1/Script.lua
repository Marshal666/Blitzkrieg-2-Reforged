-----------------------Damage
function Damage()
	Sleep ( 1 );
	DamageScriptObject ( 1 , 0 );
	Sleep ( 1 );
	ChangePlayerForScriptGroup( 2 , 0 );
end;
-----------------------Run
function Run()
	Wait ( 1 );
	Cmd( 3 , 100 , 500 , 3435 , 3247 );
end;
-----------------------Ataka
function Ataka1()
	Wait( 90 );
	LandReinforcementFromMap ( 1 , 0 , 0 , 500 );
	Wait ( 1 );
	Cmd( 3 , 500 , 500 , 3435 , 3247 );
	LandReinforcementFromMap ( 1 , 1 , 0 , 501 );
	Wait ( 1 );
	Cmd( 0 , 501 , 0 , 5978 , 5830 );
	QCmd( 0 , 501 , 0 , 5714 , 170 );
	LandReinforcementFromMap ( 1 , 1 , 0 , 502 );
	Wait ( 1 );
	Cmd( 0 , 502 , 0 , 315 , 5821 );
	QCmd( 0 , 502 , 0 , 120 , 323 );
	Wait (60)
	LandReinforcementFromMap ( 1 , 2 , 0 , 503 );
	Wait ( 1 );
	Cmd( 3 , 503 , 500 , 3435 , 3247 );
	LandReinforcementFromMap ( 1 , 2 , 0 , 504 );
	Wait ( 1 );
	Cmd( 0 , 504 , 0 , 5978 , 5830 );
	QCmd( 0 , 504 , 0 , 6018 , 3179 );
	LandReinforcementFromMap ( 1 , 2 , 0 , 505 );
	Wait ( 1 );
	Cmd( 0 , 505 , 0 , 315 , 5821 );
	QCmd( 0 , 505 , 0 , 377 , 2514 );
	Wait (120)
	LandReinforcementFromMap ( 1 , 0 , 0 , 506 );
	Wait ( 1 );
	Cmd( 3 , 506 , 500 , 3435 , 3247 );
	Cmd( 3 , 501 , 0 , 5714 , 170 );
	Cmd( 3 , 502 , 0 , 5714 , 170 );
	Cmd( 3 , 504 , 500 , 3435 , 3247 );
	Cmd( 3 , 505 , 500 , 3435 , 3247 );
	Wait (120)
	LandReinforcementFromMap ( 1 , 0 , 0 , 507 );
	Wait ( 1 );
	Cmd( 3 , 507 , 500 , 3435 , 3247 );
end;
-----------------------Objective
function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0" , 1 );
	Wait ( 90 );
	StartThread( CompleteObjective0 );
	StartThread( CompleteObjective01 );
	Wait( 3 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea( 0 , "Visota" , 0 ) > 0) and (GetNUnitsInArea( 1 , "Visota" , 0 ) < 1) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0" , 2 );
			Wait( 3 );
			StartThread( Objective1 );
			Wait( 3 );
			StartThread( Ataka1 );
			break;
		end;	
	end;
end;
function CompleteObjective01()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea( 0 , "Visota" , 0 ) < 1) and GetGameTime (  ) > 60 then
			Wait( 2 );
			Win(1);
			break;
		end;	
	end;
end;
function Objective1()
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1" , 1 );
	StartThread( CompleteObjective1 );
	Wait( 3 );
end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if (GetGameTime (  ) > 900) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective1" , 2 );
			Wait( 3 );
			Win(0);
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Unlucky()
	while 1 do
		Wait( 3 );
        if ( GetNUnitsInParty( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
			Wait( 2 );
			Win(1);
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Objective );
StartThread( Unlucky );

StartThread( Damage );
StartThread( Run );