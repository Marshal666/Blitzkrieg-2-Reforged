OBJ = 0;
OBJ1 = 0;
OBJ2 = 0;

----------------------------------------------SecondAttack****

function SecondAttack()
	LandReinforcementFromMap ( 1 , "0" , 4 , 2020 );
	Cmd ( 3 , 2020 , 0 , GetScriptAreaParams"Tank1" );
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "0" , 4, 2021 );
	Cmd ( 3 , 2021 , 0 , GetScriptAreaParams"Tank2" );
	Wait ( 15 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 2023 );
	Cmd ( 3 , 2023 , 0 , GetScriptAreaParams"Tank1" );
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 2024 );
	Cmd ( 3 , 2024 , 0 , GetScriptAreaParams"Tank2" );
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 2025 );
	Cmd ( 3 , 2025 , 0 , GetScriptAreaParams"Tank3" );
	Wait ( 20 );
	LandReinforcementFromMap ( 1 , "6" , 4 , 2026 );
	Cmd ( 3 , 2026 , 0 , GetScriptAreaParams"Tank1" );
	Wait ( 90 );
	while 1 do
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , "Zone02" , 0 ) < 1 then
			OBJ1 = 1;
			CompleteObjective ( 1 );
			Wait ( 2 );
			StartThread ( Objective2 );
			break;
		end;	
	end;
end;

----------------------------------------------Retriat****

function Paradrop()
	LandReinforcementFromMap ( 1 , "3" , 11 , 180 );
	LandReinforcementFromMap ( 1 , "3" , 12 , 181 );
	LandReinforcementFromMap ( 1 , "5" , 6 , 170 );
	Cmd ( 3 , 170 , 0 , "zone2" );
	Wait ( 1 );
	LandReinforcementFromMap ( 1 , "8" , 0 , 172 );
	Cmd ( 5 , 172 , 0 , "zone1" );
	LandReinforcementFromMap ( 1 , "12" , 0 , 2002 );
	LandReinforcementFromMap ( 1 , "12" , 6 , 2002 );
	LandReinforcementFromMap ( 1 , "12" , 5 , 2002 );
	Cmd ( 3 , 2002 , 0 , "zone1" );
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "1" , 0 , 2001 );
	LandReinforcementFromMap ( 1 , "1" , 6 , 2001 );
	LandReinforcementFromMap ( 1 , "1" , 5 , 2001 );
	Cmd ( 3 , 2001 , 0 , "zone1" );
	if IsSomeUnitInArea ( 0 , "Zone01", 0 ) > 0 then
		LandReinforcementFromMap ( 1 , "9" , 6 , 171 );
		Cmd ( 3 , 171 , 0 , "Forvard1" );
	end;
	Wait ( 25 );
	LandReinforcementFromMap ( 1 , "5" , 0 , 173 );
	Cmd ( 3 , 173 , 0 , "zone1" );
	if IsSomeUnitInArea ( 0 , "Zone01", 0 ) > 0 then
		LandReinforcementFromMap ( 1 , "9" , 5 , 182 );
		Cmd ( 3 , 182 , 0 , "Forvard0" );
	end;
	Wait ( 25 );
	Cmd ( 3 , 172 , 0 , "Zone02" );
	StartThread (SecondAttack);
end;

----------------------------------------------Eva****

function Evacuation()
	while 1 do
		TruckN1 = IsSomeBodyAlive ( 2 , 600 ) + IsSomeBodyAlive ( 2 , 599 ) + IsSomeBodyAlive ( 2 , 598 ) + IsSomeBodyAlive ( 2 , 597 );
		Wait( 1 );
		if TruckN1 == 0 then
			Wait ( 2 );
			Cmd ( 0 , 596 , 0 , "Sea10" );
			QCmd ( 1007 , 596 );
			Wait ( 60 );
			LandReinforcementFromMap ( 2 , "5" , 4 , 596 );
			Cmd ( 0 , 596 , 0 , "Sea00" );
			QCmd ( 8 , 596 , 0 , "Flee" );
			QCmd ( 50 , 596 );
			break;
		end;	
	end;
end;

function EvacuationSecond()
	Wait ( 20 );
	LandReinforcementFromMap ( 2 , "2" , 3 , 165 );
	Cmd ( 0 , 165 , 0 , "Eva1" );
	QCmd ( 0 , 165 , 0 , "Eva2" );
	QCmd ( 0 , 165 , 0 , "Eva3" );
	QCmd ( 0 , 165 , 0 , "164" );
	QCmd ( 0 , 165 , 0 , "165" );
	Wait ( 5 );
	LandReinforcementFromMap ( 2 , "2" , 3 , 164 );
	Cmd ( 0 , 164 , 0 , "Eva1" );
	QCmd ( 0 , 164 , 0 , "Eva2" );
	QCmd ( 0 , 164 , 0 , "Eva3" );
	QCmd ( 0 , 164 , 0 , "164" );
	Wait ( 15 );
	Cmd ( 0 , 163 , 0 , "to35" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "163" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "to35" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "163" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "to35" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "163" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "to35" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "163" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "to35" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "163" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 0 , 163 , 0 , "to35" );
	QCmd ( 105 , 163 , 3 );
	QCmd ( 4 , 163 , 165 );
	Wait ( 3 );
	Cmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "162" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "162" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "162" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "162" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "162" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "162" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 0 , 162 , 0 , "to24" );
	QCmd ( 105 , 162 , 3 );
	QCmd ( 4 , 162 , 164 );
	Wait ( 60 );
	LandReinforcementFromMap ( 2 , "2" , 3 , 166 );
	Cmd ( 0 , 166 , 0 , "Eva1" );
	QCmd ( 0 , 166 , 0 , "Eva2" );
	QCmd ( 0 , 166 , 0 , "Support15" );
	QCmd ( 0 , 166 , 0 , "Support1" );
	QCmd ( 0 , 166 , 0 , "zone2" );
	QCmd ( 0 , 166 , 0 , "OBJ" );
	QCmd ( 0 , 166 , 0 , "Support4" );
	QCmd ( 0 , 166 , 0 , "Support5" );
	QCmd ( 0 , 166 , 0 , "Flee" );
	QCmd ( 1007 , 166 );
	Wait ( 4 );
	LandReinforcementFromMap ( 2 , "2" , 3 , 167 );
	Cmd ( 0 , 167 , 0 , "Eva1" );
	QCmd ( 0 , 167 , 0 , "Eva2" );
	QCmd ( 0 , 167 , 0 , "Support15" );
	QCmd ( 0 , 167 , 0 , "Support1" );
	QCmd ( 0 , 167 , 0 , "zone2" );
	QCmd ( 0 , 167 , 0 , "OBJ" );
	QCmd ( 0 , 167 , 0 , "Support4" );
	QCmd ( 0 , 167 , 0 , "Support5" );
	QCmd ( 0 , 167 , 0 , "Flee" );
	QCmd ( 1007 , 167 );
	Wait ( 14 );
	QCmd ( 0 , 164 , 0 , "Support15" );
	QCmd ( 0 , 164 , 0 , "Support1" );
	QCmd ( 0 , 164 , 0 , "zone2" );
	QCmd ( 0 , 164 , 0 , "OBJ" );
	QCmd ( 0 , 164 , 0 , "Support4" );
	QCmd ( 0 , 164 , 0 , "Support5" );
	QCmd ( 0 , 164 , 0 , "Flee" );
	QCmd ( 1007 , 164 );
	Wait ( 2 );
	QCmd ( 0 , 165 , 0 , "Support15" );
	QCmd ( 0 , 165 , 0 , "Support1" );
	QCmd ( 0 , 165 , 0 , "zone2" );
	QCmd ( 0 , 165 , 0 , "OBJ" );
	QCmd ( 0 , 165 , 0 , "Support4" );
	QCmd ( 0 , 165 , 0 , "Support5" );
	QCmd ( 0 , 165 , 0 , "Flee" );
	QCmd ( 1007 , 165 );
	Wait ( 8 );
	DamageScriptObject ( 161 , 100 );
	Wait ( 1 );
	DamageScriptObject ( 160 , 700 );
	Wait ( 15 );
	TruckN2 = IsSomeBodyAlive ( 2 , 164 ) + IsSomeBodyAlive ( 2 , 165 ) + IsSomeBodyAlive ( 2 , 166 ) + IsSomeBodyAlive ( 2 , 167 );
	if TruckN2 < 4 then
		Win ( 1 );
	else
		CompleteObjective ( 0 );
		OBJ = 1;
		Wait ( 2 );
		StartThread (Objective1);
	end;
	while 1 do
		Wait( 1 );
		TruckN2 = IsSomeBodyAlive ( 2 , 164 ) + IsSomeBodyAlive ( 2 , 165 ) + IsSomeBodyAlive ( 2 , 166 ) + IsSomeBodyAlive ( 2 , 167 );
		if TruckN2 == 0 then
			Wait ( 2 );
			Cmd ( 0 , 596 , 0 , "Sea10" );
			QCmd ( 1007 , 596 );
			Wait ( 60 );
			LandReinforcementFromMap ( 2 , "5" , 4 , 596 );
			Cmd ( 0 , 596 , 0 , "Sea00" );
			QCmd ( 8 , 596 , 0 , "Flee" );
			QCmd ( 50 , 596 );
			break;
		end;	
	end;
end;

----------------------------------------------ContrAtack

function NoCA()
	while 1 do 
		Wait( 10 );
        if GetNUnitsInArea ( 0 , 'Zone001', 0 ) > GetNUnitsInArea ( 1 , 'Zone001', 0 ) then
			Wait ( 15 );
			LandReinforcementFromMap ( 1 , "6" , 10 , 5550 );
			Cmd ( 0 , 5550 , 0 , "Zone001" );
			if GetNUnitsInArea ( 0 , 'Zone001', 0 ) > GetNUnitsInArea ( 1 , 'Zone001', 0 ) then
				Wait ( 15 );
				LandReinforcementFromMap ( 1 , "6" , 10 , 5550 );
				Cmd ( 0 , 5550 , 0 , "Zone001" );
				Wait ( 20 );
			end;
		end;
 	end;
end

----------------------------------------------JapanLanding

function JapanLanding1()
	LandReinforcementFromMap ( 1 , "10" , 8 , 5000 );
	Cmd ( 0 , 5000 , 0 , "Boat1" );
	while 1 do 
		Wait( 1 );
        if IsSomeUnitInArea ( 1 , 'Boat1', 0 ) > 0 then
			Wait ( 1 );
			LandReinforcementFromMap ( 1 , "11" , 9 , 5001 );
			Cmd ( 0 , 5001 , 0 , GetScriptAreaParams"At1" );
			ChangeFormation ( 5001 , 3 );
			Wait ( 1 );
			LandReinforcementFromMap ( 1 , "11" , 9 , 5002 );
			Cmd ( 0 , 5002 , 0 , GetScriptAreaParams"At2" );
			ChangeFormation ( 1002 , 3 );
			Wait ( 1 );
			LandReinforcementFromMap ( 1 , "11" , 9 , 5003 );
			Cmd ( 0 , 5003 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1003 , 3 );
			Wait ( 1 );
			Cmd ( 0 , 5000 , 0 , "Sea1" );
			QCmd ( 1007 , 5000 );
 			break; 
		end;
 	end;
end;

function SecondAtack()
	Trace ("GO!");
	LandReinforcementFromMap ( 2 , "4" , 0 , 550 );
	Cmd ( 0 , 550 , 100 , "AAGun");
	QCmd ( 50 , 550 );
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "9" , 4 , 2003 );
	Cmd ( 3 , 2003 , 0 , "Tank2");
	LandReinforcementFromMap ( 1 , "0" , 4 , 2000 );
	Cmd ( 0 , 2000 , 0 , "zone0");
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 2001 );
	Cmd ( 0 , 2001 , 0 , "zone1");
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "0" , 4 , 2002 );
	Cmd ( 0 , 2002 , 0 , "zone2");
	Wait ( 5 );
	Cmd ( 3 , 2000 , 0 , "Tank3");
	Cmd ( 3 , 2001 , 0 , "Tank2");
	Cmd ( 3 , 2002 , 0 , "Mine1");
	Wait ( 10 );
	StartThread (Paradrop2);
	Wait ( 20 );
	LandReinforcementFromMap ( 1 , "6" , 4 , 2004 );
	Cmd ( 0 , 2004 , 0 , "zone0");
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "1" , 4 , 2005 );
	Cmd ( 0 , 2005 , 0 , "zone1");
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "6" , 4 , 2006 );
	Cmd ( 0 , 2006 , 0 , "zone2");
	Wait ( 5 );
	Cmd ( 3 , 2004 , 0 , "Tank3");
	Cmd ( 3 , 2005 , 0 , "Tank2");
	Cmd ( 3 , 2006 , 0 , "Mine1");
	Wait ( 10 )
	StartThread (CompleteObjective1);	
end;

function Paradrop2()
	LandReinforcementFromMap ( 1 , "8" , 6 , 2200 );
	Cmd ( 5 , 2200 , 0 , "AAGun" );
	LandReinforcementFromMap ( 1 , "8" , 6 , 2201 );
	Cmd ( 5 , 2201 , 0 , "Art1" );
end;

function AnyPrice1()
	while 1 do
		if IsSomeUnitInArea ( 1 , "Zone01" , 0 ) < 1 and IsSomeUnitInArea ( 0 , "Zone01" , 0 ) > 0 then
			LandReinforcementFromMap ( 1 , "6" , 0 , 2100 );
			Cmd ( 3 , 2100 , 0 , "Left12" );
			LandReinforcementFromMap ( 1 , "6" , 5 , 2101 );
			Cmd ( 3 , 2101 , 0 , "Left11" );
			Wait ( 3 );
			LandReinforcementFromMap ( 1 , "7" , 6 , 2102 );
			Cmd ( 3 , 2102 , 0 , "Support3" );
			QCmd ( 3 , 2102 , 0 , "Zone01" );
			Wait ( 10 );
			LandReinforcementFromMap ( 1 , "1" , 6 , 2103 );
			Cmd ( 3 , 2103 , 0 , "Zone01" );
			QCmd ( 3 , 2103 , 0 , "zone1" );
			Wait( 30 );
		else
			StartThread (AnyPrice2);
			break;
		end;	
	end;
end;

function AnyPrice2()
	while 1 do
		if IsSomeUnitInArea ( 1 , "Zone001" , 0 ) < 1 then
			LandReinforcementFromMap ( 1 , "1" , 6 , 2113 );
			Cmd ( 3 , 2113 , 0 , "zone1" );
			LandReinforcementFromMap ( 1 , "6" , 0 , 2110 );
			Cmd ( 3 , 2110 , 0 , "zone0" );
			LandReinforcementFromMap ( 1 , "6" , 5 , 2111 );
			Cmd ( 3 , 2111 , 0 , "zone2" );
			Wait ( 3 );
			LandReinforcementFromMap ( 1 , "7" , 6 , 2112 );
			Cmd ( 3 , 2112 , 0 , "zone1" );
			Wait( 50 );
		else
			StartThread (SecondAtack);
			break;
		end;	
	end;
end;

function EvacuationPriest()
	while 1 do
		TruckN2 = IsSomeBodyAlive ( 2 , 3001 ) + IsSomeBodyAlive ( 2 , 3002 ) + IsSomeBodyAlive ( 2 , 3003 ) + IsSomeBodyAlive ( 2 , 3004 );
		Wait( 1 );
		if TruckN2 == 0 then
			Wait ( 2 );
--			Cmd ( 0 , 596 , 0 , "Sea1" );
			Cmd ( 0 , 596 , 0 , "Sea10" );
			QCmd ( 1007 , 596 );
			Wait ( 60 );
			LandReinforcementFromMap ( 2 , "5" , 4 , 596 );
--			Cmd ( 0 , 596 , 0 , "Sea1" );
			Cmd ( 0 , 596 , 0 , "Sea00" );
			QCmd ( 8 , 596 , 0 , "Flee" );
			QCmd ( 50 , 596 );
			break;
		end;	
	end;
end;

---------------------------------------------------------JapanLanding

function JapanAtak01()
	LandReinforcementFromMap ( 1 , "4" , 3 , 999 );
	Cmd ( 0 , 999 , 0 , GetScriptAreaParams"FArt" );
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "4" , 1 , 998 );
	Cmd ( 0 , 998 , 0 , GetScriptAreaParams"Left2" );
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "4" , 7 , 997 );
	Cmd ( 0 , 997 , 0 , GetScriptAreaParams"Left8" );
	Wait ( 5 );
end;

function JapanAtak1()
	LandReinforcementFromMap ( 1 , "0" , 1 , 1000 );
--	LandReinforcementFromMap ( 1 , "0" , 3 , 1001 );
	LandReinforcementFromMap ( 1 , "0" , 7 , 1002 );
	Cmd ( 3 , 1000 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 3 , 1001 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 3 , 1002 , 0 , GetScriptAreaParams"Left7" );
	Wait ( 25 );
--	LandReinforcementFromMap ( 1 , "6" , 1 , 1006 );
	LandReinforcementFromMap ( 1 , "6" , 3 , 1007 );
	LandReinforcementFromMap ( 1 , "6" , 7 , 1008 );
	Cmd ( 3 , 1006 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 3 , 1007 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 3 , 1008 , 0 , GetScriptAreaParams"Left7" );
	Wait ( 25 );
	LandReinforcementFromMap ( 1 , "6" , 1 , 1009 );
	LandReinforcementFromMap ( 1 , "6" , 3 , 1010 );
	LandReinforcementFromMap ( 1 , "6" , 7 , 1011 );
	Cmd ( 0 , 1009 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 0 , 1010 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 0 , 1011 , 0 , GetScriptAreaParams"Left7" );
	Wait ( 40 );
	LandReinforcementFromMap ( 1 , "1" , 1 , 1003 );
	LandReinforcementFromMap ( 1 , "1" , 3 , 1004 );
	LandReinforcementFromMap ( 1 , "1" , 7 , 1005 );
	Cmd ( 0 , 1003 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 0 , 1004 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 0 , 1005 , 0 , GetScriptAreaParams"Left7" );
	Cmd ( 3 , 1000 , 0 , GetScriptAreaParams"Left2" );
	Cmd ( 3 , 1001 , 0 , GetScriptAreaParams"Left4" );
	Cmd ( 3 , 1002 , 0 , GetScriptAreaParams"Left8" );
	Cmd ( 3 , 1006 , 0 , GetScriptAreaParams"Left2" );
	Cmd ( 3 , 1007 , 0 , GetScriptAreaParams"Left4" );
	Cmd ( 3 , 1008 , 0 , GetScriptAreaParams"Left8" );
	Wait ( 30 );
	Cmd ( 3 , 1009 , 0 , GetScriptAreaParams"Left2" );
	Cmd ( 3 , 1010 , 0 , GetScriptAreaParams"Left4" );
	Cmd ( 3 , 1011 , 0 , GetScriptAreaParams"Left8" );
	Wait ( 15 );
	Cmd ( 0 , 1003 , 0 , GetScriptAreaParams"Left25" );
	Cmd ( 0 , 1004 , 0 , GetScriptAreaParams"Left5" );
	Cmd ( 0 , 1005 , 0 , GetScriptAreaParams"Left9" );
	Wait ( 3 );
end;

function JapanAtak11()
	LandReinforcementFromMap ( 1 , "0" , 1 , 1000 );
	LandReinforcementFromMap ( 1 , "0" , 3 , 1001 );
	LandReinforcementFromMap ( 1 , "0" , 7 , 1002 );
	Cmd ( 3 , 1000 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 3 , 1001 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 3 , 1002 , 0 , GetScriptAreaParams"Left7" );
	Wait ( 20 );
	LandReinforcementFromMap ( 1 , "6" , 1 , 1006 );
	LandReinforcementFromMap ( 1 , "6" , 3 , 1007 );
	LandReinforcementFromMap ( 1 , "6" , 7 , 1008 );
	Cmd ( 3 , 1006 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 3 , 1007 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 3 , 1008 , 0 , GetScriptAreaParams"Left7" );
	Wait ( 35 );
	LandReinforcementFromMap ( 1 , "1" , 1 , 1003 );
	LandReinforcementFromMap ( 1 , "1" , 3 , 1004 );
	LandReinforcementFromMap ( 1 , "1" , 7 , 1005 );
	Cmd ( 0 , 1003 , 0 , GetScriptAreaParams"Left1" );
	Cmd ( 0 , 1004 , 0 , GetScriptAreaParams"Left3" );
	Cmd ( 0 , 1005 , 0 , GetScriptAreaParams"Left7" );
	Cmd ( 3 , 1000 , 0 , GetScriptAreaParams"Left2" );
	Cmd ( 3 , 1001 , 0 , GetScriptAreaParams"Left4" );
	Cmd ( 3 , 1002 , 0 , GetScriptAreaParams"Left8" );
	Cmd ( 3 , 1006 , 0 , GetScriptAreaParams"Left2" );
	Cmd ( 3 , 1007 , 0 , GetScriptAreaParams"Left4" );
	Cmd ( 3 , 1008 , 0 , GetScriptAreaParams"Left8" );
	Wait ( 40 );
	Cmd ( 0 , 1003 , 0 , GetScriptAreaParams"Left25" );
	Cmd ( 0 , 1004 , 0 , GetScriptAreaParams"Left5" );
	Cmd ( 0 , 1005 , 0 , GetScriptAreaParams"Left9" );
	Wait ( 3 );
end;

function Player1()
	StartThread (JapanAtak1);
	StartThread (JapanAtak01);
	Wait ( 60 );
	StartThread (JapanLanding1);
	Wait ( 80 );
	StartThread (JapanAtak11);
	Wait ( 90 );
	StartThread (CompleteObjective2);
end;

function Player()
	StartThread (JapanAtak21);
	Wait ( 60 );
	StartThread (JapanAtak21);
	Wait ( 60 );
	StartThread (JapanAtak21);
	Wait ( 50 );
	StartThread (JapanAtak3);
	Wait ( 30 );
	StartThread (JapanAtak21);
end;

function Player2()
	StartThread (JapanAtak21);
	Wait ( 30 );
	StartThread (JapanAtak21);
	Wait ( 30 );
	StartThread (JapanAtak3);
	Wait ( 120 );
	StartThread (JapanAtak2);
end;

function JapanAtak2()
	Cmd ( 3 , 2000 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2000 , 0 , GetScriptAreaParams"zone0" );
	QCmd ( 3 , 2000 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2001 , 0 , GetScriptAreaParams"Left11" );
	QCmd ( 3 , 2001 , 0 , GetScriptAreaParams"zone2" );
	QCmd ( 3 , 2001 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2003 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2003 , 0 , GetScriptAreaParams"zone0" );
	QCmd ( 3 , 2003 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2004 , 0 , GetScriptAreaParams"Left11" );
	QCmd ( 3 , 2004 , 0 , GetScriptAreaParams"zone2" );
	QCmd ( 3 , 2004 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2005 , 0 , GetScriptAreaParams"Left14" );
	QCmd ( 3 , 2005 , 0 , GetScriptAreaParams"zone1" );
	QCmd ( 3 , 2005 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2006 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2006 , 0 , GetScriptAreaParams"zone0" );
	QCmd ( 3 , 2006 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2007 , 0 , GetScriptAreaParams"Left11" );
	QCmd ( 3 , 2007 , 0 , GetScriptAreaParams"zone2" );
	QCmd ( 3 , 2007 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2008 , 0 , GetScriptAreaParams"Left14" );
	QCmd ( 3 , 2008 , 0 , GetScriptAreaParams"zone1" );
	QCmd ( 3 , 2008 , 0 , GetScriptAreaParams"OBJ" );
	Cmd ( 3 , 2010 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2010 , 0 , GetScriptAreaParams"zone0" );
	QCmd ( 3 , 2010 , 0 , GetScriptAreaParams"OBJ" );
end;

function JapanAtak21()
	LandReinforcementFromMap ( 1 , "0" , 0 , 2000 );
	Cmd ( 3 , 2000 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2000 , 0 , GetScriptAreaParams"zone0" );
	Wait ( 7);
	LandReinforcementFromMap ( 1 , "0" , 0 , 2003 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 2004 );
	Cmd ( 3 , 2003 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2003 , 0 , GetScriptAreaParams"zone0" );
	Cmd ( 3 , 2004 , 0 , GetScriptAreaParams"Left11" );
	QCmd ( 3 , 2004 , 0 , GetScriptAreaParams"zone2" );
	Wait ( 8 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 2006 );
	LandReinforcementFromMap ( 1 , "0" , 0 , 2007 );
	Cmd ( 3 , 2006 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2006 , 0 , GetScriptAreaParams"zone0" );
	Cmd ( 3 , 2007 , 0 , GetScriptAreaParams"Left11" );
	QCmd ( 3 , 2007 , 0 , GetScriptAreaParams"zone2" );
	LandReinforcementFromMap ( 1 , "0" , 0 , 2010 );
	Cmd ( 3 , 2010 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2010 , 0 , GetScriptAreaParams"zone0" );
end;

function JapanAtak3()
	LandReinforcementFromMap ( 1 , "0" , 0 , 2009 );
	Cmd ( 3 , 2009 , 0 , GetScriptAreaParams"Left12" );
	QCmd ( 3 , 2009 , 0 , GetScriptAreaParams"zone0" );
	QCmd ( 3 , 2009 , 0 , GetScriptAreaParams"OBJ" );
	Wait ( 15 );
	LandReinforcementFromMap ( 1 , "1" , 0 , 2011 );
	Cmd ( 3 , 2011 , 0 , GetScriptAreaParams"Left11" );
	QCmd ( 3 , 2011 , 0 , GetScriptAreaParams"zone2" );
	QCmd ( 3 , 2011 , 0 , GetScriptAreaParams"OBJ" );
	Wait ( 3 );
	LandReinforcementFromMap ( 1 , "1" , 0 , 2012 );
	Cmd ( 3 , 2012 , 0 , GetScriptAreaParams"Left14" );
	QCmd ( 3 , 2012 , 0 , GetScriptAreaParams"zone1" );
	QCmd ( 3 , 2012 , 0 , GetScriptAreaParams"OBJ" );
end;

function JapanArt()
	Wait ( 10 );
	LandReinforcementFromMap ( 1 , "3" , 1 , 1003 );
	LandReinforcementFromMap ( 1 , "3" , 3 , 1004 );
end;

function Support()
	LandReinforcementFromMap ( 2 , "2" , 2 , 3000 );
	Cmd ( 0 , 3000 , 0 , "Support1");
	QCmd ( 0 , 3000 , 0 , "Support2");
	QCmd ( 23 , 3000 , 0 , "Support2");
	Wait ( 100 );
	Cmd ( 0 , 3000 , 0 , "Support1");
	QCmd ( 0 , 3000 , 0 , "OBJ");
	QCmd ( 0 , 3000 , 0 , "Flee");
	QCmd ( 1007 , 3000 );
end;

function Support1()
	LandReinforcementFromMap ( 2 , "2" , 0 , 3030 );
	Cmd ( 0 , 3030 , 0 , "Tank2");
	QCmd ( 23 , 3030 , 0 , "Tank2");
	Wait ( 70 );
	Cmd ( 0 , 3030 , 0 , "Flee");
	QCmd ( 1007 , 3030 );
end;

function Priest()
	LandReinforcementFromMap ( 2 , "1" , 0 , 3001 );
	Cmd ( 0 , 3001 , 0 , "Art1");
	QCmd ( 8 , 3001 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 50 , 3001 , 0 );
	Wait ( 3 );
	LandReinforcementFromMap ( 2 , "1" , 0 , 3002 );
	Cmd ( 0 , 3002 , 0 , "Art2");
	QCmd ( 8 , 3002 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 50 , 3002 , 0 );
	Wait ( 3 );
	LandReinforcementFromMap ( 2 , "1" , 0 , 3003 );
	Cmd ( 0 , 3003 , 0 , "Art3");
	QCmd ( 8 , 3003 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 50 , 3003 , 0 );
	Wait ( 3 );
	LandReinforcementFromMap ( 2 , "1" , 0 , 3004 );
	Cmd ( 0 , 3004 , 0 , "Art4");
	QCmd ( 8 , 3004 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 50 , 3004 , 0 );
	Wait ( 20);
	StartThread ( Support1 );
	Wait ( 80 );
	LandReinforcementFromMap ( 2 , "0" , 1 , 3020 );
	Cmd ( 0 , 3020 , 0 , "zone1");
	QCmd ( 0 , 3020 , 0 , "Zone01");
end;

function PriestFlee()
	Cmd ( 0 , 3001 , 0 , "Support4" );
	QCmd ( 0 , 3001 , 0 , "Support5" );
	QCmd ( 0 , 3001 , 0 , "Flee" );
	QCmd ( 1007 , 3001 );
	Wait ( 2 );
	Cmd ( 0 , 3002 , 0 , "Support4" );
	QCmd ( 0 , 3002 , 0 , "Support5" );
	QCmd ( 0 , 3002 , 0 , "Flee" );
	QCmd ( 1007 , 3002 );
	Wait ( 2 );
	Cmd ( 0 , 3003 , 0 , "Support4" );
	QCmd ( 0 , 3003 , 0 , "Support5" );
	QCmd ( 0 , 3003 , 0 , "Flee" );
	QCmd ( 1007 , 3003 );
	Wait ( 2 );
	Cmd ( 0 , 3004 , 0 , "Support4" );
	QCmd ( 0 , 3004 , 0 , "Support5" );
	QCmd ( 0 , 3004 , 0 , "Flee" );
	QCmd ( 1007 , 3004 );
	StartThread ( EvacuationPriest );
end;

function Reinf()
	while OBJ1 == 0 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 1 , "Reinf" , 0 ) > 0 and IsSomeUnitInArea ( 0 , "Reinf" , 0 ) < 1) and IsSomeUnitInArea ( 2 , "Reinf" , 0 ) < 1 then
			LandReinforcementFromMap ( 1 , "0" , 4 , 2020 );
			LandReinforcementFromMap ( 1 , "0" , 4, 2021 );
			Cmd ( 3 , 2020 , 0 , GetScriptAreaParams"Tank1" );
			Cmd ( 3 , 2021 , 0 , GetScriptAreaParams"Tank2" );
			Wait ( 15 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2023 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2024 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2025 );
			Cmd ( 3 , 2023 , 0 , GetScriptAreaParams"Tank1" );
			Cmd ( 3 , 2024 , 0 , GetScriptAreaParams"Tank2" );
			Cmd ( 3 , 2025 , 0 , GetScriptAreaParams"Tank3" );
			Wait ( 20 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2026 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2027 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2028 );
			LandReinforcementFromMap ( 1 , "0" , 4 , 2030 );
			Cmd ( 3 , 2026 , 0 , GetScriptAreaParams"Tank1" );
			Cmd ( 3 , 2027 , 0 , GetScriptAreaParams"Tank2" );
			Cmd ( 3 , 2028 , 0 , GetScriptAreaParams"Tank3" );
			Wait ( 3 );
			Cmd ( 3 , 2030 , 0 , GetScriptAreaParams"Tank1" );
			break;
		end;	
	end;
end;
-----------------------Objective 

function Objective2()
	GiveObjective ( 2 );
	StartThread( Loose2 );
	StartThread (NoCA);
	Cmd ( 0 , 3020 , 0 , "AirRecon");
	Wait ( 20 );
	StartThread (Player1);
end;

function Loose2 ()
	while OBJ2 == 0 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 1 , "Zone03" , 0 ) > 0 and IsSomeUnitInArea ( 0 , "Zone03" , 0 ) < 1) and IsSomeUnitInArea ( 2 , "Zone03" , 0 ) < 1 then
			OBJ2 = 1;
			Win ( 1 );
			break;
		end;	
	end;
end;

function CompleteObjective2()
	while 1 do
	Wait ( 30 );
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , 'Zone03', 0 ) < 3  then
			Wait ( 5 );
			CompleteObjective ( 2 );
			OBJ2 = 1;
			Wait ( 3 );
			Win ( 0 );
			Wait ( 1 );
			break;
		end;	
	end;
end;

------------------------Kino****

function KinoT1()
	Wait ( 5 );
	Cmd ( 0 , 606 , 0 , "Flee6" );
	QCmd ( 50 , 606 );
	Wait ( 4 );
	Cmd ( 0 , 606 , 0 , "Flee60" );
	QCmd ( 0 , 606 , 0 , "Flee61" );
	QCmd ( 50 , 606 );
	Wait ( 7 );
	Cmd ( 0 , 606 , 0 , "Flee62" );
	QCmd ( 50 , 606 );
	Wait ( 5 )
	Cmd ( 0 , 606 , 0 , "Flee63" );
	QCmd ( 0 , 606 , 0 , "Flee64" );
	QCmd ( 50 , 606 );
	Wait ( 5 );
	Cmd ( 0 , 606 , 0 , "Flee65" );
	QCmd ( 8 , 606 , 0 , "Flee64" );
	QCmd ( 50 , 606 );
	Wait ( 10 );
	ChangePlayerForScriptGroup ( 606 , 0 );
end;

function KinoT2()
	Wait ( 3 );
	Cmd ( 0 , 602 , 0 , "Flee2" );
	QCmd ( 50 , 602 );
	Wait ( 4 );
	Cmd ( 0 , 602 , 0 , "Flee20" );
	QCmd ( 0 , 602 , 0 , "Flee21" );
	QCmd ( 50 , 602 );
	Wait ( 7 );
	Cmd ( 0 , 602 , 0 , "Flee22" );
	QCmd ( 50 , 602 );
	Wait ( 5 )
	Cmd ( 0 , 602 , 0 , "Flee23" );
	QCmd ( 0 , 602 , 0 , "Flee24" );
	QCmd ( 50 , 602 );
	Wait ( 5 );
	Cmd ( 0 , 602 , 0 , "Flee25" );
	QCmd ( 8 , 602 , 0 , "Flee24" );
	QCmd ( 50 , 602 );
	Wait ( 10 );
	ChangePlayerForScriptGroup ( 602 , 0 );
end;

function Kino()
	Cmd ( 0 , 597 , 0 , "Support3" );
	QCmd ( 0 , 597 , 0 , "Support2" );
	QCmd ( 0 , 597 , 0 , "Newroad" );
	QCmd ( 0 , 597 , 0 , "Support15" );
	QCmd ( 0 , 597 , 0 , "Support1" );
	QCmd ( 0 , 597 , 0 , "zone2" );
	QCmd ( 0 , 597 , 0 , "OBJ" );
	QCmd ( 0 , 597 , 0 , "Support4" );
	QCmd ( 0 , 597 , 0 , "Support5" );
	QCmd ( 0 , 597 , 0 , "Flee" );
	QCmd ( 1007 , 597 );
	Cmd ( 0 , 598 , 0 , "Support3" );
	QCmd ( 0 , 598 , 0 , "Support2" );
	QCmd ( 0 , 598 , 0 , "Newroad" );
	QCmd ( 0 , 598 , 0 , "Support15" );
	QCmd ( 0 , 598 , 0 , "Support1" );
	QCmd ( 0 , 598 , 0 , "zone2" );
	QCmd ( 0 , 598 , 0 , "OBJ" );
	QCmd ( 0 , 598 , 0 , "Support4" );
	QCmd ( 0 , 598 , 0 , "Support5" );
	QCmd ( 0 , 598 , 0 , "Flee" );
	QCmd ( 1007 , 598 );
	Cmd ( 0 , 599 , 0 , "Support3" );
	QCmd ( 0 , 599 , 0 , "Support2" );
	QCmd ( 0 , 599 , 0 , "Newroad" );
	QCmd ( 0 , 599 , 0 , "Support15" );
	QCmd ( 0 , 599 , 0 , "Support1" );
	QCmd ( 0 , 599 , 0 , "zone2" );
	QCmd ( 0 , 599 , 0 , "OBJ" );
	QCmd ( 0 , 599 , 0 , "Support4" );
	QCmd ( 0 , 599 , 0 , "Support5" );
	QCmd ( 0 , 599 , 0 , "Flee" );
	QCmd ( 1007 , 599 );
	Cmd ( 0 , 600 , 0 , "Support3" );
	QCmd ( 0 , 600 , 0 , "Support2" );
	QCmd ( 0 , 600 , 0 , "Newroad" );
	QCmd ( 0 , 600 , 0 , "Support15" );
	QCmd ( 0 , 600 , 0 , "Support1" );
	QCmd ( 0 , 600 , 0 , "zone2" );
	QCmd ( 0 , 600 , 0 , "OBJ" );
	QCmd ( 0 , 600 , 0 , "Support4" );
	QCmd ( 0 , 600 , 0 , "Support5" );
	QCmd ( 0 , 600 , 0 , "Flee" );
	QCmd ( 1007 , 600 );
	Cmd ( 0 , 4000 , 0 , "Forvard0" );
	QCmd ( 50 , 4000 );
	Cmd ( 0 , 4001 , 0 , "Forvard1" );
	QCmd ( 50 , 4001 );
	Cmd ( 0 , 4002 , 0 , "Forvard2" );
	QCmd ( 50 , 4002 );
	Cmd ( 0 , 601 , 0 , "Flee1" );
	Cmd ( 0 , 603 , 0 , "Flee3" );
	Cmd ( 0 , 604 , 0 , "Flee4" );
	Cmd ( 0 , 605 , 0 , "Flee5" );
	Wait ( 5 );
	StartThread (FirstAttack);
end;

----------------------------Attack****

function FirstAttack()
	LandReinforcementFromMap ( 1 , "0" , 0 , 2000 );
	Cmd ( 0 , 2000 , 0 , "Flee2" );
	QCmd ( 3 , 2000 , 0 , "Left12" );
	LandReinforcementFromMap ( 1 , "0" , 5 , 2001 );
	Cmd ( 0 , 2001 , 0 , "Flee60" );
	QCmd ( 3 , 2001 , 0 , "Left11" );
	Wait ( 25 );
	LandReinforcementFromMap ( 1 , "6" , 0 , 2002 );
	Cmd ( 0 , 2002 , 0 , "Flee2" );
	QCmd ( 3 , 2002 , 0 , "Left12" );
	Wait ( 3 );
	LandReinforcementFromMap ( 1 , "7" , 6 , 1998 );
	Cmd ( 3 , 1998 , 0 , "Support3" );
	QCmd ( 3 , 1998 , 0 , "Zone01" );
	Wait ( 30 );
	LandReinforcementFromMap ( 1 , "0" , 5 , 2005 );
	Cmd ( 0 , 2005 , 0 , "Flee60" );
	QCmd ( 3 , 2005 , 0 , "Left11" );
	Wait ( 3 );
	LandReinforcementFromMap ( 1 , "7" , 6 , 1997 );
	Cmd ( 3 , 1997 , 0 , "Support3" );
	QCmd ( 3 , 1997 , 0 , "Zone01" );
	Wait ( 7 );
	LandReinforcementFromMap ( 1 , "1" , 0 , 2006 );
	QCmd ( 3 , 2006 , 0 , "Left12" );
	LandReinforcementFromMap ( 1 , "1" , 5 , 2007 );
	QCmd ( 3 , 2007 , 0 , "Left11" );
	if  GetNUnitsInArea ( 0 , 'Zone01', 0 ) > GetNUnitsInArea ( 1 , 'Zone01', 0 ) then
		LandReinforcementFromMap ( 1 , "4" , 0 , 2008 );
		Cmd ( 0 , 2008 , 0 , "Flee1" );
		Wait ( 10 );
		LandReinforcementFromMap ( 1 , "4" , 5 , 2009 );
		Cmd ( 0 , 2009 , 0 , "Forvard1" );
	end;
	Wait ( 20 );
	LandReinforcementFromMap ( 1 , "6" , 0 , 2010 );
	Cmd ( 0 , 2010 , 0 , "Flee2" );
	QCmd ( 3 , 2010 , 0 , "Left12" );
	Wait ( 3 );
	LandReinforcementFromMap ( 1 , "7" , 6 , 1996 );
	Cmd ( 3 , 1996 , 0 , "Support3" );
	QCmd ( 3 , 1996 , 0 , "Zone01" );
	Wait ( 7 );
	LandReinforcementFromMap ( 1 , "1" , 0 , 2012 );
	QCmd ( 3 , 2012 , 0 , "Left12" );
	LandReinforcementFromMap ( 1 , "1" , 5 , 2013 );
	QCmd ( 3 , 2013 , 0 , "Left11" );
end;

------------------------Objectives****

function Objective()
	GiveObjective ( 0 );
	StartThread( Loose0 );
end;

function Loose0()
	while OBJ == 0 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 2 , "Zone01" , 0 ) + IsSomeUnitInArea ( 0 , "Zone01" , 0 )) < 1 then
			Win ( 1 );
			break;
		end;	
	end;
end;

function Objective1()
	GiveObjective ( 1 );
	StartThread( Loose1 );
	Cmd ( 0 , 4000 , 0 , GetScriptAreaParams"Tank1" );
	QCmd ( 8 , 4000 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 45 , 4000 , 0 );
	Cmd ( 0 , 4001 , 0 , GetScriptAreaParams"Tank2" );
	QCmd ( 8 , 4001 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 45 , 4001 , 0 );
	Cmd ( 0 , 4002 , 0 , GetScriptAreaParams"Tank3" );
	QCmd ( 8 , 4002 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 45 , 4002 , 0 );
	Cmd ( 0 , 4005 , 50 , GetScriptAreaParams"Mine1" );
	QCmd ( 8 , 4005 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 45 , 4005 , 0 );
	Cmd ( 0 , 4006 , 50 , GetScriptAreaParams"Mine2" );
	QCmd ( 8 , 4006 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 45 , 4006 , 0 );
	Cmd ( 0 , 4007 , 50 , GetScriptAreaParams"MG" );
	QCmd ( 8 , 4007 , 0 , GetScriptAreaParams"OBJ" );
	QCmd ( 45 , 4007 , 0 );
	StartThread (Paradrop);
end;

function Loose1 ()
	while OBJ1 == 0 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 1 , "Zone02" , 0 ) > 0 and IsSomeUnitInArea ( 0 , "Zone02" , 0 ) < 1) and IsSomeUnitInArea ( 2 , "Zone02" , 0 ) < 1 then
			Win ( 1 );
			break;
		end;	
	end;
end;

------------------------WIn_Loose****

function Unlucky()
	while 1 do
		Wait( 1 );
        if (( IsSomePlayerUnit( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

---------------------------------------------------------Start****

StartThread (Kino);
StartThread (KinoT1);
StartThread (KinoT2);
StartThread (Evacuation);
StartThread (EvacuationSecond);
StartThread (Objective);
StartThread (Unlucky);