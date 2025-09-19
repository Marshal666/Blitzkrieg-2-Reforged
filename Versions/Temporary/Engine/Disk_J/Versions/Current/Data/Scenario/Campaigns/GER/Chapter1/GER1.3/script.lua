OX = {};
OY = {};

function AddReinf()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 520 ) > 0 and IsSomeBodyAlive ( 0 , 1000 ) < 1 then
			while 1 do
				Wait( 1 );
				if IsSomeUnitInArea ( 0 , 'Go3', 0 ) > 0 then
					LandReinforcementFromMap ( 0 , "1" , 0 , 1000);
					Cmd ( 3 , 1000 , 0 , "Reinf" )
				end;
				break;
			end;
		end;
		if IsSomeBodyAlive ( 1 , 520 ) < 1 then
			break;
		end;
	end;
end;

function OutBlock()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'BlockPost1', 0 ) > 0 then
			Wait( 3 );
			Cmd ( 0 , 511 , 0 , "OutBlockPost1" );
			Wait ( 6 );
			Cmd ( 5 , 511 , 0 , "OutBlockPost1" );
			Wait ( 2 );
			Cmd (	0 , 511 , 0 , "Flee1" );
			QCmd (	0 , 511 , 0 , "Go2" );
			QCmd (	0 , 511 , 0 , "Flee2" );
			QCmd (	0 , 511 , 0 , "Go3" );
			QCmd (	0 , 511 , 0 , "Flee3" );
			QCmd (	1007 , 511  );
			break;
		end;
	end;
end;

function FleeBlock()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'FleeBlockPost1', 0 ) > 0 then
			Wait( 1 );
			Cmd ( 4 , 500 , 501 );
			Wait ( 6 );
			Cmd (	0 , 501 , 0 , "Flee1" );
			QCmd (	0 , 501 , 0 , "Go2" );
			QCmd (	0 , 501 , 0 , "Flee2" );
			QCmd (	0 , 501 , 0 , "Go3" );
			QCmd (	0 , 501 , 0 , "Flee3" );
			QCmd (	1007 , 501  );
			break;
		end;
	end;
end;

-----------------------Mine
function Ata()
	while 1 do
		Wait( 1 );
		if (GetNUnitsInArea ( 0 , "Ata" , 0 ) > 0)  then
			StartThread( Timer );
			break;
		end;
	end;
end;
function Mine()
	while 1 do
		Wait( 10 );
		if (GetNUnitsInArea ( 0 , "Go1" , 0 ) > 0)  then
			Wait( 20 );
			Cmd ( 11 , 101 , 0 , GetScriptAreaParams "mine1");
			Cmd ( 11 , 100 , 0 , GetScriptAreaParams "mine5");
			Wait( 20 );
			Cmd ( 11 , 101 , 0 , GetScriptAreaParams "mine2");
			Cmd ( 11 , 100 , 0 , GetScriptAreaParams "mine6");
			Wait( 20 );
			Cmd ( 11 , 101 , 0 , GetScriptAreaParams "mine3");
			Cmd ( 11 , 100 , 0 , GetScriptAreaParams "mine7");
			Wait( 20 );
			Cmd ( 11 , 101 , 0 , GetScriptAreaParams "mine4");
			Cmd ( 11 , 100 , 0 , GetScriptAreaParams "mine8");
			break;
		end;
	end;
end;

function Mine0()
	while 1 do
		Wait( 10 );
		if (GetNUnitsInArea ( 0 , "Go2" , 0 ) > 0)  then
			Wait( 20 );
			Cmd ( 11 , 102 , 0 , GetScriptAreaParams "mine9");
			Cmd ( 11 , 103 , 0 , GetScriptAreaParams "mine11");
			Wait( 20 );
			Cmd ( 11 , 102 , 0 , GetScriptAreaParams "mine10");
			Cmd ( 11 , 103 , 0 , GetScriptAreaParams "mine12");
			break;
		end;
	end;
end

function Mine00()
	while 1 do
		Wait( 10 );
		if (GetNUnitsInArea ( 0 , "Go3" , 0 ) > 0)  then
			Wait( 20 );
			Cmd ( 11 , 104 , 0 , GetScriptAreaParams "mine13");
			Cmd ( 11 , 105 , 0 , GetScriptAreaParams "mine16");
			Wait( 20 );
			Cmd ( 11 , 104 , 0 , GetScriptAreaParams "mine14");
			Cmd ( 11 , 100 , 0 , GetScriptAreaParams "mine17");
			Wait( 20 );
			Cmd ( 11 , 104 , 0 , GetScriptAreaParams "mine15");
			Cmd ( 11 , 105 , 0 , GetScriptAreaParams "mine18");
			Wait( 20 );
			break;
		end;
	end;
end;

function Repair()
	ChangePlayerForScriptGroup( 110, 0 );
	Cmd ( 12 , 110 , 0 , GetScriptAreaParams "mine16");
	Wait ( 3 );
	LandReinforcementFromMap ( 0 , "0" , 1 , 911 );
	Cmd ( 3 , 911 , 0 , GetScriptAreaParams "Repair");
end;

function Shtab()
	while 1 do
		Wait ( 1 );
		if IsSomeUnitInArea ( 0 , 'Shtab', 0 ) > 0 then
			Cmd( 7 , 600 , 0 , GetScriptAreaParams "Shtab");
			break;
		end;
	end
end;

function Timer()
	Time = 0;
	while 1 do
		Wait( 2 );
		if GetGameTime (  ) > 1800 then
			Time = Time + 1;
			if Time > 150 then
				LandReinforcementFromMap ( 1 , "0" , 0 , 700 );
				Cmd ( 3 , 700 , 300 , GetScriptAreaParams "town");
			break;
			end;
		end;	
	end;
end;

-----------------------Objective

function Objective()
	ObjectiveChanged(0, 1); 
	StartThread( CompleteObjective0 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 0 , 6000 ) > 0 then
			ObjectiveChanged(0, 2);
			StartThread( Repair );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;

function Objective1()
	ObjectiveChanged(1, 1); 
	StartThread( CompleteObjective1 );
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 1, "town" , 0 ) < 1) then
			ObjectiveChanged(1, 2);
			Wait ( 1 );
			Win ( 0 );
			break;
		end;	
	end;
end;

------------------------WIn_Loose
function Unlucky()
	while 1 do
		Wait( 3 );
        if (( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Wait( 3 );
			Win(1);
			break;
		end;
	end;
end;

-------------------------------------------  MAIN

StartThread( Unlucky );
StartThread( Objective );
StartThread( Shtab );

StartThread( OutBlock );
StartThread( FleeBlock );
StartThread( AddReinf );
Wait ( 1 );
if GetDifficultyLevel() == 1 then
	StartThread( Mine );
	StartThread( Mine0 );
	StartThread( Mine00 );
	Cmd ( 1007 , 521 );
	
end;
if GetDifficultyLevel() == 2 then
	StartThread( Ata );
	StartThread( Mine );
	StartThread( Mine0 );
	StartThread( Mine00 );
	Cmd ( 1007 , 521 );
	Cmd ( 45 , 520 );
end;
if GetDifficultyLevel() == 0 or GetDifficultyLevel() == 3 then
	Cmd ( 1007 , 520 );
end;