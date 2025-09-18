WOL = 0;
a = 0; a1 = 0;
x = 0;

------------------------Defense
function Defense1()
	Wait ( 150 );
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		Wait ( 3 );
		if GetNUnitsInScriptGroup ( 300 ) < 1 then
			LandReinforcementFromMap( 1 , 0 , 0 , 300 );
			Wait( 5 );
			ChangeFormation( 300, 1 );
			Wait( 1 );
			Cmd( 3 , 300 , 0 , 1211 , 10675 );
			QCmd( 3 , 300 , 0 , 1814 , 10558 );
			QCmd( 3 , 300 , 0 , 4596 , 10121 );
			while 1 do
				Wait ( 3 );
				if GetNScriptUnitsInArea( 300 , "Most1" ) > 0 then
					ChangeFormation( 300, 3 );
					Wait( 1 );
					QCmd( 3 , 300 , 1000 , 5306 , 10096 );
					break;
				end;
			end;
		end;
	end;
end;
function Defense2()
	Wait ( 30 );
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		Wait ( 3 );
		if GetNUnitsInScriptGroup ( 301 ) < 1 then
			LandReinforcementFromMap( 1 , 0 , 0 , 301 );
			Wait( 5 );
			ChangeFormation( 301, 1 );
			Wait( 1 );
			Cmd( 3 , 301 , 0 , 1143 , 8256 );
			QCmd( 3 , 301 , 0 , 1591 , 6514 );
			QCmd( 3 , 301 , 0 , 2694 , 4539 );
			QCmd( 3 , 301 , 0 , 3989 , 5333 );
			QCmd( 3 , 301 , 0 , 5974 , 6522 );
			while 1 do
				Wait ( 3 );
				if GetNScriptUnitsInArea( 301 , "Most2" ) > 0 then
					ChangeFormation( 301, 3 );
					Wait( 1 );
					QCmd( 3 , 301 , 1000 , 7101 , 7150 );
					break;
				end;
			end;
		end;
	end;
end;
function Defense3()
	Wait ( 90 );
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		Wait ( 3 );
		if GetNUnitsInScriptGroup ( 302 ) < 1 then
			LandReinforcementFromMap( 1 , 0 , 1 , 302 );
			Wait( 5 );
			ChangeFormation( 302, 1 );
			Wait( 1 );
			Cmd( 3 , 302 , 0 , 5573 , 577 );
			QCmd( 3 , 302 , 0 , 6490 , 731 );
			QCmd( 3 , 302 , 0 , 6925 , 1037 );
			QCmd( 3 , 302 , 0 , 8968 , 3010 );
			while 1 do
				Wait ( 3 );
				if GetNScriptUnitsInArea( 302 , "Most3" ) > 0 then
					ChangeFormation( 302, 3 );
					Wait( 1 );
					QCmd( 3 , 302 , 1000 , 9948 , 3061 );
					break;
				end;
			end;
		end;
	end;
end;
------------------------Miner
function Miner()
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		for m = 1 , 5 do
			Wait( 10 );
			Delx = Random ( 1000 ) - 500;
			Dely = Random ( 1000 ) - 500;
			min = m - 1;
			MinnX , MinnY = GetScriptAreaParams( "Mine"..m );
			MinnX = MinnX + Delx;
			MinnY = MinnY + Dely;
			Cmd( 11 , 120 + min , 0 , MinnX , MinnY);
		end;
	end;
end;
------------------------Go
function Go0()
	Wait( 3 );
	x = RandomInt( 3 );
	Cmd( 3 , 100 + a , 0 , GetScriptAreaParams( "Go"..x..1 ));
	QCmd( 3 , 100 + a , 0 , GetScriptAreaParams( "Go"..x..2 ));
	if a == 6 then
		a = 0;
		LandReinforcementFromMap( 2 , 1 , 0 , 111 );
		Wait( 3 );
		Cmd( 3 , 111 , 0 , GetScriptAreaParams "Go12" );
	else
		a = a + 1;
	end;
	Wait( 5 );
	StartThread( AttackSouz );
end;
function Go1()
	Wait( 3 );
	Cmd( 3 , 130 + a1 , 0 , 10668 , 2740 );
	QCmd( 3 , 130 + a1 , 0 , 9672 , 3105 );
	if a1 == 3 then
		a1 = 0;
		LandReinforcementFromMap( 2 , 0 , 1 , 135 );
		Wait( 1 );
		Cmd( 3 , 135 , 0 , 10668 , 2740 );
		QCmd( 3 , 135 , 0 , GetScriptAreaParams "Town2" );
	else
		a1 = a1 + 1;
	end;
	Wait( 5 );
	StartThread( AttackSouz1 );
end;
------------------------AttackSouz
function AttackSouz()
	if GetNUnitsInArea( 1 , "Town1" , 0 ) > 0 then
		if GetNUnitsInScriptGroup ( 100 + a ) < 1 then
			LandReinforcementFromMap( 2 , 0 , 0 , 100 + a );
			Wait( 3 );
			StartThread( Go0 );
		else
			Wait( 3 );
			if a == 6 then
				a = 0;
			else
				a = a + 1;
			end;
			StartThread( AttackSouz );
		end;
	end;
end;
function AttackSouz1()
	if GetNUnitsInArea( 1 , "Town2" , 0 ) > 0 then
		if GetNUnitsInScriptGroup( 130 + a1 ) < 1 then
			tank = Random ( 4 );
			LandReinforcementFromMap( 2 , tank , 1 , 130 + a1 );
			Wait( 3 );
			StartThread( Go1 );
		else
			Wait( 3 );
			if a1 == 3 then
				a1 = 0;
			else
				a1 = a1 + 1;
			end;
			StartThread( AttackSouz1 );
		end;
	end;
end;
function AttackSouzMost1()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 1 , "Town1" , 0 ) < 1 then 
			Cmd( 3 , 100 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 101 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 102 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 103 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 104 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 105 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 106 , 0 , GetScriptAreaParams "Forse1" );
			Cmd( 3 , 111 , 0 , GetScriptAreaParams "Forse1" );
			break;
		end;
	end;
end;
function AttackSouzMost3()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 1 , "Town2" , 0 ) < 1 then
			Cmd( 3 , 130 , 0 , GetScriptAreaParams "Forse3" );	
			Cmd( 3 , 131 , 0 , GetScriptAreaParams "Forse3" );
			Cmd( 3 , 132 , 0 , GetScriptAreaParams "Forse3" );	
			Cmd( 3 , 133 , 0 , GetScriptAreaParams "Forse3" );	
			Cmd( 3 , 135 , 0 , GetScriptAreaParams "Forse3" );
			break;
		end;
	end;
end;
------------------------Start
function Start()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea( 0 , "Start" , 1 ) > 0) or (GetNUnitsInArea( 0 , "Start0" , 1 ) > 0) then
			Wait( 3 );
			StartThread( Defense1 );
			StartThread( Defense2 );
			StartThread( Defense3 );
			StartThread( AttackSouz );
			StartThread( AttackSouz1 );
			StartThread( Miner );
			StartThread( Art1 );
			StartThread( Art2 );
			StartThread( Art3 );
			StartThread( Start1 );
			break;
		end;
	end;
end;
function Start1()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 0 , "Most1" , 0 ) > 0 or GetNUnitsInArea ( 0 , "Most2" , 0 ) > 0 or GetNUnitsInArea ( 0 , "Most3" , 0 ) > 0 then
			Wait( 3 );
			StartThread( AttackSouzMost1 );
			StartThread( AttackSouzMost3 );
			StartThread( AirSouz );
			break;
		end;
	end;
end;
------------------------Art
function Art1()
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Most1" , 0 ) >  GetNUnitsInArea( 1 , "Most1" , 0 ) or  GetNUnitsInArea( 1 , "Most1" , 0 ) < 1 then
			Cmd( 16 , 200 , 500 , GetScriptAreaParams "Most1" );
		else
			Cmd( 9 , 200 );
		end;
	end;
end;
function Art2()
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Most2" , 0 ) >  GetNUnitsInArea( 1 , "Most2" , 0 ) or  GetNUnitsInArea( 1 , "Most2" , 0 ) < 1 then
			Cmd( 16 , 201 , 500 , GetScriptAreaParams "Most2" );
		else
			Cmd( 9 , 201 );
		end;
	end;
end;
function Art3()
	while GetIGlobalVar( "temp.objective0" , 0) == 1 do
		Wait( 1 );
		if GetNUnitsInArea( 0 , "Most3" , 0 ) >  GetNUnitsInArea( 1 , "Most3" , 0 ) or  GetNUnitsInArea( 1 , "Most3" , 0 ) < 1 then
			Cmd( 16 , 202 , 500 , GetScriptAreaParams "Most3" );
		else
			Cmd( 9 , 202 );
		end;
	end;
end;
------------------------Guard
function Guard()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 0 , "Town1" , 0 ) < 1 and GetNUnitsInArea( 1 , "Town1" , 0 ) < 1 and GetNUnitsInArea( 2 , "Town1" , 0 ) < 1 then
			LandReinforcementFromMap( 2 , 1 , 0 , 50 );
			Wait( 1 );
			Cmd( 0 , 50 , 0 , 7998 , 10719 );
			QCmd( 50 , 50 , 0 , 7998 , 10719 );
		end;
		if GetNUnitsInArea( 0 , "Town2" , 0 ) < 1 and GetNUnitsInArea( 1 , "Town2" , 0 ) < 1 and GetNUnitsInArea( 2 , "Town2" , 0 ) < 1 then
			LandReinforcementFromMap( 2 , 1 , 1 , 51 );
			Wait( 1 );
			Cmd( 0 , 51 , 0 , 10772 , 2539 );
			Cmd( 50 , 51 , 0 , 10772 , 2539 );
		end;
	end;
end;
------------------------Reinf
function ReinfUp()
	while 1 do
		Wait( 90 );
		if GetNUnitsInArea( 0 , "ReinfZone" , 0 ) < 1 then
			LandReinforcementFromMap( 1 , 0 , 0 , 310 );
			Wait( 3 );
			Cmd( 3 , 310 , 500 , 2719 , 1119 );
			Wait( 3 );
			LandReinforcementFromMap( 1 , 1 , 0 , 311 );
			Wait( 3 );
			Cmd( 3 , 311 , 500 , 2719 , 1119 );
			Wait( 3 );
			LandReinforcementFromMap( 1 , 2 , 0 , 312 );
			Wait( 3 );
			Cmd( 3 , 312 , 500 , 2719 , 1119 );
		end;	
	end;
end;
------------------------AirSouz
function AirSouz()
	Wait( 30 );
	LandReinforcementFromMap( 2 , 5 , 0 , 330 );
	Cmd( 3 , 330 , 2000 , GetScriptAreaParams "AirSouz" );
	Wait( 3 );
	LandReinforcementFromMap( 2 , 6 , 0 , 332 );
	Cmd( 3 , 332 , 2000 , GetScriptAreaParams "AirSouz" );
	Wait( 3 );
	LandReinforcementFromMap( 2 , 5 , 1 , 331 );
	Cmd( 3 , 321 , 2000 , GetScriptAreaParams "AirSouz" );
	Wait( 3 );
	LandReinforcementFromMap( 2 , 6 , 1 , 333 );
	Cmd( 3 , 323 , 2000 , GetScriptAreaParams "AirSouz" );
end;
-----------------------Objective
function Objective()
	Wait( 2 );
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0", 1 );
	StartThread( CompleteObjective0 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea( 0 , "Forse1" , 0 ) > 0) or (GetNUnitsInArea( 0 , "Forse2" , 0 ) > 0) or (GetNUnitsInArea( 0 , "Forse3" , 0 ) > 0) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective0", 2 );
			Wait( 3 );
			StartThread( Objective1 );
			StartThread( ReinfUp );
			break;
		end;	
	end;
end;
function Objective1()
	Wait( 2 );
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1", 1 );
	StartThread( CompleteObjective1 );
end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 0 , "ReinfZone" , 0 ) > 0 then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.objective1", 2 );
			Wait( 3 );
			StartThread( Objective2 );
			StartThread( Objective1check );
			break;
		end;	
	end;
end;
function Objective1check()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 0 , "ReinfZone" , 0 ) < 1 then
			Wait( 3 );
			StartThread( Objective1 );
			break;
		end;	
	end;
end;
function Objective2()
	Wait( 2 );
	ObjectiveChanged(2, 1); 
	SetIGlobalVar( "temp.objective2", 1 );
	StartThread( CompleteObjective2 );
end;
function CompleteObjective2()
	while 1 do
		Wait( 3 );
		if GetNUnitsInArea( 0 , "TownMain" , 0 ) > 0 and GetNUnitsInArea( 1 , "TownMain" , 0 ) < 1 then
			ObjectiveChanged(2, 2);
			SetIGlobalVar( "temp.objective2", 2 );
			Wait( 3 );
			break;
		end;	
	end;
end;
------------------------WIn_Loose
function Winn()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea( 0 , "TownMain" , 0 ) > 0 and GetNUnitsInArea( 1 , "TownMain" , 0 ) < 1) and GetNUnitsInArea( 0 , "ReinfZone" , 0 ) > 0 then
			Wait( 3 );
			WOL = 1;
			StartThread( Winner );
			Win(0);
			break;
		end;
	end;
end;
function Winner()
	Wait( 3 );
	Win(0);
end;
function Unlucky()
	while 1 do
		Wait( 3 );
        if ( GetNUnitsInParty( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) and (WOL == 0) then
			Wait( 3 );
			WOL = 1;
			Win(1);
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Objective );
StartThread( Unlucky );
StartThread( Winn );

StartThread( Start );
StartThread( Guard );