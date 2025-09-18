--PlayEffect( 0 , GetScriptObjCoord ( 1 ) , 0 );

COBJ = 0;
COBJ2 = 0;

-----------------------Contratack

function Contratack1()
	Wait (60);
	LandReinforcementFromMap ( 1 , "T34" , 0 , 200);
	Cmd ( 3 , 200 , 0 ,  GetScriptAreaParams "Alies11" );
	QCmd ( 3 , 200 , 0 ,  GetScriptAreaParams "Alies13" );
	QCmd ( 3 , 200 , 0 ,  GetScriptAreaParams "Alies10" );
	QCmd ( 3 , 200 , 0 ,  GetScriptAreaParams "Alies3" );
	QCmd ( 3 , 200 , 0 ,  GetScriptAreaParams "Alies5" );
	QCmd ( 3 , 200 , 0 ,  GetScriptAreaParams "Vilage" );
	Wait (30);
	LandReinforcementFromMap ( 1 , "T34" , 0 , 201);
	Cmd ( 3 , 201 , 0 ,  GetScriptAreaParams "Alies12" );
	QCmd ( 3 , 201 , 0 ,  GetScriptAreaParams "Alies4" );
	QCmd ( 3 , 201 , 0 ,  GetScriptAreaParams "Alies2" );
	QCmd ( 3 , 201 , 0 ,  GetScriptAreaParams "Vilage" );
end;

-----------------------Alies
function Alies1()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 4 , 'Alies1', 0 ) > 0 then
			ChangePlayerForScriptGroup( 4 , 0 );
			break;
		end;	
	end;
end;
function Alies2()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies2', 0 ) > 0 then
			ChangePlayerForScriptGroup( 3 , 0 );
			break;
		end;	
	end;
end;
function Alies3()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies3', 0 ) > 0 then
			ChangePlayerForScriptGroup( 5 , 0 );
			break;
		end;	
	end;
end;
function Alies4()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies4', 0 ) > 0 then
			ChangePlayerForScriptGroup( 6 , 0 );
			break;
		end;	
	end;
end;
function Alies5()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies5', 0 ) > 0 then
			ChangePlayerForScriptGroup( 1 , 0 );
			break;
		end;	
	end;
end;
function Alies10()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies10', 0 ) > 0 then
			ChangePlayerForScriptGroup( 10 , 0 );
			break;
		end;	
	end;
end;
function Alies11()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies11', 0 ) > 0 then
			ChangePlayerForScriptGroup( 11 , 0 );
			break;
		end;	
	end;
end;
function Alies12()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies12', 0 ) > 0 then
			ChangePlayerForScriptGroup( 12 , 0 );
			break;
		end;	
	end;
end;
function Alies13()
	while 1 do
		Wait( 1 );
		if GetNScriptUnitsInArea ( 100 , 'Alies13', 0 ) > 0 then
			ChangePlayerForScriptGroup( 13 , 0 );
			break;
		end;	
	end;
end;



-----------------------Objective

function Objective()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Vilage', 0 ) > 0 and IsSomeUnitInArea ( 1 , 'Vilage', 0 ) < 1 then
			CompleteObjective ( 0 );
			StartThread( Objective2 );
			COBJ = 1;
			break;
		end;	
	end;
end;
function Objective2()
	Wait ( 2 );
	GiveObjective ( 1 );
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Vilage2', 0 ) > 0 and IsSomeUnitInArea ( 1 , 'Vilage2', 0 ) < 1 then
			CompleteObjective ( 1 );
			COBJ2 = 1;
			break;
		end;	
	end;
end;

-----------------------WinLoose

function Winner()
	while 1 do
		Wait( 1 );
		if COBJ2 + COBJ  == 2 then
			Win(0);
			break;
		end;
	end;
end;
function Unlucky()
	while 1 do
		Wait( 1 );
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

-----------------------Start

GiveObjective ( 0 );

StartThread( Alies1 );
StartThread( Alies2 );
StartThread( Alies3 );
StartThread( Alies4 );
StartThread( Alies5 );
StartThread( Alies10 );
StartThread( Alies11 );
StartThread( Alies12 );
StartThread( Alies13 );


StartThread( Objective );

StartThread( Winner );
StartThread( Unlucky );

StartThread( Contratack1 );