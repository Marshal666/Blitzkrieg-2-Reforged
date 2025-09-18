-- Romania

function Mine1()
local mine1 = GetNMinesInScriptArea ( 'Mine1');
	while 1 do
		Wait(3);
		if (mine1 - GetNMinesInScriptArea ( 'Mine1')) > 4 then
			CompleteObjective(0);
			return 1;
		end;
	end;
end;
function Mine2()
local mine2 = GetNMinesInScriptArea ( 'Mine2');
	while 1 do
		Wait(3);
		if (mine2 - GetNMinesInScriptArea ( 'Mine2')) > 4 then
			CompleteObjective(1);
			return 1;
		end;
	end;
end;
function Attack()
local a1 = 300;
local a2 = 301;
local a3 = "Mine1";
local a4 = "Shtab";
local pt = 1;
	StartThread(Reinf,a1,a2,a3,a4,pt);
	Wait(15);
a1 = 303;
a2 = 302;
a3 = "Mine2";
a4 = "Bat";
pt = 2;
	StartThread(Reinf,a1,a2,a3,a4,pt);
	Wait(300);
a1 = 300;
a2 = 301;
a3 = "Mine1";
a4 = "Shtab";
pt = 1;
	StartThread(Reinf,a1,a2,a3,a4,pt);	
end;
function Reinf(a1,a2,a3,a4,pt)
--Trace ( 'run= %g',a1 );


		LandReinforcementFromMap(3, "Attack1", pt, a1);
		Wait(1);
		Cmd( ACT_SWARM, a1, 100, GetScriptAreaParams (a3));
		QCmd( ACT_SWARM, a1, 100, GetScriptAreaParams (a4));
		Wait(10);
		LandReinforcementFromMap(3, "Attack2", pt, a2);
		Wait(1);
		Cmd( ACT_SWARM, a2, 100, GetScriptAreaParams (a3));
		QCmd( ACT_SWARM, a2, 100, GetScriptAreaParams (a4));
		return 0;

end;
function Panic(zona,go)
run = {}
run = GetUnitListInAreaArray ( 1, zona );
hp_squad = 100;
--hp_squad = GetObjectHPs (run[1]);
hp = (hp_squad*0.6);

	while 1 do
		for i = 1, run.n do
			if  GetObjectHPs (run[i]) <= hp and GetUnitRPGStats ( run[i])==0 then
			--Trace ( 'run= %g',GetObjectHPs (run[1]) );
			--Cmd( ACT_LEAVE, 1, 101);
			SwitchUnitLightFX ( run[i], 1 );
			UnitQCmd( ACT_MOVE, run[i], 100, GetScriptAreaParams (go));
			end;
		end;
		Wait(1);
	end;
end;
function Running1()
local zona,go;
while 1 do
	if GetNUnitsInArea(0, "P2", 0) > 0 or GetNUnitsInArea(3, "P2", 0) > 0 then
		zona = "P2";
		go = "Shtab";
		StartThread(Panic, zona,go);
		return 1		
	end;
	Wait(1);
	end;
end;
function Running2()
local zona1,go1;
while 1 do
	if GetNUnitsInArea(0, "P3", 0) > 0 or GetNUnitsInArea(3, "P3", 0) > 0 then
		zona1 = "P3";
		go1 ="Bat";
		StartThread(Panic, zona1,go1);
		return 1
	end;
	Wait(1);
	end;
end;
function Running3()
local zona2,go2;
while 1 do	
	if GetNUnitsInArea(0, "Bat", 0) > 0 or GetNUnitsInArea(3, "Bat", 0) > 0 then
		zona2 = "Bat";
		go2 ="By";
		StartThread(Panic, zona2,go2);
		return 1		
	end;
	Wait(1);
	end;
	
end;
function Patrol()
pat = 200

	while 1 do
		Cmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P4"));
		QCmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P1"));
		QCmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P2"));
		QCmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P1"));
		QCmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P3"));
		QCmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P1"));
		QCmd( ACT_SWARM, pat, 50, GetScriptAreaParams ("P4"));
		Wait(100);
		if GetNUnitsInScriptGroup(pat, 1 ) < 1 then
			LandReinforcementFromMap(1, "Patrol", 0, pat);
			Wait(1);
		end;
	
	end;
end;
function Loose()
    while 1 do
        if ( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
			Wait(2);
			Win(1);
			return 1;
		end;
	Wait(5);
	end;
end;
function Winner()
    while 1 do
		if (GetNUnitsInArea(0, "Shtab", 0) > 0 or GetNUnitsInArea(3, "Shtab", 0)) and GetNUnitsInArea(1, "Shtab", 0) < 1 then
			CompleteObjective(2);
			Wait(2);
			Win(0);
			return 1;
		end;
	Wait(2);
	end;
end;
-----------------------------------------
Wait(1);
GiveObjective( 0 );
Wait(1);
GiveObjective( 1 );
Wait(1);
GiveObjective( 2 );
Wait(2);
StartThread(Loose);
StartThread(Winner);
StartThread(Mine1);
StartThread(Mine2);
StartThread(Running1);
StartThread(Running2);
StartThread(Running3);
StartThread(Patrol);
Wait(300);
StartThread(Attack);