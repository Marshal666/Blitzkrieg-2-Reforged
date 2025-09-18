fr1 = 0;
fr2 = 0;
fr3 = 0;
-----------------------Reinf
function Reinf()
	Wait ( 120 );
	LandReinforcementFromMap ( 1 , 0 , 0 , 300 );
	Wait ( 1 );
	Cmd( 3 , 300 , 0 , GetScriptAreaParams ( "Town" ) );
	Wait ( 20 );
	LandReinforcementFromMap ( 1 , 1 , 0 , 150 );
	Wait ( 1 );
	Cmd( 3 , 150 , 0 , GetScriptAreaParams ( "Town" ) );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , 2 , 0 , 150 );
	Wait ( 1 );
	Cmd( 3 , 150 , 0 , GetScriptAreaParams ( "Town" ) );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , 1 , 0 , 150 );
	Wait ( 1 );
	Cmd( 3 , 150 , 0 , GetScriptAreaParams ( "Town" ) );
	StartThread( CompleteObjective1 );
end;
-----------------------Boat
function Viewboat()
	Wait ( 1 );
	ViewZone ( "boat1", 0 );
	ViewZone ( "boat2", 0 );
end;
function Findboat()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "boat" , 0 ) > 0 then
			ChangePlayerForScriptGroup( 55 , 0 );
			ViewZone ( "boat1", 1 );
			ViewZone ( "boat2", 1 );
			Wait( 1 );
			break;
		end;	
	end;
end;
-----------------------Patrol
function Patrol()
	Wait ( 1 );
	Cmd( 3 , 100 , 0 , GetScriptAreaParams ( "p11" ) );
	QCmd( 3 , 100 , 0 , GetScriptAreaParams ( "p12" ) );
	QCmd( 3 , 100 , 0 , GetScriptAreaParams ( "p13" ) );
	QCmd( 3 , 100 , 0 , GetScriptAreaParams ( "p14" ) );
	Wait ( 60 );
	StartThread( Patrol );
end;
function Patrol2()
	Wait ( 1 );
	Cmd( 3 , 102 , 0 , GetScriptAreaParams ( "p21" ) );
	QCmd( 3 , 102 , 0 , GetScriptAreaParams ( "p22" ) );
	QCmd( 3 , 102 , 0 , GetScriptAreaParams ( "p23" ) );
	Wait ( 60 );
	StartThread( Patrol2 );
end;
function Patrol3()
	Wait ( 1 );
	Cmd( 3 , 103 , 0 , GetScriptAreaParams ( "p31" ) );
	QCmd( 3 , 103 , 0 , GetScriptAreaParams ( "p32" ) );
	Wait ( 60 );
	StartThread( Patrol3 );
end;
-----------------------Find
function Find1()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr1" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 0 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr1 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find2()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr2" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 1 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr1 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find3()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr3" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 2 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr1 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find4()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr4" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 3 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr1 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find12()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr5" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 4 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr2 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find22()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr6" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 5 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr2 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find32()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr7" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 6 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr2 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find42()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr8" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 7 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr2 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find13()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr9" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 8 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr3 = 1;
			Wait( 1 );
			break;
		end;	
	end;
end;
function Find23()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "fr10" , 0 ) > 0 then
			Sleep ( 1 );
			LandReinforcementFromMap ( 2 , 0 , 9 , 200 );
			Wait( 1 );
			ChangePlayerForScriptGroup( 200 , 0 );
			fr3 = 1;
			Wait( 1 );
			break;
		end;	
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
		if  fr1 + fr2 + fr3 == 3 then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0" , 2 );
			Wait( 3 );
			StartThread( Objective1 );
			StartThread( Unlucky2 );
			StartThread( Reinf );
			Wait( 1 );
			break;
		end;	
	end;
end;
function Objective1()
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1" , 1 );
	Wait( 3 );
end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if  IsSomeBodyAlive ( 1 , 150 ) == 0 then
			Wait( 1 );
			ObjectiveChanged(0, 2);
			Win(0);
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Unlucky1()
	while 1 do
		Wait( 1 );
        if  (IsSomeBodyAlive ( 0 , 199 ) + IsSomeBodyAlive ( 0 , 200 )) < 1 then
			Win(1);
			Wait( 1 );
			break;
		end;
	end;
end;
function Unlucky2()
	while 1 do
		Wait( 1 );
        if  (GetNScriptUnitsInArea ( 150, 'Town', 0 )) > 0 then
			Win(1);
			Wait( 1 );
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Viewboat );
StartThread( Objective );
StartThread( Unlucky1 );

StartThread( Find1 );
StartThread( Find2 );
StartThread( Find3 );
StartThread( Find4 );
StartThread( Find12 );
StartThread( Find22 );
StartThread( Find32 );
StartThread( Find42 );
StartThread( Find13 );
StartThread( Find23 );

StartThread( Findboat )

StartThread( Patrol );
StartThread( Patrol2 );
StartThread( Patrol3 );