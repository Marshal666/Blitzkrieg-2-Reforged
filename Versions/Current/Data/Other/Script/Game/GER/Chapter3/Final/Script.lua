--Stalingrad all
missinend = 0;
x = 500 + Random(2);
-----------------------Objective
function Objective()
	Wait(10);
---RND
	Cmd(ACT_MOVE,400,100,GetScriptAreaParams("K" .. Random(4))); -- Katya1 rnd
	Cmd(ACT_MOVE,410,100,GetScriptAreaParams("Kt" .. Random(4))); -- Katya2 rnd
---
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective.0", 1 ); -- barrycad
	StartThread( CompleteObjective0 );
	Wait(20);
	ObjectiveChanged(1, 1);
	SetIGlobalVar( "temp.objective.1", 1 ); -- CTZ
	StartThread( CompleteObjective1 );
	Wait(20);
	ObjectiveChanged(2, 1);
	SetIGlobalVar( "temp.objective.2", 1 ); -- shtab
	StartThread( CompleteObjective2 );
--	break;
end;
function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "barrycad", 0) > 0) and (GetNUnitsInArea(1,"barrycad", 0) < 1)) then
			ObjectiveChanged(0, 2);
			SetIGlobalVar( "temp.objective.0", 2 );
			StartThread( ReturnObjective0 );
			Wait( 1 );
			break;
		end;
	end;
end;
function ReturnObjective0()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "barrycad", 0) < 1) and (GetNUnitsInArea(1,"barrycad", 0) > 0)) then
			SetIGlobalVar( "temp.objective.0", 1 );
			Wait( 1 );
			ObjectiveChanged(0, 1); 
			Wait( 1 );
			StartThread( CompleteObjective0 );
			break;
		end;
	end;

end;
function CompleteObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "CTZ", 0) > 0) and (GetNUnitsInArea(1, "CTZ", 0) < 1)) then
			ObjectiveChanged(1, 2);
			SetIGlobalVar( "temp.objective.1", 2 );
			StartThread( ReturnObjective1 );
			Wait( 1 );
			break;
		end;
	end;
end;
function ReturnObjective1()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "CTZ", 0) < 1) and (GetNUnitsInArea(1, "CTZ", 0) > 0)) then
			SetIGlobalVar( "temp.objective.1", 1 );
			Wait( 1 );
			ObjectiveChanged(1, 1); 
			Wait( 1 );
			StartThread( CompleteObjective1 );
			break;
		end;
	end;

end;
function CompleteObjective2()
	while 1 do
		Wait( 3 );
		if ((GetNUnitsInArea(0, "shtab", 0) > 0) and (GetNUnitsInArea(1, "shtab", 0) < 1)) then
			ObjectiveChanged(2, 2);
			SetIGlobalVar( "temp.objective.2", 2 );
			Wait( 1 );
			break;
		end;	
	end;
end;
function Reinforce()
local a;
	while 1 do
		a = Random(2);
		Wait(200+Random(200));
		if GetIGlobalVar( "temp.objective.2", 0 ) ~= 2 then
			if a == 1 then
				LandReinforcement(1,1145,0,100);
				StartThread( Attack1 );
				Wait(2);
			else
				LandReinforcement(1,1145,1,200);
				StartThread( Attack2 );
				Wait(2);
			end;
		else break;
		end;
	end;
end;
function Attack1()
local b = Random(3);
	if b == 1 then
		Wait(3);
		Cmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack10"));
		QCmd(ACT_SWARM,100,100,GetScriptAreaParams("barrycad"));
	end;
	if b == 2 then
		Wait(3);
		Cmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack10"));
		QCmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack11"));
		QCmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack12"));		
		QCmd(ACT_SWARM,100,100,GetScriptAreaParams("barrycad"));
	end;
	if b == 3 then 
		Wait(3);
		Cmd(ACT_SWARM,100,100,GetScriptAreaParams("Attack2" .. Random(2)));
	end;

end;
function Attack2()
local d = Random(3);
	if d == 1 then
		Wait(3);
		Cmd(ACT_SWARM,200,100,GetScriptAreaParams("Attack10"));
		QCmd(ACT_SWARM,200,100,GetScriptAreaParams("barrycad"));
	end;
	if d == 2 then
		Wait(3);
		Cmd(ACT_SWARM,200,100,GetScriptAreaParams("Attack10"));
		QCmd(ACT_SWARM,200,100,GetScriptAreaParams("Attack11"));
		QCmd(ACT_SWARM,200,100,GetScriptAreaParams("Attack12"));		
		QCmd(ACT_SWARM,200,100,GetScriptAreaParams("barrycad"));
	end;
	if d == 3 then 
		Wait(3);
		Cmd(ACT_SWARM,200,100,GetScriptAreaParams("Attack2" .. Random(2)));
	end;

end;
function Bridge()
	while 1 do
		Wait(1);
		if GetNUnitsInArea(0, "Bridge", 0) > 0 then
			DamageScriptObject(900,0);
			--StartThread( ReinfArt );
			break
		end;
	end;
end;
function Art()
	Wait(10);
	Cmd(ACT_SUPPRESS, x, 200, GetScriptAreaParams("Art1" .. x));
end;
function EndArt()
	Wait(30);
	Cmd(ACT_STOP, x, 0, GetScriptObjCoord(x));
end;
-----------------Patrol
function Patrol1()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 300, 1) > 0 ) then
			Wait(3);
			StartThread( Patrol11 );
			break
		end;
	end;
end;

function Patrol11 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 300, "P1" ) > 0 ) then
			Wait( 3 + RandomInt( 6 ) );
			Cmd(ACT_SWARM, 300, 10, GetScriptAreaParams("P2"));
			StartThread( Patrol12 );
			break
		end;		
	end;
end;
function Patrol12 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 300, "P2" ) > 0 ) then
			Wait( 3 + RandomInt( 6 ) );
			Cmd(ACT_SWARM, 300, 10, GetScriptAreaParams("P1"));
			StartThread( Patrol1 );
			break
		end;		
	end;
end;

function Patrol2()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 310, 1) > 0 ) then
			Wait(3);
			StartThread( Patrol21 );
			break
		end;
	end;
end;

function Patrol21 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 310, "P3" ) > 0 ) then
			Wait( 3 + RandomInt( 6 ) );
			Cmd(ACT_SWARM, 310, 10, GetScriptAreaParams("P4"));
			StartThread( Patrol22 );
			break
		end;		
	end;
end;
function Patrol22 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 310, "P4" ) > 0 ) then
			Wait( 3 + RandomInt( 6 ) );
			Cmd(ACT_SWARM, 310, 10, GetScriptAreaParams("P3"));
			StartThread( Patrol2 );
			break
		end;		
	end;
end;
function PatrolShip1()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 910, 1) > 0 ) then
			Wait(3);
			StartThread( PatrolShip11 );
			break
		end;
	end;
end;

function PatrolShip11 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 910, "Ship1" ) > 0 ) then
			Wait( 3 + RandomInt( 6 ) );
			Cmd(ACT_SWARM, 910, 10, GetScriptAreaParams("Ship2"));
			StartThread( PatrolShip12 );
			break
		end;		
	end;
end;
function PatrolShip12 ()
	while 1 do
		Wait(3);
		if ( GetNScriptUnitsInArea ( 910, "Ship2" ) > 0 ) then
			Wait( 3 + RandomInt( 6 ) );
			Cmd(ACT_SWARM, 910, 10, GetScriptAreaParams("Ship1"));
			StartThread( PatrolShip1 );
			break
		end;		
	end;
end;
------------------------WIn_Loose
function Winner()
	while 1 do
		Wait( 3 );
		if ((GetIGlobalVar("temp.objective.0", 1) == 2) and (GetIGlobalVar("temp.objective.1", 1) == 2) and (GetIGlobalVar("temp.objective.2", 1) == 2)) then
			Wait( 3 );
			missionend = 1;
			Win(0);
			break;
		end;
	end;

end;
function Unlucky()
	while 1 do
		Wait( 3 );
        if (GetNUnitsInParty(0) < 1 and GetReinforcementCallsLeft( 0 ) == 0 and missionend == 0) then
			Win(1);
			break;
		end;
	end;
end;
-------------------------------------------  MAIN
StartThread( Unlucky );
StartThread( Winner );
StartThread( Objective );
StartThread( Reinforce );
StartThread( Bridge );
--StartThread( Art );
--StartThread( EndArt );
StartThread( Patrol1 );
StartThread( Patrol2 );