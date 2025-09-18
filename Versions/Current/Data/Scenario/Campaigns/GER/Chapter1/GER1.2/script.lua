n = 1;
nom = {};
nom [1] = "1"; nom [2] = "2"; nom [3] = "3";
z = 1;
n1 = 1;
nom1 = {};
nom1 [1] = "1"; nom1 [2] = "2"; nom1 [3] = "3";
z1 = 1;
R1 = 0; R2 = 0;
Dom = GetScriptObjectHPs ( 300 );
Dom1 = GetScriptObjectHPs ( 302 );
H39 = 0;
flagok1 = 100;
flagok2 = 100;

-----------------------Out


function Out1()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Out2', 0 ) > 0 then
			Wait( 1 );
			Cmd (7 , 305 , 0 , GetScriptAreaParams "Shtab");
			Cmd (7 , 306 , 0 , GetScriptAreaParams "Shtab");
			break;
		end;
	end;
end;

function OutRight()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'OutRight', 0 ) > 0 then
			Wait( 1 );
			Cmd (7 , 1000 , 0 , GetScriptAreaParams "OutRight");
			break;
		end;
	end;
end;

function OutWind()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Windermill', 0 ) > 0 then
			Wait( 1 );
			Cmd (7 , 1001 , 0 , GetScriptAreaParams "Windermill");
			break;
		end;
	end;
end;

-------------------------------------------Recon

function Recon()
 	while 1 do 
		Wait( 20 + Random( 10 )); 
		if IsSomeBodyAlive ( 0 , 802 ) < 1 then 
			LandReinforcementFromMap (  0 , "0" , 0 , 802 );
			Cmd ( 0 , 802 , 0 , GetScriptAreaParams "Recon" );
			Wait ( 1 );
 		end;
	end;
end;

-----------------------Flag

function Flag2()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 0 , 'Windermill', 0 ) > 0 and IsSomeUnitInArea ( 1 , 'Windermill', 0 ) < 1 then
			flagok2 = 0;
			break;
		end;
	end;
end;

-----------------------Reinforcement

function Atack()
	while 1 do
		Wait( 90 + Random ( 90));
		if (GetNUnitsInArea ( 0 , "R1" , 0 ) < 1 ) then
			LandReinforcementFromMap ( 1 , "2" , 2 , 2000 );
			Cmd ( 3 , 2000 , 100 , "GerHQ" );
		end;
	end;
end; 

function Reinforcement0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea ( 0 , "R1" , 0 ) > 0 ) then
			StartThread( Reinforcement1 );
			Wait ( 10 );
			break;
		end;
	end;
end; 

function Reinforcement1()
	Wait ( 10 );
	if flagok2 > 0 then
		Wait ( 1 );
		n1 = Random ( 2 );
		if GetNUnitsInScriptGroup ( 100+z1 , 1 ) < 6 then
			LandReinforcementFromMap ( 1 , nom[n1] , 1 , 200 + z1);
			Cmd ( 3 , 200 + z1 , 0 , 4092 , 4587 );
			z1 = z1 + 1;
			Sleep ( 1 );
		end;
		StartThread( Waiting2 );
	end;
end;

-----------------------Waiting 

function Waiting2()
	Wait ( 30 + Random ( 60) );
	StartThread( Reinforcement1 );
end; 

-----------------------Objective 

function Objective()
	GiveObjective ( 0 );
	StartThread( CompleteObjective0 );
end; 

function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Shtab" , 0 ) < 1 and IsSomeUnitInArea ( 0 , "Shtab" , 0 ) > 0 then
			CompleteObjective ( 0 );
			Wait ( 5 );
			Win ( 0 );
			break;
		end;	
	end;
end;

function SOObjective()
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Sklad" , 0 ) < 1 and IsSomeUnitInArea ( 0 , "Sklad" , 0 ) > 0 then
--			ObjectiveChanged(0, 2);
			Sleep ( 1 );
			ObjectiveChanged(1, 2);
			break;
		end;	
	end;
end; 

------------------------WIn_Loose

function Unlucky1()
	while 1 do
		Wait( 1 );
		if (GetNUnitsInParty(1) == GetNUnitsInArea ( 1 , "Shtab" , 0 )) then
			Wait( 1 );
			Win(0);
			break;
		end;
	end;
end; 

function Unlucky()
	while 1 do
		Wait( 1 );
        if (( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

-------------------------------------------  AIR

function Fighter()
	while 1 do
		Wait( 1 );
        if GetNUnitsInArea ( 0 , "Air" , 1 ) > 1 then
			LandReinforcementFromMap ( 1 , "4" , 2 , 2333 );
			Cmd ( 3 , 2333 , 0 , "GerHQ" );
			break;
		end;
	end;
end;

function GAP()
	while 1 do
		Wait( 1 );
        if GetNUnitsInArea ( 0 , "R1" , 0 ) > 1 then
			LandReinforcementFromMap ( 1 , "0" , 2 , 2334 );
			Cmd ( 3 , 2334 , 0 , "R1" );
			break;
		end;
	end;
end;

-------------------------------------------  MAIN

StartThread( Unlucky );
StartThread( Unlucky1 );
StartThread( Objective );
StartThread( SOObjective );
StartThread( Out1 );
StartThread( OutRight );
StartThread( OutWind );
StartThread( Flag2 );
StartThread( Reinforcement0 );
StartThread( Recon );
StartThread( Atack );
Wait ( 1 );
if GetDifficultyLevel() == 1 then
	StartThread( Fighter );
end;
if GetDifficultyLevel() == 2 then
	StartThread( Fighter );
	StartThread( GAP );
end;