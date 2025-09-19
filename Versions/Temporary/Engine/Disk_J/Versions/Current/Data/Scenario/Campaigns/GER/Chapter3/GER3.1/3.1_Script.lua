loose = 0;

win = 0;

function Objective1()
	Wait(5);
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective.0", 1 );
	StartThread( CompleteObjective1 );
end;

function Objective2()
	Wait(5);
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective.1", 1 );
	StartThread( CompleteObjective2 );
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "Station", 0) > 0) and (GetNUnitsInArea(1, "Station", 0) < 1)) then
			CompleteObjective( 0 );
			SetIGlobalVar( "temp.objective.0", 2 );
			ChangePlayerForScriptGroup (900, 0);
			ChangePlayerForScriptGroup (901, 0);
			ChangePlayerForScriptGroup (902, 0);
			ChangePlayerForScriptGroup (903, 0);
			ChangePlayerForScriptGroup (904, 0);
			LandReinforcementFromMap(1,"1332",3,500);
			Wait(3);
			Cmd(0,500,0,GetScriptAreaParams("ArmorTrain"));
			StartThread( Objective2 );
			StartThread( TrainDead );
			StartThread( Train_go );
			Wait( 1 );
			break;
		end;
	end;
end;

function CompleteObjective2()
	while 1 do
		Wait( 3 );
		if  GetNScriptUnitsInArea(900, "Train", 0) > 0 then
			CompleteObjective( 1 );
			SetIGlobalVar( "temp.objective.1", 2 );
			win = 1;
			Wait( 1 );
			RemoveScriptGroup( 900 );
			RemoveScriptGroup( 901 );
			RemoveScriptGroup( 902 );
			RemoveScriptGroup( 903 );
			RemoveScriptGroup( 904 );
			Win(0);
			break;
		end;
	end;
end;

function Unlucky()
	while 1 do
		Wait( 3 );
        if ( GetNUnitsInParty(0) < 1 and GetReinforcementCallsLeft( 0 ) == 0 and loose == 0) then
			Win(1);
			break;
		end;
	end;
end;

function TrainDead()
	while 1 do
		Wait( 3 );
        if  ((GetNUnitsInScriptGroup(900, 0) < 1 or GetNUnitsInScriptGroup (901, 0) <1 or 
			GetNUnitsInScriptGroup(902, 0) < 1) and win == 0) then
			FailObjective( 1 );
			loose = 1;
			Win(1);
			break;
		end;
	end;
end;

function Reinforce()

local a = Random(2);

	for u = 1, 2 do
		Wait(180+Random(200));
		LandReinforcementFromMap(1,"1145",0,100);
		if a == 1 then
			StartThread( Attack1 );
		else
			StartThread( Attack11 );
		end;
	end;
end;

function Attack1()
	Wait(3);
	Cmd(3,100,100,GetScriptAreaParams("Attack1"));
	QCmd(3,100,100,GetScriptAreaParams("Attack11"));
	QCmd(3,100,100,GetScriptAreaParams("Train"));
end;

function Attack11()
	Wait(3);
	Cmd(3,100,100,GetScriptAreaParams("Attack2"));
	QCmd(3,100,100,GetScriptAreaParams("Attack21"));
	QCmd(3,100,100,GetScriptAreaParams("Train"));
end;

function Attack2()
	Wait(25);
	LandReinforcementFromMap(1,"1145",1,200);
	Wait(3);
	Cmd(3,200,100,GetScriptAreaParams("Station"));
end;

function Attack3()
	Wait(35);
	LandReinforcementFromMap(1,"1146",2,300);
	Wait(3);
	Cmd(3,300,100,GetScriptAreaParams("Attack3"));
	QCmd(3,300,100,GetScriptAreaParams("Train"));
end;
---------------------------DB_add_on
function Patrol1()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(621, "IP1") > 0)then
			Wait( 10 + Random( 20 ) )
			QCmd(ACT_SWARM, 621, 0, GetScriptAreaParams( "IP2" ) );
			StartThread( Patrol1_1 );
			break;
		end;	
	end;
end;

function Patrol1_1()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(621, "IP2") > 0)then
			Wait( 10 + Random( 20 ) )
			QCmd(ACT_SWARM, 621, 0, GetScriptAreaParams( "IP1" ) );
			StartThread( Patrol1 );
			break;
		end;	
	end;
end;

function Tiger()
	while 1 do
		Wait( 3 );
		if (GetScriptObjectHPs(721) >= 200) then
			ChangePlayerForScriptGroup( 721, 0 );  
			break;
		end;	
	end;
end;


function D_L()
	Wait(2);
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1001);
		RemoveScriptGroup(1002);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1002);
	end;
end;
------------------------
function Flaks()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "FLAK",0) > 0) then
			Wait( 3 );
			Cmd(ACT_LEAVE, 553, 0, 4177, 4697 );
			Cmd(ACT_LEAVE, 554, 0, 4177, 4697 );
			QCmd(ACT_TAKE_ARTILLERY, 553, 433 );
			QCmd(ACT_TAKE_ARTILLERY, 554, 432 );
			break;
		end;	
	end;
end;
-----------------------
function Rus_as()
	while 1 do
		Wait( 3 );
		if ( GetNUnitsInScriptGroup( 475 ) < 1 ) then
			Wait( 3 );
			Cmd(ACT_LEAVE, 477, 0, 6255, 5538 );
			Cmd(ACT_LEAVE, 476, 0, 6255, 5538 );
			QCmd(ACT_SWARM, 477, 0, 6348, 1682 );
			QCmd(ACT_SWARM, 476, 0, 6348, 1682 );
			break;
		end;	
	end;
end;
----------------------------------
function Train_go()
	while 1 do
		Wait( 3 );
		if  GetNScriptUnitsInArea(900, "AT_GO", 0) > 0 then
			Wait( 1 );
			StartThread( Attack2 );
			StartThread( Attack3 );
			Wait( 1 );
			break;
		end;
	end;
end;
------------------------------------------------------
function Defead()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(3);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;

function Bon()
	while 1 do
		Wait( 3 );
		if (GetNUnitsInArea(0, "TIGRA",0) > 0) then
			Wait( 1 );
			GiveObjective( 2 );
			CompleteObjective( 2 );
			break;
		end;	
	end;
end;
------------------------------
function ALERT_1()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(900, "AT_GO") > 0) then
			LandReinforcementFromMap(1,"1146",2,391);
			Wait(1);
			Cmd(3,391,0,GetScriptAreaParams("Y11"));
			QCmd(3,391,0,GetScriptAreaParams("Y22"));
			QCmd(3,391,0,GetScriptAreaParams("Y33"));
			break;
		end;	
	end;
end;

function ALERT_2()
	while 1 do
		Wait( 3 );
		if (GetNScriptUnitsInArea(900, "AT_GO") > 0) then
			LandReinforcementFromMap(1,"1146",0,392);
			Wait(1);
			Cmd(0,392,0,GetScriptAreaParams("Z11"));
			QCmd(0,392,0,GetScriptAreaParams("Z22"));
			QCmd(8,392,0,GetScriptAreaParams("Z33"));
			break;
		end;	
	end;
end;
---------------------------

StartThread( Unlucky );

StartThread( Objective1 );

StartThread( Reinforce );

StartThread( Patrol1 );
StartThread( Tiger );
StartThread( D_L );
StartThread( Defead );
StartThread( Flaks );
StartThread( Rus_as );
StartThread( Bon );

StartThread( ALERT_1 );
StartThread( ALERT_2 );