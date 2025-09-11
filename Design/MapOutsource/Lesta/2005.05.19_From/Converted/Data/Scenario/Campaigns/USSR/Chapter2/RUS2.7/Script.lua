--------------------------------------------------------------------------------

__AUTO_ID = 2000;

function AutoID ()
	__AUTO_ID = __AUTO_ID + 1;
	return __AUTO_ID;
end;

--------------------------------------------------------------------------------

ID_ALLIED_FIGHTERS	= AutoID ();
ID_ALLIED_CONVOY	= AutoID ();
ID_ALLIED_BOATS1	= AutoID ();
ID_ALLIED_BOATS2	= AutoID ();

ID_GERMAN_GAP 		= AutoID ();
ID_GERMAN_BOMBERS 	= AutoID ();
ID_GERMAN_TROOPERS 	= AutoID ();
ID_GERMAN_BOATS1 	= AutoID ();
ID_GERMAN_BOATS2 	= AutoID ();
ID_GERMAN_BOATS3 	= AutoID ();

--------------------------------------------------------------------------------

ID_COAST_GUNS 	= 500;
ID_FLAK_GUNS 	= 501;

--------------------------------------------------------------------------------

ID_PLAYER 	= 0;
ID_GERMANS 	= 1;
ID_ALLIES 	= 2;

--------------------------------------------------------------------------------

ID_OBJ_DEFEND_GUNS 		= 0;
ID_OBJ_DEFEND_CONVOYS 	= 1;

--------------------------------------------------------------------------------

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

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS, 50, GetScriptAreaParams ("Area_LandingZone"));

	Wait (25);

	-- German planes should attack guns' position
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("Area_CoastGuns"));

	LandReinforcementFromMap (ID_GERMANS, "GermanBomber", 0, ID_GERMAN_BOMBERS);
	Wait(2)
	LandReinforcementFromMap (ID_GERMANS, "GermanBomber", 0, ID_GERMAN_BOMBERS);
	Wait(2)
	LandReinforcementFromMap (ID_GERMANS, "GermanBomber", 0, ID_GERMAN_BOMBERS);
	Cmd (ACT_MOVE, ID_GERMAN_BOMBERS, 50, GetScriptAreaParams ("Area_CoastGuns"));

	while (1) do
		Wait (5);
		
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS, 50, GetScriptAreaParams ("Area_FlakGuns"));
		
		if (IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS)==0) then
			break;
		end
		
		if (IsSomeBodyAlive (ID_PLAYER, ID_FLAK_GUNS)==0) then
			-- Flak guns destroyed - call off the attacking forces
			Cmd (ACT_MOVE, ID_GERMAN_TROOPERS, 50, GetScriptAreaParams ("Area_Escape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_TROOPERS);
			break;
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
	
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS);
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS, 50, GetScriptAreaParams ("Area_EastLandingZone"));
	QCmd (ACT_SWARM, ID_GERMAN_TROOPERS, 50, GetScriptAreaParams ("Area_CoastGuns"));

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
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS, 50, GetScriptAreaParams ("Area_CoastGuns"));
		
		if (GetNScriptUnitsInArea (ID_GERMANS, "Area_CoastGuns", false) > 0) then
			DamageScriptObject (ID_COAST_GUNS, 10000);
			break;
		end;
		
		if (IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS)==0) then
			break;
		end;
	end;

end;

--------------------------------------------------------------------------------

function DefendConvoys ()
	
	StartThread (AlliedReconnaissance)

	-- Give some time to player to rearrange his troops after the first attack

	Wait (30);

	LandReinforcementFromMap (ID_ALLIES, "AlliedBoats", 1, ID_ALLIED_BOATS1);
	Cmd (ACT_SWARM, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));

	LandReinforcementFromMap (ID_GERMANS, "GermanBoats", 0, ID_GERMAN_BOATS1);
	Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));
	Wait (10);
	Cmd (ACT_SWARM, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));

	GiveObjective (ID_OBJ_DEFEND_CONVOYS);

	LandReinforcementFromMap (ID_ALLIES, "AlliedConvoy", 1, ID_ALLIED_CONVOY);
	Cmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP1"));
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP2"));
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyTarget"));

	LandReinforcementFromMap (ID_GERMANS, "GermanBoats", 0, ID_GERMAN_BOATS1);
	Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));
	Wait (10);
	Cmd (ACT_SWARM, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));

	LandReinforcementFromMap (ID_ALLIES, "AlliedBoats", 1, ID_ALLIED_BOATS2);
	Cmd (ACT_FOLLOW, ID_ALLIED_BOATS2, ID_ALLIED_CONVOY);

	LandReinforcementFromMap (ID_GERMANS, "GermanBoats", 0, ID_GERMAN_BOATS2);
	Cmd (ACT_MOVE, ID_GERMAN_BOATS2, 50, GetScriptAreaParams ("ConvoyWP1"));
	Wait (10);
	Cmd (ACT_SWARM, ID_GERMAN_BOATS2, 50, GetScriptAreaParams ("ConvoyWP2"));

	LandReinforcementFromMap (ID_GERMANS, "GermanBoats", 0, ID_GERMAN_BOATS3);
	Cmd (ACT_MOVE, ID_GERMAN_BOATS3, 50, GetScriptAreaParams ("ConvoyWP1"));
	Wait (10);
	Cmd (ACT_SWARM, ID_GERMAN_BOATS3, 50, GetScriptAreaParams ("ConvoyTarget"));

	while (1) do
		Wait (5);
		
		-- Check if the convoy arrived at its destination point
		if (GetNScriptUnitsInArea (ID_ALLIED_CONVOY, "ConvoyTarget", false) > 0) then
			
			QCmd (ACT_DISAPPEAR, ID_ALLIED_CONVOY);
			
			Cmd (ACT_MOVE, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyTarget"));
			QCmd (ACT_DISAPPEAR, ID_ALLIED_BOATS1);
			
			Cmd (ACT_MOVE, ID_ALLIED_BOATS2, 50, GetScriptAreaParams ("ConvoyTarget"));
			QCmd (ACT_DISAPPEAR, ID_ALLIED_BOATS2);
			
			Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("GermanBoatsEscape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS1);
			
			Cmd (ACT_MOVE, ID_GERMAN_BOATS2, 50, GetScriptAreaParams ("GermanBoatsEscape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS1);
			
			Cmd (ACT_MOVE, ID_GERMAN_BOATS3, 50, GetScriptAreaParams ("GermanBoatsEscape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS1);
			
			break;
			
		else
			-- Check if the convoy was destroyed
			if (IsSomeBodyAlive (ID_ALLIES, ID_ALLIED_CONVOY)==0) then
				Wait (5);
				FailObjective (ID_OBJ_DEFEND_CONVOYS);
				Wait (5);
				Loose ();
				return 0;
			end;
		end;
		
	end

	Wait (30);

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("Area_CoastGuns"));

	Wait (30);

	LandReinforcementFromMap (ID_ALLIES, "AlliedConvoy", 1, ID_ALLIED_CONVOY);
	Cmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP1"));
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP2"));
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyTarget"));

	Wait (30);

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP1"));

	Wait (30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP2"));

	Wait (30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyTarget"));
	
	while (1) do
		Wait (5);
		
		-- Check if the convoy arrived at its destination point
		if (GetNScriptUnitsInArea (ID_ALLIED_CONVOY, "ConvoyTarget", false) > 0) then
			
			QCmd (ACT_DISAPPEAR, ID_ALLIED_CONVOY);
			
			Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("GermanBoatsEscape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_GAP);
			break;
			
		else
			-- Check if the convoy was destroyed
			if (IsSomeBodyAlive (ID_ALLIES, ID_ALLIED_CONVOY)==0) then
				Wait (5);
				FailObjective (ID_OBJ_DEFEND_CONVOYS);
				Wait (5);
				Loose ();
				return 0;
			end;
		end;
		
	end	

	Wait (20);

	StartThread (LandingParty2)

	Wait (40);

	LandReinforcementFromMap (ID_ALLIES, "AlliedConvoy", 1, ID_ALLIED_CONVOY);
	Cmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP1"));
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP2"));
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyTarget"));

	LandReinforcementFromMap (ID_GERMANS, "GermanBoats", 0, ID_GERMAN_BOATS1);
	Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));
	Wait (10);
	Cmd (ACT_SWARM, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"));

	LandReinforcementFromMap (ID_ALLIES, "AlliedBoats", 1, ID_ALLIED_BOATS2);
	Cmd (ACT_FOLLOW, ID_ALLIED_BOATS2, ID_ALLIED_CONVOY);

	Wait (30);

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP1"));

	Wait (30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP2"));

	Wait (30);
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP);
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyTarget"));
	
	while (1) do
		Wait (5);
		
		-- Check if the convoy arrived at its destination point
		if (GetNScriptUnitsInArea (ID_ALLIED_CONVOY, "ConvoyTarget", false) > 0) then
			
			QCmd (ACT_DISAPPEAR, ID_ALLIED_CONVOY);
			
			Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("GermanBoatsEscape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_GAP);
			
			Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("GermanBoatsEscape"));
			QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS1);
			
			Cmd (ACT_MOVE, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyTarget"));
			QCmd (ACT_DISAPPEAR, ID_ALLIED_BOATS1);
			
			CompleteObjective (ID_OBJ_DEFEND_GUNS);
			
			Wait (20);
			
			break;
			
		else
			-- Check if the convoy was destroyed
			if (IsSomeBodyAlive (ID_ALLIES, ID_ALLIED_CONVOY)==0) then
				Wait (5);
				FailObjective (ID_OBJ_DEFEND_CONVOYS);
				Wait (5);
				Loose ();
				return 0;
			end;
		end;
		
	end	

	CompleteObjective (ID_OBJ_DEFEND_CONVOYS);
	Wait (5);
	Win (0);

end;

--------------------------------------------------------------------------------

function DefendGuns ()

	GiveObjective (ID_OBJ_DEFEND_GUNS);

	-- Player needs some time to deploy his troops

	Wait (35);

	StartThread (AttackCoastGuns);
	StartThread (CallOutAlliedFighters);

	while (1) do
		Wait (5);
		
		if (GetNUnitsInParty (ID_GERMANS)==0) then
			StartThread (DefendConvoys);
			break;
		end;
		
		-- Check if the objective 0 (defend the guns) is failed
		if (IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUNS)==0) then
			Wait (5);
			FailObjective (ID_OBJ_DEFEND_GUNS);
			Wait (5);
			Loose ();
			return 0;
		end;
	end;

	while (1) do
		Wait (5);
		
		-- Check if the objective 0 (defend the guns) is failed
		if (IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUNS)==0) then
			Wait (5);
			FailObjective (ID_OBJ_DEFEND_GUNS);
			Wait (5);
			Loose ();
			return 0;
		end;
	end;

end;

--------------------------------------------------------------------------------

StartThread (DefendGuns);