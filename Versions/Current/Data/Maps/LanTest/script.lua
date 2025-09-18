function Init()
	
	szCenterPointName = "BattleField";
	
	playerForcesID = {};
	playerForcesID.n = 2;
	playerForcesID[1] = 1;
	playerForcesID[2] = 2;

end;


function AddForces()
	while 1 do
		LandReinforcementFromMap( 0, "lantest", 0, playerForcesID[1] );
		LandReinforcementFromMap( 1, "lantest", 0, playerForcesID[2] );
		Wait(20);
	end;
end;

function KillEmAll()
	while 1 do
		local x, y, h
		x, y, h = GetScriptAreaParams("BattlePointPlayer0");
		Cmd(ACT_SWARM, playerForcesID[1], h, x, y);
		x, y, h = GetScriptAreaParams("BattlePointPlayer1");
		Cmd(ACT_SWARM, playerForcesID[2], h, x, y);
		Wait(10);
	end;
end;


Init();

StartThread(AddForces);
StartThread(KillEmAll);
