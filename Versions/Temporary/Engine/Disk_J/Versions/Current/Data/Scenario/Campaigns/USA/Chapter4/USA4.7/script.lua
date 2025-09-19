CO1 = 0;
CO2 = 0;
CO3 = 0;

-----------------------Fighters
function Fighters()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInParty ( 0 ) > 0 then
			StartThread ( Fighters1 );
			break;
		end;	
	end;
end;

function Fighters1()
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 200 );
	Cmd ( 3 , 200 , 500 , 5739 , 2750 );
	Wait ( 10 );
	LandReinforcementFromMap ( 2 , "1" , 0 , 201 );
	Cmd ( 3 , 201 , 500 , 5739 , 2750 );
	Wait ( 40 );
	StartThread ( Fighters );
end;


-----------------------Objective

function Objective()
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 101 ) < 1 then
			CompleteObjective ( 0 );
			CO1 = 1;
			LandReinforcementFromMap ( 2 , "0" , 0 , 301 );
			Cmd ( 0 , 301 , 0 , 2594 , 7046 );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;

function Objective1()
	GiveObjective ( 1 );
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 102 ) < 1 then
			CompleteObjective ( 1 );
			CO2 = 1;
			LandReinforcementFromMap ( 2 , "0" , 0 , 302 );
			Cmd ( 0 , 302 , 0 , 578 , 1511 );
			StartThread( Objective2 );
			break;
		end;	
	end;
end;

function Objective2()
	GiveObjective ( 2 );
	while 1 do
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 103 ) < 1 then
			CompleteObjective ( 2 );
			LandReinforcementFromMap ( 2 , "0" , 0 , 303 );
			Cmd ( 0 , 303 , 0 , 5739 , 2750 );
			Wait ( 30 );
			CO3 = 1;
			break;
		end;	
	end;
end;

-----------------------WinLoose
function Winner()
	while 1 do
		Wait( 1 );
        if CO3+CO2+CO1 == 3 then
			Win ( 0 );
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

StartThread( Fighters );
StartThread( Objective );
StartThread( Unlucky );
StartThread( Winner );