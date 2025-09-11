--------------------------------------------------------------------------------
j = 0;
OnPlace = 0;
Dead = 0;

__AUTO_ID = 2000;

function AutoID ()
	__AUTO_ID = __AUTO_ID + 1;
	return __AUTO_ID;
end;

BoatsID = 1100;
--------------------------------------------------------------------------------
ID_ALLIED_FIGHTERS	= AutoID ();
ID_ALLIED_CONVOY	= AutoID ();
ID_ALLIED_BOATS1	= AutoID ();
ID_ALLIED_BOATS2	= AutoID ();

ID_GERMAN_GAP 		= AutoID ();
ID_GERMAN_BOMBERS 	= AutoID ();
ID_GERMAN_BOATS1 	= AutoID ();
ID_GERMAN_BOATS2 	= AutoID ();
ID_GERMAN_BOATS3 	= AutoID ();

ID_GERMAN_TROOPERS1	= AutoID ();
ID_GERMAN_TROOPERS2	= AutoID ();
ID_GERMAN_TROOPERS3	= AutoID ();
ID_GERMAN_TROOPERS4	= AutoID ();

--------------------------------------------------------------------------------

ID_COAST_GUN1 	= 499;
ID_COAST_GUN2 	= 500;
ID_FLAK_GUNS 	= 501;

--------------------------------------------------------------------------------

ID_PLAYER 	= 0;
ID_GERMANS 	= 1;
ID_ALLIES 	= 2;

--------------------------------------------------------------------------------

ID_OBJ_DEFEND_GUNS 		= 0;
ID_OBJ_DEFEND_CONVOYS 	= 1;


--------------------------------------------------------------------------------
function poteha(height,id,N,delay)
	
	

	local array = 
{
1705, 8282,
1825, 8296
}
x1 = array[1];
y1 = array[2];
x2 = array[3];
y2 = array[4];

	for i=1,N do
		PlayEffect(id,x1+i*((x2-x1)/N),y1+i*((y2-y1)/N),height);
		Wait(delay);
	end;
end;


function kaput1()
	Wait(1);
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(1100) > 0) then
			if (GetNUnitsInScriptGroup(ID_COAST_GUN1)==0 and GetNUnitsInScriptGroup(ID_COAST_GUN1)==0) then
				Win(1);
				break;
			end;
		else
			Trace("Enemy sheeps was destroyed.");
			break;
		end;
	end;
end;



function ship_explosive()
	InitialHPs = GetScriptObjectHPs(1000);
	while 1 do
		Wait(1);
		if (GetScriptObjectHPs(1000) < InitialHPs/2) then
			local x,y = GetScriptObjCoord(1000);
			PlayEffect(0,x,y,0);
			DamageScriptObject(1000,0);
			break;
		end;
	end;
end;


function bombers()
	while 1 do
		Wait(6);
		if GetNUnitsInScriptGroup(1100) < 4 then
			Trace("Enemy bombers have been landed...");
			Wait(20);
			LandReinforcementFromMap(1,"GermanBomber",0,9091);
			Cmd(ACT_MOVE,9091,0,GetScriptAreaParams("Area_FlakGuns"));
			break;
		end;
	end;
end;

function recon()
	Wait(5);
	while 1 do
		Wait(6);
		if GetNUnitsInScriptGroup(9090) == 0 then
			Trace("Recon Plane has been landed...");
			LandReinforcementFromMap(0,"recon",0,9090);
			Cmd(ACT_MOVE,9090,0,GetScriptAreaParams("recon1"));
		end;
		if GetNUnitsInScriptGroup(9091) == 0 then
			Trace("Recon Plane has been landed...");
			LandReinforcementFromMap(0,"recon",0,9091);
			Cmd(ACT_MOVE,9091,0,GetScriptAreaParams("recon2"));
		end;
		if GetNUnitsInScriptGroup(9092) == 0 then
			Trace("Recon Plane has been landed...");
			LandReinforcementFromMap(0,"recon",0,9092);
			Cmd(ACT_MOVE,9092,0,GetScriptAreaParams("recon3"));
		end;
	end;
end;

function GAP()
	Wait(15);
	while 1 do
		Wait(6);
		if GetNUnitsInScriptGroup(9093) == 0 then
			Trace("Recon Plane has been landed...");
			LandReinforcementFromMap(0,"gap",0,9093);
			Cmd(ACT_MOVE,9093,0,GetScriptAreaParams("recon1"));
		end;
	end;
end;


function CallOutAlliedFighters ()
	Wait (60);
	
	-- Call out allied fighters to help us to defend the guns
	LandReinforcementFromMap (ID_ALLIES, "AlliedFighters", 0, ID_ALLIED_FIGHTERS);
	Cmd (ACT_SWARM, ID_ALLIED_FIGHTERS, 50, GetScriptAreaParams ("Area_CoastGuns"));

	while (1) do
		Wait (10);
		
		-- The germans was defeated - return planes to base
		if (GetNUnitsInParty (ID_GERMANS)==0) then
			Cmd (ACT_MOVE, ID_ALLIED_FIGHTERS, 50, GetScriptAreaParams ("Area_Escape"));
			QCmd (ACT_DISAPPEAR, ID_ALLIED_FIGHTERS);
			break;
		end;
		
	end;
end

--------------------------------------------------------------------------------

function AttackCoastGuns ()
	Wait(30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("Area_CoastGuns"));
	Wait(20);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("Area_CoastGuns"));
	Wait(30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("Area_CoastGuns"));
	Wait(20);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("Area_CoastGuns"));
	Wait(10);
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS1);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("WLandingZone1"));
	Wait(4);
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS2);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("WLandingZone2"));
	--Wait(4);
	--LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS3);
	--Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("WLandingZone3"));
	StartThread(ForceToGuns);
	Wait (20);
	-- German planes should attack guns' position
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("Area_CoastGuns"));
end;

function ForceToGuns() 
	while (1) do
		Wait (5);
		
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("Area_CoastGuns"));
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("Area_CoastGuns"));
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("Area_CoastGuns"));
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("Area_CoastGuns"));
		
		if 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS1)==0 and 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS2)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS3)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS4)==0
		then
			Trace("All paratroops has been destroyed...");
			Wait(3);
			CompleteObjective(0);
			Wait(2);
			GiveObjective(1);
			Wait(5);
			StartThread(konvoi);
			StartThread(CompleteObjective1);
			StartThread(recon);
			StartThread(GAP);
			StartThread(kaput);
			break;
		end
		
		if (GetNUnitsInArea (ID_GERMANS, "Area_CoastGuns", 0) > 0) then
			Wait(3);
			DamageScriptObject (ID_COAST_GUN1, 0);
			local x1,y1 = GetScriptObjCoord(ID_COAST_GUN1);
			local x2,y2 = GetScriptObjCoord(ID_COAST_GUN2);
			PlayEffect(0,x1,y1,280);
			Wait(3);
			PlayEffect(1,x1,y1,280);
			DamageScriptObject(ID_COAST_GUN2, 0);
			PlayEffect(0,x2,y2,280);
			Wait(3);
			PlayEffect(1,x2,y2,280);
			Trace ("Coast guns was destroyed...");
			break;
		end;
	end;

end;

function CompleteObjective1()
	while 1 do
		Wait(1);
		if OnPlace > 3 then
			Wait(1);
			CompleteObjective(1);
			Wait(2);
			Win(0);
			break;
		end;
	end;
end;

function kaput()
	while 1 do
		Wait(1);
		if Dead > 2 then	
			Trace("%g ships have been lost",Dead);
			Wait(3);
			Win(1);
			break;
		end;
	end;
end;

function dead(ID)
	Trace("Thread dead has been started. Ship ID = %g",ID);
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(ID,"ConvoyTarget",0)>0) then
			Trace("Ship has arrived to destination point. ScriptID = %g",ID);
			Cmd(ACT_DISAPPEAR,ID);
			OnPlace = OnPlace + 1;
			Trace("OnPlace = %g",OnPlace);
			break;
		else
			if (GetNUnitsInScriptGroup(ID)==0) then
				Trace("Ship has died. ScriptID = %g",ID);
				Dead = Dead + 1;
				Trace("Dead = %g",Dead);
				break;
			end;
		end;
	end;
end;

function konvoi()
	LandReinforcementFromMap(2,"AlliedBoats",1,1000);
	Cmd(ACT_SWARM,1000,0,GetScriptAreaParams("ConvoyWP1"));
	Wait(2);
	StartThread(ship_explosive);
	Wait(10);
	LandReinforcementFromMap(2,"AlliedBoats",1,1001);
	Cmd(ACT_MOVE,1001,0,GetScriptAreaParams("WaitingZone"));
	QCmd(ACT_STAND,1001);
	Wait(20);
	LandReinforcementFromMap(2,"AlliedConvoy",1,1001);
	Cmd(ACT_MOVE,1001,0,GetScriptAreaParams("WaitingZone"));
	QCmd(ACT_STAND,1001);
	StartThread(poplyli);
	--StartThread(AlliedReconnaissance);
end;


function poplyli()
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(1100,1)==0) then
			Cmd(ACT_MOVE,1001,300,"ConvoyWP1");
			QCmd(ACT_MOVE,1001,300,"ConvoyWP2");
			QCmd(ACT_MOVE,1001,300,"ConvoyTarget");
			Wait(1);
			StartThread(dead,1001);
			StartThread(EnemyShips);
			StartThread(EnemyPlanes);
			Wait(30);
			for i=1,5 do
				Trace("Ship has arrived. Start Point. ScriptID = %g",1001+i);
				LandReinforcementFromMap(2,"AlliedConvoy",1,1001+i);
				Cmd(ACT_MOVE,1001+i,300,"ConvoyWP1");
				QCmd(ACT_MOVE,1001+i,300,"ConvoyWP2");
				QCmd(ACT_MOVE,1001+i,300,"ConvoyTarget");
				Wait(1);
				StartThread(dead,1001+i);
				Wait(25);
			end;
			break;
		end;
	end;
end;

function EnemyShips()
	Trace("Enemy Ships arriving...");
	local x = 0;
	while 1 do
		Wait(2);
		if (GetNUnitsInScriptGroup(1150)==0) then
			LandReinforcementFromMap(1,"GermanBoats",0,1150);
			Wait(1);
			Trace("Ship has landed...");
			Cmd(ACT_SWARM,1150,0,GetScriptAreaParams("SwarmPoint"));
			--QCmd(ACT_STAND,1150);
			x = x+1;
			if x==3 then
				Trace("Enemy don't have more ships...");
				break;
			end;
		end;
	end;
end;

function EnemyPlanes()
	Wait(10);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("ConvoyWP1"));
	StartThread(attack_ship,ID_GERMAN_GAP);
	Wait(20);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("ConvoyWP1"));
	StartThread(attack_ship,ID_GERMAN_GAP);
	Wait(30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("ConvoyWP2"));
	StartThread(attack_ship,ID_GERMAN_GAP);
	Wait(30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("ConvoyWP2"));
	StartThread(attack_ship,ID_GERMAN_GAP);
	Wait(30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, 9001);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("ConvoyWP2"));
	StartThread(attack_ship,ID_GERMAN_GAP);
	Wait(10);
	LandReinforcementFromMap (ID_GERMANS, "GermanFighters", 0, 9101);
	Cmd (ACT_MOVE, 9101, 500, GetScriptAreaParams ("ConvoyWP2"));
	Trace("Fighters have arrived...")
	Wait(30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 500, GetScriptAreaParams ("ConvoyWP2"));
	StartThread(attack_ship,ID_GERMAN_GAP);
end;

function attack_ship(ScriptID)
	while 1 do
		Wait(1);
		for i=1,5 do
			while IsAlive(GetObjectList(1100+i))==1 do
				Cmd(ACT_ATTACKUNIT,ScriptID,1000+i);
				Wait(5);
			end;
		end;
	end;
end;
--------------------------------------------------------------------------------

function AlliedReconnaissance ()

	while (1) do
		ID_ALLIED_RECON = AutoID ();
		
		if (IsSomeBodyAlive (ID_ALLIES, ID_ALLIED_RECON)<3) then
			LandReinforcementFromMap (ID_ALLIES, "AlliedReconPlane", 2, ID_ALLIED_RECON);
			for i = 1,5 do
				QCmd (ACT_MOVE, ID_ALLIED_RECON, 50, GetScriptAreaParams ("Area_Recon"..Random(8)));
			end;
			QCmd (ACT_MOVE, ID_ALLIED_RECON, 50, GetScriptAreaParams ("ConvoyTarget"));
			QCmd (ACT_DISAPPEAR, ID_ALLIED_RECON);
		end;
		Wait (30);
	end;

end;

--------------------------------------------------------------------------------

function LandingParty2 ()
	
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS1);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("ELandingZone1"));

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS2);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("ELandingZone2"));

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS3);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("ELandingZone3"));

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS4);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("ELandingZone4"));

	Wait (10);

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("Area_CoastGuns"));

	while (1) do
		Wait (5);

		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("Area_CoastGuns"));
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("Area_CoastGuns"));
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("Area_CoastGuns"));
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("Area_CoastGuns"));
		
		if (GetNScriptUnitsInArea (ID_GERMANS, "Area_CoastGuns", 0) > 0) then
			SetScripObjectHPs (ID_COAST_GUN1, 0);
			SetScripObjectHPs (ID_COAST_GUN2, 0);
			break;
		end;
		
		if 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS1)==0 and 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS2)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS3)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS4)==0
		then
			break;
		end
	end;

end;

--------------------------------------------------------------------------------

function DefendGuns ()
	while (1) do
		Wait(2);
		-- Check if the objective 0 (defend the guns) is failed
		if 
			IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUN1)==0 and 
			IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUN2)==0 
		then
			Wait (3);
			Win(1);
			break;
		end;
	end;
end;

--------------------------------------------------------------------------------
GiveObjective (ID_OBJ_DEFEND_GUNS);
--GiveObjective (1);
--StartThread(konvoi);
--StartThread(CompleteObjective1);
StartThread (DefendGuns);
StartThread (AttackCoastGuns);
StartThread (CallOutAlliedFighters);
StartThread(bombers);
--StartThread(kaput1);