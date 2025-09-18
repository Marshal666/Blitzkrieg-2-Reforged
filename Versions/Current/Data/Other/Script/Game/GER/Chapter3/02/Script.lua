-- Konvoy
function Objective0()
	SetIGlobalVar( "temp.nogeneral_sript", 1 ); --end AI
	Wait(10);
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective.0", 1 );
	StartThread( CompleteObjective0 );
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if GetNScriptUnitsInArea(500, "Objective", 0) > 1 then
			ObjectiveChanged(0, 2); 
			SetIGlobalVar( "temp.objective.0", 2 );
			Win (0);
			Wait( 1 );
			break;
		end;
	end;
end;
--Zasada--
function Zasada1()
	while 1 do
		Wait(1);
		if GetNUnitsInArea(0, "Zasada1", 0) > 0 then
			LandReinforcement(1,1145,2,200);
			Wait(1);
			StartThread( AttackZasada1 );
			break;
		end;
	end;
end;
function AttackZasada1()
	while 1 do
		Wait(1);
		if GetNUnitsInScriptGroup(200, 1) > 0 then
			Cmd(ACT_SWARM,200,100,GetScriptObjCoord(500));
			Wait(5);
		else	break;
		end;
	end;
end;
function Zasada2()
	while 1 do
		Wait(1);
		if GetNUnitsInArea(0, "Zasada2", 0) > 0 then
			LandReinforcement(1,1145,2,300);
			LandReinforcement(1,1145,1,300);
			Wait(1);
			StartThread( AttackZasada2 );
			break;
		end;
	end;
end;
function AttackZasada2()
	while 1 do
		Wait(1);
		if GetNUnitsInScriptGroup(300, 1) > 0 then
			Cmd(ACT_SWARM,300,100,GetScriptObjCoord(500));
			Wait(5);
		else	break;
		end;
	end;
end;
function Zasada3()
	while 1 do
		Wait(1);
		if GetNUnitsInArea(0, "Zasada3", 0) > 0 then
			LandReinforcement(1,1145,0,400);
			LandReinforcement(1,1145,1,400);
			Wait(1);
			StartThread( AttackZasada3 );
			break;
		end;
	end;
end;
function AttackZasada3()
	while 1 do
		Wait(1);
		if GetNUnitsInScriptGroup(400, 1) > 0 then
			Cmd(ACT_SWARM,400,100,GetScriptObjCoord(500));
			Wait(5);
		else	break;
		end;
	end;
end;
--END_ZASADA--
function Loose()
	while 1 do
		Wait( 3 );
        if  (GetNUnitsInScriptGroup(500, 0) < 2 or GetScriptObjectHPs(901) <= 0 or GetScriptObjectHPs(902) <= 0) then
			FailObjective ( 0 );
			Win(1);
			break;
		end;
	end;
end;
function Bridge()
	while 1 do
		Wait(1);
		if GetNUnitsInArea(1, "Attack1", 0) > 0 then
			DamageScriptObject(900,0);
			StartThread( AttackObjective );
			break;
		end;
	end;
end;
function Reinforce()
local a;
	while 1 do
		a = Random(3);
		Wait(90);
		if a == 1 then
			LandReinforcement(1,1145,1,100);
			StartThread( Attack );
			--Wait(2);
		end;
		if a == 2 then
			LandReinforcement(1,1145,2,100);
			StartThread( Attack3 );
			--Wait(2);
		end;
		if a == 3 then
			LandReinforcement(1,1145,0,101);
			StartThread( AttackObjective );
			--Wait(2);
		end;
		
	end;
end;
function Attack()
	Wait(3);
	Cmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack2"));
	QCmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack1"));
	QCmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack3"));
end;
function AttackObjective()
	Wait(3);
	Cmd(ACT_SWARM,101,100,GetScriptAreaParams("Objective"));
end;
function Attack3()
	Wait(3);
	Cmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack3"));
	QCmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack2"));
	QCmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack1"));
end;
function Prikol()
	while 1 do
		Wait( 3 );
		if GetNScriptUnitsInArea(500, "Zasada1", 0) > 0 then
			LandReinforcement(2,1340,0,600);
			Wait(3);
			Cmd(ACT_SWARM,600,100,GetScriptAreaParams("Attack1"));
			Wait(12);
			LandReinforcement(2,320,0,700);
			Cmd(ACT_SWARM,700,100,GetScriptAreaParams("Attack1"));
			break;
		end;
	end;
end;
------------------------
StartThread( Objective0 );
StartThread( Loose );
StartThread( Bridge );
StartThread( Reinforce );
StartThread( Zasada1 );
StartThread( Zasada2 );
StartThread( Zasada3 );
StartThread( Prikol );