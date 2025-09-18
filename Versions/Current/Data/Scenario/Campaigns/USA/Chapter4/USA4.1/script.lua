-----------------------Damage

function Damage()
	Sleep ( 1 );
	DamageScriptObject ( 1 , 0 );
	Sleep ( 1 );
	ChangePlayerForScriptGroup( 2 , 0 );
	ChangePlayerForScriptGroup( 3 , 0 );
end;

-----------------------Mines

function Mines()
	while 1 do
		Wait( 3 );
		if GetNMinesInScriptArea ( 'Mines' ) < 3 then
			CompleteObjective( 1 );
			Wait( 3 );
			Win ( 0 );
		end;	
	end;
end;

function UnMine()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 0 , 986 ) < 1 then
			Wait ( 30 );
			if GetNUnitsInScriptGroup ( 7777, 0 ) > 0 then
				LandReinforcementFromMap ( 0 , "1" , 0 , 986 );
				Cmd ( 12 , 986 , 0 , "UnMiner" );
			end;
			Wait ( 20 );
		end;	
	end;
end;

-----------------------AAGuns

function AAGun300()
	while 1 do
		Wait( 3 );
		if IsSomeBodyAlive ( 2 , 300 ) > 0 then
			LandReinforcementFromMap ( 1 , "3" , 1 , 302 );
			Cmd ( 56 , 302 , 300 );
			Wait ( 10 );
		end;	
	end;
end;

function AAGun301()
	while 1 do
		Wait( 3 );
		if IsSomeBodyAlive ( 2 , 301 ) > 0 then
			LandReinforcementFromMap ( 1 , "3" , 3 , 303 );
			Cmd ( 56 , 303 , 301 );
			Wait ( 10 );
		end;	
	end;
end;

-----------------------GerAtacks

function GerHQAtacks()
	while 1 do
		Wait( 3 );
		if GetNUnitsInScriptGroup ( 7777 , 1 ) > 0 then
			Wait ( 60 );
			if GetNUnitsInScriptGroup ( 7777 , 1 ) > 0 then
				LandReinforcementFromMap ( 1 , "5" , 5 , 291 );
				Cmd ( 3 , 291 , 200 , "Visota" );
			end;
			Wait ( 30 );
		end;	
	end;
end;

function GerAtacks()
	Wait ( 30 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 400 );
	LandReinforcementFromMap ( 1 , "0" , 1 , 401 );
	LandReinforcementFromMap ( 1 , "0" , 3 , 402 );
	Cmd ( 3 , 401 , 0 , "106" );
	QCmd ( 6 , 401 , 106 );
	Cmd ( 3 , 400 , 0 , "109" );
	QCmd ( 6 , 400 , 109 );
	Cmd ( 3 , 402 , 0 , "110" );
	QCmd ( 6 , 402 , 110 );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 410 );
	LandReinforcementFromMap ( 1 , "2" , 1 , 411 );
	LandReinforcementFromMap ( 1 , "1" , 3 , 412 );
	LandReinforcementFromMap ( 1 , "2" , 2 , 413 );
	LandReinforcementFromMap ( 1 , "0" , 4 , 414 );
	Cmd ( 3 , 411 , 0 , "106" );
	QCmd ( 6 , 411 , 106 );
	Cmd ( 3 , 410 , 0 , "109" );
	QCmd ( 6 , 410 , 109 );
	Cmd ( 3 , 412 , 0 , "110" );
	QCmd ( 6 , 412 , 110 );
	Cmd ( 3 , 413 , 0 , "600" );
	QCmd ( 6 , 413 , 600 );
	Cmd ( 3 , 414 , 0 , "600" );
	QCmd ( 6 , 414 , 600 );
	Wait ( 70 );
	StartThread( GerAtacks1 );
end;

function GerAtacks1()
	Side = Random ( 2 );
	if Side == 1 then
		LandReinforcementFromMap ( 1 , "1" , 7 , 427 );
		Cmd ( 3 , 427 , 0 , "GoLeft2" );
		QCmd ( 3 , 427 , 100 , "Visota" );
		Wait ( 20 );
		LandReinforcementFromMap ( 1 , "5" , 7 , 423 );
		Cmd ( 3 , 423 , 0 , "GoLeft2" );
		QCmd ( 3 , 423 , 100 , "Visota" );
		Wait ( 15 );
		LandReinforcementFromMap ( 1 , "5" , 7 , 425 );
		Cmd ( 3 , 425 , 0 , "GoLeft2" );
		QCmd ( 3 , 425 , 100 , "GoLeft3" );
		QCmd ( 3 , 425 , 100 , "USHQ" );
		QCmd ( 3 , 425 , 100 , "Visota" );
	else
		LandReinforcementFromMap ( 1 , "1" , 7 , 428 );
		Cmd ( 3 , 428 , 0 , "GoRight2" );
		QCmd ( 3 , 428 , 100 , "Visota" );
		Wait ( 20 );
		LandReinforcementFromMap ( 1 , "5" , 6 , 424 );
		Cmd ( 3 , 424 , 0 , "GoRight2" );
		QCmd ( 3 , 424 , 100 , "Visota" );
		Wait ( 15 );
		LandReinforcementFromMap ( 1 , "5" , 6 , 426 );
		Cmd ( 3 , 426 , 0 , "GoRight2" );
		QCmd ( 3 , 426 , 100 , "GoRight3" );
		QCmd ( 3 , 426 , 100 , "USHQ" );
		QCmd ( 3 , 426 , 100 , "Visota" );
	end;
	Wait ( 70 );
	StartThread( GerAtacks0 );
end;

function GerAtacks1000()
	LandReinforcementFromMap ( 1 , "1" , 2 , 423 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 424 );
	Cmd ( 0 , 423 , 0 , "GoLeft1" );
	QCmd ( 0 , 423 , 0 , "GoLeft2" );
	QCmd ( 3 , 423 , 0 , "GoLeft3" );
	QCmd ( 3 , 423 , 0 , "USHQ" );
	Cmd ( 0 , 424 , 0 , "GoRight1" );
	QCmd ( 0 , 424 , 0 , "GoRight2" );
	QCmd ( 3 , 424 , 0 , "GoRight3" );
	QCmd ( 3 , 424 , 0 , "USHQ" );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "1" , 2 , 425 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 426 );
	Cmd ( 0 , 425 , 0 , "GoLeft1" );
	QCmd ( 0 , 425 , 0 , "GoLeft2" );
	QCmd ( 3 , 425 , 0 , "GoLeft3" );
	QCmd ( 3 , 425 , 0 , "USHQ" );
	Cmd ( 0 , 426 , 0 , "GoRight1" );
	QCmd ( 0 , 426 , 0 , "GoRight2" );
	QCmd ( 3 , 426 , 0 , "GoRight3" );
	QCmd ( 3 , 426 , 0 , "USHQ" );
	Wait ( 35 );
	LandReinforcementFromMap ( 1 , "2" , 0 , 420 );
	LandReinforcementFromMap ( 1 , "0" , 1 , 421 );
	LandReinforcementFromMap ( 1 , "0" , 3 , 422 );
	Cmd ( 3 , 421 , 0 , "106" );
	QCmd ( 3 , 421 , 0 , "USHQ" );
	Cmd ( 3 , 420 , 0 , "109" );
	QCmd ( 3 , 420 , 0 , "USHQ" );
	Cmd ( 3 , 422 , 0 , "110" );
	QCmd ( 3 , 422 , 0 , "USHQ" );
	Wait ( 70 );
	StartThread( GerAtacks0 );
end;

function Trucky()
GroupSize = GetNUnitsInScriptGroup;
local availpoints;
local g;
local first = 1;
	while 1 do
		if ( IsSomeBodyAlive( 0, 986 ) == 0 ) then
			if first == 0 then
				Wait( 30 );
			else
				first = 0;
			end;
			availpoints = GroupSize( 7777, 0 ) + GroupSize( 7778, 0 ) + GroupSize( 7779, 0 );
			while ( availpoints == 0 ) do
				availpoints = GroupSize( 7777, 0 ) + GroupSize( 7778, 0 ) + GroupSize( 7779, 0 );
				Wait( 3 );
			end;
			for i = 0, 2 do
				if ( GetNUnitsInScriptGroup( i + 7777, 0 ) == 1 ) then
					g = i;
					break;
				end;
			end;
			LandReinforcementFromMap ( 0 , "1" , g , 986 );
		end;
		Wait( 1 );
	--Cmd ( 12 , 986 , 0 , "UnMiner" );
	end;
end;

function GerAtacks0()
	while 1 do
		Wait( 3 );
		Elite = IsSomeBodyAlive ( 1 , 423 ) + IsSomeBodyAlive ( 1 , 424 ) + IsSomeBodyAlive ( 1 , 425 ) + IsSomeBodyAlive ( 1 , 426 );
		if Elite < 1 then
			StartThread( GerAtacks2 );
			StartThread( GerAtacksM );
			Wait ( 20 );
			StartThread( Trucky );
			GiveObjective ( 1 );
			StartThread( Mines );
			break;
		end;	
	end;
end;

function GerAtacksM()
	LandReinforcementFromMap ( 1 , "4" , 1 , 521 );
	LandReinforcementFromMap ( 1 , "4" , 3 , 522 );
	LandReinforcementFromMap ( 1 , "4" , 2 , 523 );
	LandReinforcementFromMap ( 1 , "4" , 4 , 524 );
end;

function GerAtacks2()
	LandReinforcementFromMap ( 1 , "0" , 0 , 400 );
	LandReinforcementFromMap ( 1 , "0" , 1 , 401 );
	LandReinforcementFromMap ( 1 , "0" , 3 , 402 );
	Cmd ( 3 , 401 , 0 , "106" );
	QCmd ( 6 , 401 , 106 );
	Cmd ( 3 , 400 , 0 , "109" );
	QCmd ( 6 , 400 , 109 );
	Cmd ( 3 , 402 , 0 , "110" );
	QCmd ( 6 , 402 , 110 );
	Cmd ( 3 , 403 , 0 , "600" );
	QCmd ( 6 , 403 , 600 );
	Cmd ( 3 , 404 , 0 , "600" );
	QCmd ( 6 , 404 , 600 );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 410 );
	LandReinforcementFromMap ( 1 , "2" , 1 , 411 );
	LandReinforcementFromMap ( 1 , "1" , 3 , 412 );
	LandReinforcementFromMap ( 1 , "2" , 2 , 413 );
	LandReinforcementFromMap ( 1 , "0" , 4 , 414 );
	Cmd ( 3 , 411 , 0 , "106" );
	QCmd ( 6 , 411 , 106 );
	Cmd ( 3 , 410 , 0 , "109" );
	QCmd ( 6 , 410 , 109 );
	Cmd ( 3 , 412 , 0 , "110" );
	QCmd ( 6 , 412 , 110 );
	Cmd ( 3 , 413 , 0 , "600" );
	QCmd ( 6 , 413 , 600 );
	Cmd ( 3 , 414 , 0 , "600" );
	QCmd ( 6 , 414 , 600 );
	Wait ( 70 );
	StartThread( GerAtacks3 );
end;

function GerAtacks3()
	Side = Random ( 2 );
	if Side == 1 then
		LandReinforcementFromMap ( 1 , "1" , 7 , 427 );
		Cmd ( 3 , 427 , 0 , "GoLeft2" );
		QCmd ( 3 , 427 , 100 , "Visota" );
		Wait ( 20 );
		LandReinforcementFromMap ( 1 , "5" , 7 , 423 );
		Cmd ( 3 , 423 , 0 , "GoLeft2" );
		QCmd ( 3 , 423 , 100 , "Visota" );
		Wait ( 15 );
		LandReinforcementFromMap ( 1 , "5" , 7 , 425 );
		Cmd ( 3 , 425 , 0 , "GoLeft2" );
		QCmd ( 3 , 425 , 100 , "Visota" );
	else
		LandReinforcementFromMap ( 1 , "1" , 7 , 428 );
		Cmd ( 3 , 428 , 0 , "GoRight2" );
		QCmd ( 3 , 428 , 100 , "Visota" );
		Wait ( 20 );
		LandReinforcementFromMap ( 1 , "5" , 6 , 424 );
		Cmd ( 3 , 424 , 0 , "GoRight2" );
		QCmd ( 3 , 424 , 100 , "Visota" );
		Wait ( 15 );
		LandReinforcementFromMap ( 1 , "5" , 6 , 426 );
		Cmd ( 3 , 426 , 0 , "GoRight2" );
		QCmd ( 3 , 426 , 100 , "Visota" );
	end;
	Wait ( 70 );
	StartThread( GerAtacks2 );
end;

function GerAtacks3000()
	LandReinforcementFromMap ( 1 , "1" , 2 , 423 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 424 );
	Cmd ( 0 , 423 , 0 , "GoLeft1" );
	QCmd ( 0 , 423 , 0 , "GoLeft2" );
	QCmd ( 3 , 423 , 0 , "GoLeft3" );
	QCmd ( 3 , 423 , 0 , "USHQ" );
	Cmd ( 0 , 424 , 0 , "GoRight1" );
	QCmd ( 0 , 424 , 0 , "GoRight2" );
	QCmd ( 3 , 424 , 0 , "GoRight3" );
	QCmd ( 3 , 424 , 0 , "USHQ" );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "1" , 2 , 425 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 426 );
	Cmd ( 0 , 425 , 0 , "GoLeft1" );
	QCmd ( 0 , 425 , 0 , "GoLeft2" );
	QCmd ( 3 , 425 , 0 , "GoLeft3" );
	QCmd ( 3 , 425 , 0 , "USHQ" );
	Cmd ( 0 , 426 , 0 , "GoRight1" );
	QCmd ( 0 , 426 , 0 , "GoRight2" );
	QCmd ( 3 , 426 , 0 , "GoRight3" );
	QCmd ( 3 , 426 , 0 , "USHQ" );
	Wait ( 35 );
	LandReinforcementFromMap ( 1 , "2" , 0 , 420 );
	LandReinforcementFromMap ( 1 , "0" , 1 , 421 );
	LandReinforcementFromMap ( 1 , "0" , 3 , 422 );
	Cmd ( 3 , 421 , 0 , "106" );
	QCmd ( 3 , 421 , 0 , "USHQ" );
	Cmd ( 3 , 420 , 0 , "109" );
	QCmd ( 3 , 420 , 0 , "USHQ" );
	Cmd ( 3 , 422 , 0 , "110" );
	QCmd ( 3 , 422 , 0 , "USHQ" );
	Wait ( 70 );
	StartThread( GerAtacks2 );
end;

-----------------------Objective

function SecretObj()
	while 1 do
		Wait( 3 );
		if GetNScriptUnitsInArea ( 2 , 'USHQ', 0 ) > 2 then
			Cmd ( 1007 , 2 );
			Wait ( 2 );
			CompleteObjective ( 2 );
			Wait ( 30 );
			LandReinforcementFromMap ( 0 , "0" , 0 , 987 );
			break;
		end;	
	end;
end;

function Objective()
	GiveObjective ( 0 );
end;

------------------------WIn_Loose

function Unlucky()
	while 1 do
		Wait( 3 );
        if ( GetNUnitsInParty( 0 ) < 1 ) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
			FailObjective( 0 );
			Wait( 3 );
			Win( 1 );
			break;
		end;
	end;
end;

function Unlucky1()
	while 1 do
		Wait( 3 );
        if IsSomeUnitInArea ( 0 , 'Visota', 0 ) < 1 and IsSomeUnitInArea ( 1 , 'Visota', 0 ) > 0 then
			Wait( 30 );
			if IsSomeUnitInArea ( 0 , 'Visota', 0 ) < 1 and IsSomeUnitInArea ( 1 , 'Visota', 0 ) > 0 then
				FailObjective( 0 );
				Wait( 3 );
				Win( 1 );
				break;
			end;
		end;
	end;
end;

-------------------------------------------  MAIN

StartThread( Damage );
StartThread( SecretObj );
StartThread( Objective );

StartThread( GerAtacks );
StartThread( GerHQAtacks );

StartThread( AAGun300 );
StartThread( AAGun301 );

StartThread( Unlucky );
StartThread( Unlucky1 );

Wait ( 180 + Random ( 100 ));
LandReinforcementFromMap ( 1 , "6" , 0 , 888 );
Cmd ( ACT_UNLOAD , 888 , 0 , "Para" );