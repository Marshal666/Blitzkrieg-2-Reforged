loose = 0;
win = 0;
function Objective1()
	Wait(18);
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective.0", 1 );
	StartThread( CompleteObjective1 );

end;
function Objective2()
	Wait(10);
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
			LandReinforcement(1,1332,3,500);
			Wait(5);
			Cmd(3,500,100,GetScriptAreaParams("ArmorTrain"));
			StartThread( Objective2 );
			StartThread( TrainDead );
			StartThread( Attack2 );
			StartThread( Attack3 );
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
        if  ((GetNUnitsInScriptGroup(900, 0) < 1 or GetNUnitsInScriptGroup(902, 0) < 1) and win == 0) then
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
		Wait(150+Random(300));
		LandReinforcement(1,1145,0,100);
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
	LandReinforcement(1,1145,1,200);
	Wait(3);
	Cmd(3,200,100,GetScriptAreaParams("Station"));
end;
function Attack3()
	Wait(35);
	LandReinforcement(1,1146,2,300);
	Wait(3);
	Cmd(3,300,100,GetScriptAreaParams("Attack3"));
	QCmd(3,300,100,GetScriptAreaParams("Train"));
end;
---------------------------
StartThread( Unlucky );
StartThread( Objective1 );
StartThread( Reinforce );

