
-----------------------Shuher
function Shuher()
	LandReinforcementFromMap ( 1 , "0" , 0 , 110 );
	LandReinforcementFromMap ( 1 , "0" , 1 , 111 );
	LandReinforcementFromMap ( 1 , "4" , 3 , 112 );
	LandReinforcementFromMap ( 1 , "3" , 2 , 113 );
	Wait( 1 );
	Cmd( 16 , 110 , 200 , GetScriptAreaParams "mine1" );
	Cmd( 16 , 111 , 200 , GetScriptAreaParams "mine2" );
	Cmd( 3 , 112 , 0 , GetScriptAreaParams "vic" );
	QCmd( 3 , 112 , 0 , GetScriptAreaParams "vic1" );
	QCmd( 3 , 112 , 0 , GetScriptAreaParams "vic2" );
	QCmd( 3 , 112 , 0 , GetScriptAreaParams "vic" );
	Cmd( 3 , 113 , 0 , GetScriptAreaParams "mash" );
	QCmd( 3 , 113 , 0 , GetScriptAreaParams "mash1" );
	QCmd( 3 , 113 , 0 , GetScriptAreaParams "vic" );
	Wait( 3 );
	StartThread( minefhrowers );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "2" , 4 , 114 );
	Cmd( 3 , 114 , 0 , GetScriptAreaParams "mash" );
	QCmd( 3 , 114 , 0 , GetScriptAreaParams "vic" );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 115 );
	Cmd( 3 , 115 , 0 , GetScriptAreaParams "mash" );
	QCmd( 3 , 115 , 0 , GetScriptAreaParams "vic" );
end;
function minefhrowers()
	vremy = RandomInt ( 20 );
	Wait ( vremy );
	Cmd( 16 , 110 , 200 , GetScriptAreaParams "mine1" );
	Cmd( 16 , 111 , 200 , GetScriptAreaParams "mine2" );
	if GetNAmmo ( 110 ) + GetNAmmo ( 111 ) > 0 then
		StartThread( minefhrowers );
	end;
end;
-----------------------Objective
function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0" , 1 );
	StartThread( CompleteObjective0 );
	Wait( 3 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if  IsSomeUnitInArea ( 0 , 'mash' , 0 ) > 0 and IsSomeUnitInArea ( 1 , 'mash' , 0 ) < 1 then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0" , 2 );
			ChangePlayerForScriptGroup( 100, 0 );
			Wait( 3 );
			StartThread( Objective1 );
			StartThread( Shuher );
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
		if  GetNScriptUnitsInArea ( 100 , 'vic' , 0 ) == 4 then
			ObjectiveChanged(1 , 2);
			SetIGlobalVar( "temp.objective1" , 2 );
			Win ( 0 );
			Wait( 3 );
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Looser()
	while 1 do
		Wait( 3 );
        if (( IsSomeUnitInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Wait( 3 );
			Win(1);
			break;
		end;	
	end;
end;
function Looser1()
	while 1 do
		Wait( 3 );
        if ( GetNUnitsInScriptGroup ( 100 ) < 4) then
			Wait( 3 );
			Win(1);
			break;
		end;	
	end;
end;
-------------------------------------------  MAIN
StartThread( Objective );
StartThread( Looser );
StartThread( Looser1 );