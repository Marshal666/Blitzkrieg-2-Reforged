function Victory()
	LandReinforcementFromMap ( 2 , "3" , 1 , 7002 );
	Cmd ( 0 , 7002 , 300 , "AA1" );
	LandReinforcementFromMap ( 2 , "3" , 2 , 7003 );
	Cmd ( 0 , 7003 , 300 , "AA2" );
	Wait ( 15 );
	LandReinforcementFromMap ( 2 , "5" , 1 , 7004 );
	Cmd ( 0 , 7004 , 300 , "Bomb1" );
	LandReinforcementFromMap ( 2 , "5" , 2 , 7005 );
	Cmd ( 0 , 7005 , 300 , "Bomb2" );
	Wait ( 10 );
	LandReinforcementFromMap ( 2 , "6" , 0 , 7006 );
	Cmd ( 0 , 7006 , 300 , "Danger" );
	LandReinforcementFromMap ( 2 , "7" , 3 , 7007 );
	Cmd ( 0 , 7007 , 100 , "V2" );
	Wait ( 10 );
	LandReinforcementFromMap ( 2 , "7" , 3 , 7008 );
	Cmd ( 0 , 7008 , 100 , "V1" );
	StartThread ( CompleteObjective10 );
	while 1 do 
		Wait( 1 );
		if GetNUnitsInParty ( 1 ) < 1 then
			LandReinforcementFromMap ( 2 , "3" , 1 , 7010 );
			Cmd ( 3 , 7010 , 0 , "Bomb1" );
			LandReinforcementFromMap ( 2 , "3" , 2 , 7011 );
			Cmd ( 3 , 7011 , 0 , "Bomb2" );
			break;
		end;
 	end;
end;

function NoLoose()
	while 1 do 
		Wait( 1 );
		if GetNUnitsInParty ( 0 ) < 4 then
			LandReinforcementFromMap ( 2 , "8" , 1 , 7000 );
			Cmd ( 3 , 7000 , 0 , "Bomb1" );
			LandReinforcementFromMap ( 2 , "8" , 2 , 7001 );
			Cmd ( 3 , 7001 , 0 , "Bomb2" );
			break;
		end;
 	end;
end;

function Reinf()
	while 1 do 
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , 'Line1', 0 ) > 0 then
			LandReinforcementFromMap ( 2 , "4" , 0 , 6000 );
			Cmd ( 0 , 6000 , 100 , "Go3" );
			Wait ( 5 );
			LandReinforcementFromMap ( 2 , "4" , 0 , 6001 );
			Cmd ( 0 , 6001 , 100 , "Go6" );
			Wait ( 5 );
			LandReinforcementFromMap ( 2 , "4" , 0 , 6003 );
			Cmd ( 0 , 6003 , 100 , "Go1" );
			Wait ( 5 );
			LandReinforcementFromMap ( 2 , "4" , 0 , 6004 );
			Cmd ( 0 , 6004 , 100 , "Go8" );
			Cmd ( 0 , 6002 , 0 , "Run1" );
			QCmd ( 0 , 6002 , 0 , "Reinf" );
			StartThread (Alies);
			break;
		end;
 	end;
end;

function ReinfLeft()
	while 1 do 
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , 'Left', 0 ) > (IsSomeUnitInArea ( 0 , 'Left', 0 ) + IsSomeUnitInArea ( 2 , 'Left', 0 )) then
			LandReinforcementFromMap ( 2 , "4" , 1 , 7000 );
			Cmd ( 3 , 7000 , 0 , "Go2" );
			QCmd ( 8 , 7000 , 0 , "At3");
			QCmd ( 45, 7000 );
			Wait ( 2 );
			LandReinforcementFromMap ( 2 , "9" , 1 , 7001 );
			Cmd ( 6 , 7001 , 361 );
			break;
		end;
 	end;
end;

function ReinfCenter()
	while 1 do 
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , 'Center', 0 ) > (IsSomeUnitInArea ( 0 , 'Center', 0 ) + IsSomeUnitInArea ( 2 , 'Center', 0 )) then
			LandReinforcementFromMap ( 2 , "4" , 2 , 7002 );
			Cmd ( 3 , 7002 , 0 , "Go5" );
			QCmd ( 8 , 7002 , 0 , "At5");
			QCmd ( 45, 7002 );
			Wait ( 2 );
			LandReinforcementFromMap ( 2 , "9" , 2 , 7003 );
			Cmd ( 6 , 7003 , 362 );
			break;
		end;
 	end;
end;

function ReinfRight()
	while 1 do 
		Wait( 1 );
		if IsSomeUnitInArea ( 1 , 'Right', 0 ) > (IsSomeUnitInArea ( 0 , 'Right', 0 ) + IsSomeUnitInArea ( 2 , 'Right', 0 )) then
			LandReinforcementFromMap ( 2 , "4" , 1 , 7004 );
			Cmd ( 3 , 7004 , 0 , "Go8" );
			QCmd ( 8 , 7004 , 0 , "At8");
			QCmd ( 45, 7004 );
			Wait ( 2 );
			LandReinforcementFromMap ( 2 , "9" , 1 , 7005 );
			Cmd ( 6 , 7005 , 363 );
			break;
		end;
 	end;
end;

function Alies()
	while 1 do 
		Wait( 1 );
		if GetNScriptUnitsInArea ( 6002 , 'Reinf', 0 ) > 0 then
			Cmd ( 1007 , 6002 );
			Wait ( 20 );
			break;
		end;
 	end;
end;

function JapanLandingGo0()
	StartThread (JapanLanding1);
	StartThread (JapanLanding20);
	StartThread (JapanLanding3);
	Wait ( 60 );
	StartThread (JapanLanding5);
	StartThread (JapanLanding60);
	StartThread (JapanLanding70);
	StartThread (JapanLanding8);
	Wait ( 60 );
	StartThread (JapanLanding1);
	StartThread (JapanLanding20);
	StartThread (JapanLanding30);
	StartThread (JapanLanding4);
	StartThread (ReinfLeft);
	StartThread (ReinfCenter);
	StartThread (ReinfRight);
	Wait ( 30 );
--	StartThread (Reinf);
	Wait ( 40 );
	StartThread (JapanLanding10);
	StartThread (JapanLanding20);
	StartThread (JapanLanding3);
	StartThread (JapanLanding400);
	StartThread (JapanLanding500);
	StartThread (JapanLanding6);
	StartThread (JapanLanding70);
	StartThread (JapanLanding80);
--	StartThread (NoLoose);
	Wait ( 30 );
--	StartThread (Victory);
	StartThread ( CompleteObjective10 );
	Wait ( 30 );
end;

function AviaHere()
	while 1 do 
		Wait( 1 );
		if GetNScriptUnitsInArea ( 4001 , 'Center', 1 ) > 0 then
			Wait ( 5 );
			DamageScriptObject ( 4010 , 100 );
			Sleep ( 5 );
			DamageScriptObject ( 4010 , 100 );
			Sleep ( 5 );
			DamageScriptObject ( 4010 , 100 );
			Sleep ( 5 );
			DamageScriptObject ( 4010 , 100 );
			Sleep ( 5 );
			DamageScriptObject ( 4010 , 100 );
			Sleep ( 5 );
			DamageScriptObject ( 4010 , 100 );
			Sleep ( 5 );
			Wait ( 4 );
			LandReinforcementFromMap ( 2 , "1" , 0 , 4011 );
			Cmd ( 3 , 4011 , 300 , "Danger" );
			Wait ( 5 );
			LandReinforcementFromMap ( 2 , "0" , 0 , 4021 );
			Cmd ( 0 , 4021 , 300 , "Recon" );
			if IsSomeBodyAlive ( 0 , 4010 ) > 0 then
				LandReinforcementFromMap ( 1 , "2" , 9 , 4001 );
				Cmd ( 0 , 4001 , 0 , "Danger" );
				Wait ( 3 );
			end;
			StartThread (AliesAir);
			break;
		end;
 	end;
end;

---------------------------------------------------------FirstPart

function AliesAir()
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 2 , 4011 ) < 1 then
			Wait ( 20 );
			LandReinforcementFromMap ( 2 , "1" , 0 , 4011 );
			Cmd ( 3 , 4011 , 300 , "Danger" );
			Wait ( 5 );
			LandReinforcementFromMap ( 2 , "0" , 0 , 4021 );
			Cmd ( 0 , 4021 , 300 , "Recon" );
		end;
		break;
	end;
end;

function ArtFun()
	StartThread (JapanLanding0);
	Wait ( 10 );
	StartThread (JapanLanding07);
	Wait ( 25 );
	StartThread (JapanLanding01);
	StartThread (JapanLanding02);
	Wait ( 30 );
	StartThread (JapanLanding05);
	StartThread (JapanLanding06);
	StartThread (JapanLanding04);
	Wait ( 25 );
	StartThread (AirStrike);
end;

---------------------------------------------------------SecondPart

function AirStrike()
	LandReinforcementFromMap ( 1 , "5" , 7 , 4000 );
	Cmd ( 3 , 4000 , 500 , "Boat4" );
	Cmd ( 0 , 11 , 300 , "hqzone" );
	Wait (Random ( 10 ));
	LandReinforcementFromMap ( 1 , "2" , 9 , 4001 );
	Cmd ( 0 , 4001 , 0 , "Danger" );
	Wait ( 3 );
	StartThread (AviaHere);
	Wait ( 7 );
	StartThread (JapanLandingGo0);
end;

---------------------------------------------------------JapanLanding

function JapanLanding0()
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 5000 ) < 1 then
			break;
		end;
        if IsSomeUnitInArea ( 1 , 'Boat3', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 5000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 5001 );
			Cmd ( 3 , 5001 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 5001 , 2 );
			QCmd ( 3 , 5001 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 5000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 5002 );
			Cmd ( 3 , 5002 , 0 , GetScriptAreaParams"At4" );
			ChangeFormation ( 5002 , 2 );
			QCmd ( 3 , 5002 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 5000 , 0 , "Sea3" );
			QCmd ( 1007 , 5000 );
 			break; 
		end;
 	end;
end;

function JapanLanding400()
	LandReinforcementFromMap ( 1 , "1" , 7 , 1130 );
	Cmd ( 0 , 1130 , 0 , "Boat4" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1130 , 'Boat4', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "8" , 8 , 1131 );
			Cmd ( 0 , 1131 , 0 , GetScriptAreaParams"At5" );
			QCmd ( 0 , 1131 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1131 , 2 );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1132 );
			Cmd ( 3 , 1132 , 0 , GetScriptAreaParams"At4" );
			QCmd ( 3 , 1132 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1132 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1133 );
			Cmd ( 3 , 1133 , 0 , GetScriptAreaParams"At6" );
			QCmd ( 3 , 1133 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1133 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1130 , 0 , "Sea4" );
			QCmd ( 1007 , 1130 );
 			break; 
		end;
 	end;
end;

function JapanLanding500()
	LandReinforcementFromMap ( 1 , "1" , 9 , 1140 );
	Cmd ( 0 , 1140 , 0 , "Boat5" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1140 , 'Boat5', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "8" , 10 , 1041 );
			Cmd ( 0 , 1141 , 0 , GetScriptAreaParams"At6" );
			QCmd ( 3 , 1141 , 0 , GetScriptAreaParams"hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1142 );
			Cmd ( 3 , 1142 , 0 , GetScriptAreaParams"At4" );
			QCmd ( 3 , 1142 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1142 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1143 );
			Cmd ( 3 , 1143 , 0 , GetScriptAreaParams"At5" );
			QCmd ( 3 , 1143 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1143 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1140 , 0 , "Sea5" );
			QCmd ( 1007 , 1140 );
 			break; 
		end;
 	end;
end;

function JapanLanding10()
	LandReinforcementFromMap ( 1 , "1" , 1 , 1100 );
	Cmd ( 0 , 1100 , 0 , "Boat1" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1100 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1100, 'Boat1', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1100 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 2 , 1101 );
			Cmd ( 0 , 1101 , 0 , GetScriptAreaParams"At1" );
			QCmd ( 3 , 1101 , 0 , GetScriptAreaParams"hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1100 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1102 );
			Cmd ( 3 , 1102 , 0 , GetScriptAreaParams"At2" );
			QCmd ( 3 , 1102 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1102 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1100 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1103 );
			Cmd ( 3 , 1103 , 0 , GetScriptAreaParams"At3" );
			QCmd ( 3 , 1103 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1103 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1100 , 0 , "Sea1" );
			QCmd ( 1007 , 1100 );
 			break; 
		end;
 	end;
end;

function JapanLanding20()
	LandReinforcementFromMap ( 1 , "1" , 3 , 1110 );
	Cmd ( 0 , 1110 , 0 , "Boat2" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1110 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1110 , 'Boat2', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1110 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 4 , 1111 );
			Cmd ( 0 , 1111 , 0 , GetScriptAreaParams"At4" );
			QCmd ( 3 , 1111 , 0 , GetScriptAreaParams"hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1110 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1112 );
			Cmd ( 3 , 1112 , 0 , GetScriptAreaParams"At5" );
			QCmd ( 3 , 1112 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1112 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1110 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1113 );
			Cmd ( 3 , 1113 , 0 , GetScriptAreaParams"At6" );
			QCmd ( 3 , 1113 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1113 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1110 , 0 , "Sea2" );
			QCmd ( 1007 , 1110 );
 			break; 
		end;
 	end;
end;


function JapanLanding30()
	Trace ("3");
	LandReinforcementFromMap ( 1 , "1" , 5 , 1120 );
	Cmd ( 0 , 1120 , 0 , "Boat3" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1120 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1120 , 'Boat3', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1120 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 6 , 1121 );
			Cmd ( 0 , 1121 , 0 , GetScriptAreaParams"At1" );
			QCmd ( 3 , 1121 , 0 , "hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1120 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 1122 );
			Cmd ( 3 , 1122 , 0 , GetScriptAreaParams"At2" );
			ChangeFormation ( 1122 , 2 );
			QCmd ( 3 , 1122 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1120 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 1123 );
			Cmd ( 3 , 1123 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1123 , 2 );
			QCmd ( 3 , 1123 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1120 , 0 , "Sea3" );
			QCmd ( 1007 , 1120 );
 			break; 
		end;
 	end;
end;

function JapanLanding40()
	Trace ("4");
	LandReinforcementFromMap ( 1 , "1" , 7 , 1130 );
	Cmd ( 0 , 1130 , 0 , "Boat4" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1130 , 'Boat4', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 8 , 1131 );
			Cmd ( 0 , 1131 , 0 , GetScriptAreaParams"At1" );
			ChangeFormation ( 1131 , 2 );
			QCmd ( 3 , 1131 , 0 , "hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1132 );
			Cmd ( 3 , 1132 , 0 , GetScriptAreaParams"At2" );
			ChangeFormation ( 1132 , 2 );
			QCmd ( 3 , 1132 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1130 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1133 );
			Cmd ( 3 , 1133 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1133 , 2 );
			QCmd ( 3 , 1133 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1130 , 0 , "Sea4" );
			QCmd ( 1007 , 1130 );
 			break; 
		end;
 	end;
end;

function JapanLanding50()
	Trace ("5");
	LandReinforcementFromMap ( 1 , "1" , 9 , 1140 );
	Cmd ( 0 , 1140 , 0 , "Boat5" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1140 , 'Boat5', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 10 , 1041 );
			Cmd ( 0 , 1141 , 0 , GetScriptAreaParams"At8" );
			QCmd ( 3 , 1141 , 0 , "hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1142 );
			Cmd ( 3 , 1142 , 0 , GetScriptAreaParams"At6" );
			ChangeFormation ( 1142 , 2 );
			QCmd ( 3 , 1142 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1140 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1143 );
			Cmd ( 3 , 1143 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1143 , 2 );
			QCmd ( 3 , 1143 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1140 , 0 , "Sea5" );
			QCmd ( 1007 , 1140 );
 			break; 
		end;
 	end;
end;

function JapanLanding60()
	Trace ("6");
	LandReinforcementFromMap ( 1 , "1" , 11 , 1150 );
	Cmd ( 0 , 1150 , 0 , "Boat6" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1150 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1150 , 'Boat6', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1150 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 12 , 1151 );
			Cmd ( 0 , 1151 , 0 , GetScriptAreaParams"At8" );
			ChangeFormation ( 1151 , 2 );
			QCmd ( 3 , 1151 , 0 , "hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1150 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1152 );
			Cmd ( 3 , 1152 , 0 , GetScriptAreaParams"At9" );
			ChangeFormation ( 1152 , 2 );
			QCmd ( 3 , 1152 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1150 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1153 );
			Cmd ( 3 , 1153 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1153 , 2 );
			QCmd ( 3 , 1153 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1150 , 0 , "Sea6" );
			QCmd ( 1007 , 1150 );
 			break; 
		end;
 	end;
end;

function JapanLanding70()
	LandReinforcementFromMap ( 1 , "1" , 13 , 1160 );
	Cmd ( 0 , 1160 , 0 , "Boat7" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1160 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1160 , 'Boat7', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1160 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 14 , 1161 );
			Cmd ( 0 , 1161 , 0 , GetScriptAreaParams"At7" );
			QCmd ( 3 , 1161 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1161 , 2 );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1160 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1162 );
			Cmd ( 3 , 1162 , 0 , GetScriptAreaParams"At8" );
			QCmd ( 3 , 1162 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1162 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1160 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1163 );
			Cmd ( 3 , 1163 , 0 , GetScriptAreaParams"At9" );
			QCmd ( 3 , 1163 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1163 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1160 , 0 , "Sea7" );
			QCmd ( 1007 , 1160 );
 			break; 
		end;
 	end;
end;

function JapanLanding80()
	LandReinforcementFromMap ( 1 , "1" , 15 , 1170 );
	Cmd ( 0 , 1170 , 0 , "Boat8" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1170 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1170 , 'Boat8', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1170 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "4" , 16 , 1171 );
			Cmd ( 0 , 1171 , 0 , GetScriptAreaParams"At9" );
			QCmd ( 3 , 1171 , 0 , GetScriptAreaParams"hqzone" );
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1170 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 16 , 1172 );
			Cmd ( 3 , 1172 , 0 , GetScriptAreaParams"At8" );
			QCmd ( 3 , 1172 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1172 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1170 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 16 , 1173 );
			Cmd ( 3 , 1173 , 0 , GetScriptAreaParams"At7" );
			QCmd ( 3 , 1173 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1173 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1170 , 0 , "Sea8" );
			QCmd ( 1007 , 1170 );
 			break; 
		end;
 	end;
end;

function JapanLanding1()
	LandReinforcementFromMap ( 1 , "1" , 1 , 1000 );
	Cmd ( 0 , 1000 , 0 , "Boat1" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1000 , 'Boat1', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1001 );
			Cmd ( 3 , 1001 , 0 , GetScriptAreaParams"At1" );
			ChangeFormation ( 1001 , 2 );
			QCmd ( 3 , 1001 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1002 );
			Cmd ( 3 , 1002 , 0 , GetScriptAreaParams"At2" );
			QCmd ( 3 , 1002 , 0 , "hqzone" );
			ChangeFormation ( 1002 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1003 );
			Cmd ( 3 , 1003 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1003 , 2 );
			QCmd ( 3 , 1003 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1000 , 0 , "Sea1" );
			QCmd ( 1007 , 1000 );
 			break; 
		end;
 	end;
end;

function JapanLanding2()
	LandReinforcementFromMap ( 1 , "1" , 3 , 1010 );
	Cmd ( 0 , 1010 , 0 , "Boat2" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1010 , 'Boat2', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1011 );
			Cmd ( 3 , 1011 , 0 , GetScriptAreaParams"At4" );
			ChangeFormation ( 1011 , 2 );
			QCmd ( 3 , 1011 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1012 );
			Cmd ( 3 , 1012 , 0 , GetScriptAreaParams"At5" );
			ChangeFormation ( 1012 , 2 );
			QCmd ( 3 , 1012 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1013 );
			Cmd ( 3 , 1013 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1013 , 2 );
			QCmd ( 3 , 1013 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1010 , 0 , "Sea2" );
			QCmd ( 1007 , 1010 );
 			break; 
		end;
 	end;
end;


function JapanLanding3()
	Trace ("3");
	LandReinforcementFromMap ( 1 , "1" , 5 , 1020 );
	Cmd ( 0 , 1020 , 0 , "Boat3" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1020 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1020 , 'Boat3', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1020 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 1021 );
			Cmd ( 3 , 1021 , 0 , GetScriptAreaParams"At1" );
			QCmd ( 3 , 1021 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1021 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1020 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 1022 );
			Cmd ( 3 , 1022 , 0 , GetScriptAreaParams"At2" );
			QCmd ( 3 , 1022 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1022 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1020 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 6 , 1023 );
			Cmd ( 3 , 1023 , 0 , GetScriptAreaParams"At3" );
			QCmd ( 3 , 1023 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1023 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1020 , 0 , "Sea3" );
			QCmd ( 1007 , 1020 );
 			break; 
		end;
 	end;
end;

function JapanLanding4()
	Trace ("4");
	LandReinforcementFromMap ( 1 , "1" , 7 , 1030 );
	Cmd ( 0 , 1030 , 0 , "Boat4" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1030 , 'Boat4', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1031 );
			Cmd ( 3 , 1031 , 0 , GetScriptAreaParams"At1" );
			ChangeFormation ( 1031 , 2 );
			QCmd ( 3 , 1031 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1032 );
			Cmd ( 3 , 1032 , 0 , GetScriptAreaParams"At2" );
			ChangeFormation ( 1032 , 2 );
			QCmd ( 3 , 1032 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1033 );
			Cmd ( 3 , 1033 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1033 , 2 );
			QCmd ( 3 , 1033 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1030 , 0 , "Sea4" );
			QCmd ( 1007 , 1030 );
 			break; 
		end;
 	end;
end;

function JapanLanding5()
	Trace ("5");
	LandReinforcementFromMap ( 1 , "1" , 9 , 1040 );
	Cmd ( 0 , 1040 , 0 , "Boat5" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1040 , 'Boat5', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1041 );
			Cmd ( 3 , 1041 , 0 , GetScriptAreaParams"At8" );
			ChangeFormation ( 1041 , 2 );
			QCmd ( 3 , 1041 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1042 );
			Cmd ( 3 , 1042 , 0 , GetScriptAreaParams"At6" );
			ChangeFormation ( 1042 , 2 );
			QCmd ( 3 , 1042 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1043 );
			Cmd ( 3 , 1043 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1043 , 2 );
			QCmd ( 3 , 1043 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1040 , 0 , "Sea5" );
			QCmd ( 1007 , 1040 );
 			break; 
		end;
 	end;
end;

function JapanLanding6()
	Trace ("6");
	LandReinforcementFromMap ( 1 , "1" , 11 , 1050 );
	Cmd ( 0 , 1050 , 0 , "Boat6" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1050 , 'Boat6', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1051 );
			Cmd ( 3 , 1051 , 0 , GetScriptAreaParams"At8" );
			QCmd ( 3 , 1051 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1051 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1052 );
			Cmd ( 3 , 1052 , 0 , GetScriptAreaParams"At9" );
			QCmd ( 3 , 1052 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1052 , 2 );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1053 );
			Cmd ( 3 , 1053 , 0 , GetScriptAreaParams"At7" );
			QCmd ( 3 , 1053 , 0 , GetScriptAreaParams"hqzone" );
			ChangeFormation ( 1053 , 2 );
			Wait ( 1 );
			Cmd ( 0 , 1050 , 0 , "Sea6" );
			QCmd ( 1007 , 1050 );
 			break; 
		end;
 	end;
end;

function JapanLanding7()
	LandReinforcementFromMap ( 1 , "1" , 13 , 1060 );
	Cmd ( 0 , 1060 , 0 , "Boat7" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1060 , 'Boat7', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1061 );
			Cmd ( 3 , 1061 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1061 , 2 );
			QCmd ( 3 , 1061 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1062 );
			Cmd ( 3 , 1062 , 0 , GetScriptAreaParams"At8" );
			ChangeFormation ( 1062 , 2 );
			QCmd ( 3 , 1062 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1063 );
			Cmd ( 3 , 1063 , 0 , GetScriptAreaParams"At9" );
			ChangeFormation ( 1063 , 2 );
			QCmd ( 3 , 1063 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1060 , 0 , "Sea7" );
			QCmd ( 1007 , 1060 );
 			break; 
		end;
 	end;
end;

function JapanLanding8()
	LandReinforcementFromMap ( 1 , "1" , 15 , 1070 );
	Cmd ( 0 , 1070 , 0 , "Boat8" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1070 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1070 , 'Boat8', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1070 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 16 , 1071 );
			Cmd ( 3 , 1071 , 0 , GetScriptAreaParams"At9" );
			ChangeFormation ( 1071 , 2 );
			QCmd ( 3 , 1071 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1070 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 16 , 1072 );
			Cmd ( 3 , 1072 , 0 , GetScriptAreaParams"At8" );
			ChangeFormation ( 1072 , 2 );
			QCmd ( 3 , 1072 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1070 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 16 , 1073 );
			Cmd ( 3 , 1073 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1073 , 2 );
			QCmd ( 3 , 1073 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1070 , 0 , "Sea8" );
			QCmd ( 1007 , 1070 );
 			break; 
		end;
 	end;
end;

function JapanLanding01()
	LandReinforcementFromMap ( 1 , "1" , 1 , 1000 );
	Cmd ( 0 , 1000 , 0 , "Boat1" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1000 , 'Boat1', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1001 );
			Cmd ( 3 , 1001 , 0 , GetScriptAreaParams"At1" );
			ChangeFormation ( 1001 , 2 );
			QCmd ( 3 , 1001 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1000 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 2 , 1002 );
			Cmd ( 3 , 1002 , 0 , GetScriptAreaParams"At2" );
			ChangeFormation ( 1002 , 2 );
			QCmd ( 3 , 1002 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1000 , 0 , "Sea1" );
			QCmd ( 1007 , 1000 );
 			break; 
		end;
 	end;
end;

function JapanLanding02()
	LandReinforcementFromMap ( 1 , "1" , 3 , 1010 );
	Cmd ( 0 , 1010 , 0 , "Boat2" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1010 , 'Boat2', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1011 );
			Cmd ( 3 , 1011 , 0 , GetScriptAreaParams"At2" );
			ChangeFormation ( 1011 , 2 );
			QCmd ( 3 , 1011 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1010 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 4 , 1012 );
			Cmd ( 3 , 1012 , 0 , GetScriptAreaParams"At3" );
			ChangeFormation ( 1012 , 2 );
			QCmd ( 3 , 1012 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1010 , 0 , "Sea2" );
			QCmd ( 1007 , 1010 );
 			break; 
		end;
 	end;
end;

function JapanLanding04()
	LandReinforcementFromMap ( 1 , "1" , 7 , 1030 );
	Cmd ( 0 , 1030 , 0 , "Boat4" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1030 , 'Boat4', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1031 );
			Cmd ( 3 , 1031 , 0 , GetScriptAreaParams"At4" );
			ChangeFormation ( 1031 , 2 );
			QCmd ( 3 , 1031 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1030 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 8 , 1032 );
			Cmd ( 3 , 1032 , 0 , GetScriptAreaParams"At5" );
			ChangeFormation ( 1032 , 2 );
			QCmd ( 3 , 1032 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1030 , 0 , "Sea4" );
			QCmd ( 1007 , 1030 );
 			break; 
		end;
 	end;
end;

function JapanLanding05()
	LandReinforcementFromMap ( 1 , "1" , 9 , 1040 );
	Cmd ( 0 , 1040 , 0 , "Boat5" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1040 , 'Boat5', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1041 );
			Cmd ( 3 , 1041 , 0 , GetScriptAreaParams"At5" );
			ChangeFormation ( 1041 , 2 );
			QCmd ( 3 , 1041 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1040 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 10 , 1042 );
			Cmd ( 3 , 1042 , 0 , GetScriptAreaParams"At6" );
			ChangeFormation ( 1042 , 2 );
			QCmd ( 3 , 1042 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1040 , 0 , "Sea5" );
			QCmd ( 1007 , 1040 );
 			break; 
		end;
 	end;
end;

function JapanLanding06()
	LandReinforcementFromMap ( 1 , "1" , 11 , 1050 );
	Cmd ( 0 , 1050 , 0 , "Boat6" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1050 , 'Boat6', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1051 );
			Cmd ( 3 , 1051 , 0 , GetScriptAreaParams"At6" );
			ChangeFormation ( 1051 , 2 );
			QCmd ( 3 , 1051 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1050 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 12 , 1052 );
			Cmd ( 3 , 1052 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1052 , 2 );
			QCmd ( 3 , 1052 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1050 , 0 , "Sea6" );
			QCmd ( 1007 , 1050 );
 			break; 
		end;
 	end;
end;

function JapanLanding07()
	LandReinforcementFromMap ( 1 , "1" , 13 , 1060 );
	Cmd ( 0 , 1060 , 0 , "Boat7" );
	while 1 do 
		Wait( 1 );
		if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
			break;
		end;
        if GetNScriptUnitsInArea ( 1060 , 'Boat7', 0 ) > 0 then
			Wait ( 1 );
			if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1061 );
			Cmd ( 3 , 1061 , 0 , GetScriptAreaParams"At7" );
			ChangeFormation ( 1061 , 2 );
			QCmd ( 3 , 1061 , 0 , "hqzone" );
			Wait ( 3 );
			if IsSomeBodyAlive ( 1 , 1060 ) < 1 then
				break;
			end;
			LandReinforcementFromMap ( 1 , "0" , 14 , 1062 );
			Cmd ( 3 , 1062 , 0 , GetScriptAreaParams"At8" );
			ChangeFormation ( 1062 , 2 );
			QCmd ( 3 , 1062 , 0 , "hqzone" );
			Wait ( 1 );
			Cmd ( 0 , 1060 , 0 , "Sea7" );
			QCmd ( 1007 , 1060 );
 			break; 
		end;
 	end;
end;


---------------------------------------------------------AirAtaka

function AirAtaka1()
--	if (GetDifficultyLevel == 0) then
--		LandReinforcementFromMap ( 1 , "2" , 1 , 220 );
--		Cmd ( 0 , 220, 0 , GetScriptAreaParams"At3" );
--		LandReinforcementFromMap ( 1 , "2" , 5 , 221 );
--		Cmd ( 0 , 221, 0 , GetScriptAreaParams"At7" );
--	else
--		LandReinforcementFromMap ( 1 , "2" , 1 , 220 );
--		Cmd ( 0 , 220, 0 , GetScriptAreaParams"Bomb1" );
--		LandReinforcementFromMap ( 1 , "2" , 5 , 221 );
--		Cmd ( 0 , 221, 0 , GetScriptAreaParams"Bomb2" );
--	end;
	Wait ( 5 );
	LandReinforcementFromMap ( 1 , "3" , 3 , 222 );
	Cmd ( 3 , 222, 0 , GetScriptAreaParams"At5" );
	LandReinforcementFromMap ( 1 , "3" , 9 , 223 );
	Cmd ( 3 , 223, 0 , GetScriptAreaParams"At8" );
end;

function AirAtaka2()
	while 1 do
		Wait ( 10 );
		if IsSomeBodyAlive ( 1 , 242 ) < 1  then
			Wait ( 10 );
			LandReinforcementFromMap ( 1 , "5" , 3 , 242 );
			Cmd ( 3 , 242, 0 , GetScriptAreaParams"At5" );
		end;
	end;
end;

function AirAtaka3()
	while 1 do
		Wait ( 10 );
		if IsSomeBodyAlive ( 2 , 802 ) < 1  then
			Wait ( 10 );
			LandReinforcementFromMap ( 2 , "1" , 0 , 802 );
			Cmd ( 3 , 802 , 0 , GetScriptAreaParams "Boat3" );
			Wait ( 1 );
		end;
	end;
end;

---------------------------------------------------------Recon
function Reinforcement()
	Cmd ( 4 , 6001 , 6002 );
	Wait ( 4 );
	Cmd ( 0, 6002 , 0 , 'Run1');
	QCmd ( 0, 6002 , 0 , 'Reinf');
	while 1 do 
		Wait( 1 );
        if GetNScriptUnitsInArea ( 6002 , 'Reinf', 0 ) > 0 then
			Cmd ( 1007 , 6002 );
			Wait ( 10 );
			LandReinforcementFromMap ( 2 , "0" , 0 , 803 );
			Cmd ( 0 , 803 , 0 , GetScriptAreaParams "Boat1" );
			Wait ( 10 );
			LandReinforcementFromMap ( 2 , "3" , 0 , 806 );
			Cmd ( 3 , 806 , 0 , GetScriptAreaParams "Run1" );
			QCmd ( 3 , 806 , 100 , GetScriptAreaParams "Go5" );
			Wait ( 5 );
--			if GetNUnitsInArea ( 1 , 'Danger', 0 ) < 1 or (GetDifficultyLevel > 0)then
--				LandReinforcementFromMap ( 2 , "2" , 0 , 804 );
--				Cmd ( 0 , 804 , 0 , GetScriptAreaParams "Run1" );
--				QCmd ( 0 , 804 , 300 , GetScriptAreaParams "Go4" );
--				Wait ( 5 );
--				LandReinforcementFromMap ( 2 , "2" , 0 , 805 );
--				Cmd ( 0 , 805 , 0 , GetScriptAreaParams "Run1" );
--				QCmd ( 0 , 805 , 300 , GetScriptAreaParams "Go6" );
--				Wait ( 5 );
--			else
				LandReinforcementFromMap ( 2 , "4" , 0 , 804 );
				Cmd ( 3 , 804 , 300 , GetScriptAreaParams "Run1" );
				Wait ( 5 );
				LandReinforcementFromMap ( 2 , "4" , 0 , 805 );
				Cmd ( 3 , 805 , 300 , GetScriptAreaParams "Run1" );
				Wait ( 5 );
--			end;
 			break; 
		end;
 	end;
end;

-----------------------Objective 

function Objective()
	GiveObjective ( 0 );
	StartThread( CompleteObjective0 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 1 );
		if (IsSomeUnitInArea ( 1 , "Biach" , 0 ) > 0 and IsSomeUnitInArea ( 0 , "Biach" , 0 ) < 1) and IsSomeUnitInArea ( 2 , "Biach" , 0 ) < 1 then
			Wait ( 60 );
			if (IsSomeUnitInArea ( 1 , "Biach" , 0 ) > 0 and IsSomeUnitInArea ( 0 , "Biach" , 0 ) < 1) and IsSomeUnitInArea ( 2 , "Biach" , 0 ) < 1 then
				Win ( 1 );
				break;
			end;
		end;	
	end;
end;

function CompleteObjective10()
	Wait ( 10 );
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea ( 1 , 'Biach', 0 ) < 2 then
			Win ( 0 );
			break;
		end;	
	end;
end;

function SOObjective()
	while 1 do
		Wait( 1 );
		if GetNUnitsInArea ( 0 , 'SO', 0 ) > 0 then
			GiveObjective ( 1 );
			Sleep ( 1 );
			CompleteObjective ( 1 );
			break;
		end;	
	end;
end;

------------------------WIn_Loose

function Unlucky()
	while 1 do
		Wait( 1 );
        if IsSomeBodyAlive ( 0 , 500 ) < 0 and IsSomePlayerUnit( 0 ) < 1 then
			Win(1);
			break;
		end;
	end;
end;

function Loose()
	while 1 do
		Wait( 1 );
        if ( IsSomePlayerUnit( 0 ) < 1 and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Win(1);
			break;
		end;
	end;
end;

---------------------------------------------------------

StartThread (Objective);
StartThread (SOObjective);
StartThread (Loose);

StartThread (Unlucky);

StartThread (ArtFun);

Trace (GetNUnitsInArea ( 2 , 'Biach', 0 ));

Wait ( 6 )
Cmd ( 9 , 4010 );