--------------------------------------------------------------------------------

__AUTO_ID = 2000

function AutoID ()
	__AUTO_ID = __AUTO_ID + 1
	return __AUTO_ID
end

--------------------------------------------------------------------------------

ID_ALLIED_FIGHTERS	= AutoID ()
ID_ALLIED_CONVOY	= AutoID ()
ID_ALLIED_BOATS1	= AutoID ()
ID_ALLIED_BOATS2	= AutoID ()

ID_GERMAN_GAP 		= AutoID ()
ID_GERMAN_BOMBERS 	= AutoID ()
ID_GERMAN_BOATS1 	= AutoID ()
ID_GERMAN_BOATS2 	= AutoID ()
ID_GERMAN_BOATS3 	= AutoID ()

ID_GERMAN_TROOPERS1	= AutoID ()
ID_GERMAN_TROOPERS2	= AutoID ()
ID_GERMAN_TROOPERS3	= AutoID ()
ID_GERMAN_TROOPERS4	= AutoID ()

--------------------------------------------------------------------------------

ID_COAST_GUN1 	= 499
ID_COAST_GUN2 	= 500
ID_FLAK_GUNS 	= 501

--------------------------------------------------------------------------------

ID_PLAYER 	= 0
ID_GERMANS 	= 1
ID_ALLIES 	= 2

--------------------------------------------------------------------------------

ID_OBJ_DEFEND_GUNS 		= 0
ID_OBJ_DEFEND_CONVOYS 	= 1

--------------------------------------------------------------------------------

function CallOutAlliedFighters ()
	Wait (60)
	
	-- Call out allied fighters to help us to defend the guns
	LandReinforcementFromMap (ID_ALLIES, "AlliedFighters", 0, ID_ALLIED_FIGHTERS)
	Cmd (ACT_SWARM, ID_ALLIED_FIGHTERS, 50, GetScriptAreaParams ("Area_CoastGuns"))

	while 1 do
		Wait (10)
		
		-- The germans was defeated - return planes to base
		if GetNUnitsInParty (ID_GERMANS)==0 then
			Cmd (ACT_MOVE, ID_ALLIED_FIGHTERS, 50, GetScriptAreaParams ("Area_Escape"))
			QCmd (ACT_DISAPPEAR, ID_ALLIED_FIGHTERS)
			break
		end
		
	end
end

--------------------------------------------------------------------------------

function AttackCoastGuns1 ()

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS1)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("WLandingZone1"))

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS2)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("WLandingZone2"))

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS3)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("WLandingZone3"))

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 1, ID_GERMAN_TROOPERS4)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("WLandingZone4"))

	Wait (15)

	-- German planes should attack guns' position
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("Area_CoastGuns"))

	LandReinforcementFromMap (ID_GERMANS, "GermanBomber", 0, ID_GERMAN_BOMBERS)
	Wait(2)
	LandReinforcementFromMap (ID_GERMANS, "GermanBomber", 0, ID_GERMAN_BOMBERS)
	Wait(2)
	LandReinforcementFromMap (ID_GERMANS, "GermanBomber", 0, ID_GERMAN_BOMBERS)
	Cmd (ACT_MOVE, ID_GERMAN_BOMBERS, 50, GetScriptAreaParams ("Area_CoastGuns"))

	while 1 do
		Wait (5)
		
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("Area_CoastGuns"))
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("Area_CoastGuns"))
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("Area_CoastGuns"))
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("Area_CoastGuns"))
		
		if 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS1)==0 and 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS2)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS3)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS4)==0
		then
			break
		end
		
		if GetNScriptUnitsInArea (ID_GERMANS, "Area_CoastGuns", 0) > 0 then
			SetScripObjectHPs (ID_COAST_GUN1, 0)
			SetScripObjectHPs (ID_COAST_GUN2, 0)
			break
		end

	end
end

--------------------------------------------------------------------------------

function AlliedReconnaissance ()

	while 1 do
		ID_ALLIED_RECON = AutoID ()
		
		if IsSomeBodyAlive (ID_ALLIES, ID_ALLIED_RECON)<3 then
			LandReinforcementFromMap (ID_ALLIES, "AlliedReconPlane", 2, ID_ALLIED_RECON)
			for i = 1,5 do
				QCmd (ACT_MOVE, ID_ALLIED_RECON, 50, GetScriptAreaParams ("Area_Recon"..Random(8)))
			end
			QCmd (ACT_MOVE, ID_ALLIED_RECON, 50, GetScriptAreaParams ("ConvoyTarget"))
			QCmd (ACT_DISAPPEAR, ID_ALLIED_RECON)
		end
		Wait (30)
	end

end

--------------------------------------------------------------------------------

function LandingParty2 ()

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	
	Wait(5)
	
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	
	Wait(5)
	
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	
	Wait(5)

	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("Area_CoastGuns"))

	Wait (10)
	
	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS1)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("ELandingZone1"))

	Wait (5)

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS2)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("ELandingZone2"))

	Wait (5)

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS3)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("ELandingZone3"))

	Wait (5)

	LandReinforcementFromMap (ID_GERMANS, "GermanTroopers", 0, ID_GERMAN_TROOPERS4)
	Cmd (ACT_UNLOAD, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("ELandingZone4"))

	while 1 do
		Wait (5)

		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS1, 50, GetScriptAreaParams ("Area_CoastGuns"))
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS2, 50, GetScriptAreaParams ("Area_CoastGuns"))
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS3, 50, GetScriptAreaParams ("Area_CoastGuns"))
		Cmd (ACT_SWARM, ID_GERMAN_TROOPERS4, 50, GetScriptAreaParams ("Area_CoastGuns"))
		
		if GetNScriptUnitsInArea (ID_GERMANS, "Area_CoastGuns", 0) > 0 then
			SetScripObjectHPs (ID_COAST_GUN1, 0)
			SetScripObjectHPs (ID_COAST_GUN2, 0)
			break
		end
		
		if 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS1)==0 and 
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS2)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS3)==0 and
			IsSomeBodyAlive (ID_GERMANS, ID_GERMAN_TROOPERS4)==0
		then
			break
		end
	end

end

--------------------------------------------------------------------------------

function DeployGermanBoats (scriptID, firstWayPoint)
	LandReinforcementFromMap (ID_GERMANS, "GermanBoat", 3, scriptID)
	Cmd (ACT_MOVE, scriptID, 50, GetScriptAreaParams (firstWayPoint))
	Wait (5)
	
	--LandReinforcementFromMap (ID_GERMANS, "GermanBoat", 2, scriptID)
	--Cmd (ACT_MOVE, scriptID, 50, GetScriptAreaParams (firstWayPoint))
	--Wait (5)

	LandReinforcementFromMap (ID_GERMANS, "GermanBoat", 0, scriptID)
	Cmd (ACT_MOVE, scriptID, 50, GetScriptAreaParams (firstWayPoint))
	Wait (5)
	
	Cmd (ACT_SWARM, scriptID, 50, GetScriptAreaParams (firstWayPoint))
end

--------------------------------------------------------------------------------

function WaitUntilConvoyIsArrived ()
	while 1 do
		Wait (5)
		
		-- Check if the convoy arrived at its destination point
		if GetNScriptUnitsInArea (ID_ALLIED_CONVOY, "ConvoyTarget", 0) > 0 then
			
			QCmd (ACT_DISAPPEAR, ID_ALLIED_CONVOY)
			break
			
		else
			-- Check if the convoy was destroyed
			if IsSomeBodyAlive (ID_ALLIES, ID_ALLIED_CONVOY)==0 then
				Wait (5)
				FailObjective (ID_OBJ_DEFEND_CONVOYS)
				Wait (5)
				Loose ()
				Wait (999)
			end
		end
		
	end
end

--------------------------------------------------------------------------------

function AttackFirstConvoy ()
	StartThread (function () DeployGermanBoats (ID_GERMAN_BOATS1, "ConvoyTarget") end)
	Wait (15)
	StartThread (function () DeployGermanBoats (ID_GERMAN_BOATS2, "ConvoyWP2") end)
	Wait (15)
	StartThread (function () DeployGermanBoats (ID_GERMAN_BOATS3, "ConvoyWP1") end)
end

--------------------------------------------------------------------------------

function FirstConvoy ()

	StartThread (AttackFirstConvoy)

	Wait (15)

	LandReinforcementFromMap (ID_ALLIES, "AlliedBoats", 1, ID_ALLIED_BOATS1)
	ChangePlayerForScriptGroup (ID_ALLIED_BOATS1, ID_PLAYER)
	Cmd (ACT_SWARM, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyTarget"))

	Wait (5)
	
	GiveObjective (ID_OBJ_DEFEND_CONVOYS)

	LandReinforcementFromMap (ID_ALLIES, "AlliedConvoy", 1, ID_ALLIED_CONVOY)
	Cmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP1"))
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP2"))
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyTarget"))

	Wait (5)

	LandReinforcementFromMap (ID_ALLIES, "AlliedBoats", 1, ID_ALLIED_BOATS2)
	ChangePlayerForScriptGroup (ID_ALLIED_BOATS2, ID_PLAYER)
	Cmd (ACT_FOLLOW, ID_ALLIED_BOATS2, ID_ALLIED_CONVOY)

	WaitUntilConvoyIsArrived ()

	ChangePlayerForScriptGroup (ID_ALLIED_BOATS1, ID_ALLIES)
	ChangePlayerForScriptGroup (ID_ALLIED_BOATS2, ID_ALLIES)
			
	Cmd (ACT_MOVE, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyTarget"))
	QCmd (ACT_DISAPPEAR, ID_ALLIED_BOATS1)
			
	Cmd (ACT_MOVE, ID_ALLIED_BOATS2, 50, GetScriptAreaParams ("ConvoyTarget"))
	QCmd (ACT_DISAPPEAR, ID_ALLIED_BOATS2)
			
	Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("GermanBoatsEscape"))
	QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS1)
			
	Cmd (ACT_MOVE, ID_GERMAN_BOATS2, 50, GetScriptAreaParams ("GermanBoatsEscape"))
	QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS2)
			
	Cmd (ACT_MOVE, ID_GERMAN_BOATS3, 50, GetScriptAreaParams ("GermanBoatsEscape"))
	QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS3)
end

--------------------------------------------------------------------------------

function AttackCoastGuns2 ()
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(5)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(5)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("Area_CoastGuns"))
end

--------------------------------------------------------------------------------

function AttackSecondConvoy ()

	Wait (15)

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP1"))
	QCmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP1"))

	Wait (15)
	
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP2"))
	QCmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP2"))

	Wait (15)
	
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyTarget"))
	QCmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyTarget"))

end

--------------------------------------------------------------------------------

function SecondConvoy ()
	LandReinforcementFromMap (ID_ALLIES, "AlliedConvoy", 1, ID_ALLIED_CONVOY)
	Cmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP1"))
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP2"))
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyTarget"))
	
	StartThread (AttackSecondConvoy)

	WaitUntilConvoyIsArrived ()
end

--------------------------------------------------------------------------------

function AttackThirdConvoy ()

	StartThread (function () DeployGermanBoats (ID_GERMAN_BOATS1, "ConvoyWP1") end)

	Wait (15)

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP1"))
	QCmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP1"))

	Wait (15)

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP2"))
	QCmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyWP2"))

	Wait (15)

	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Wait(1)
	LandReinforcementFromMap (ID_GERMANS, "GermanGAP", 0, ID_GERMAN_GAP)
	Cmd (ACT_MOVE, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyTarget"))
	QCmd (ACT_SWARM, ID_GERMAN_GAP, 50, GetScriptAreaParams ("ConvoyTarget"))

end

--------------------------------------------------------------------------------

function ThirdConvoy ()

	LandReinforcementFromMap (ID_ALLIES, "AlliedBoats", 1, ID_ALLIED_BOATS1)
	Cmd (ACT_SWARM, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyWP1"))
	ChangePlayerForScriptGroup (ID_ALLIED_BOATS1, ID_PLAYER)

	Wait (5)

	LandReinforcementFromMap (ID_ALLIES, "AlliedConvoy", 1, ID_ALLIED_CONVOY)
	Cmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP1"))
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyWP2"))
	QCmd (ACT_MOVE, ID_ALLIED_CONVOY, 50, GetScriptAreaParams ("ConvoyTarget"))

	StartThread (AttackThirdConvoy)

	WaitUntilConvoyIsArrived ()
	
	Cmd (ACT_MOVE, ID_GERMAN_BOATS1, 50, GetScriptAreaParams ("ConvoyTarget"))
	QCmd (ACT_DISAPPEAR, ID_GERMAN_BOATS1)
			
	ChangePlayerForScriptGroup (ID_ALLIED_BOATS1, ID_ALLIES)
			
	Cmd (ACT_MOVE, ID_ALLIED_BOATS1, 50, GetScriptAreaParams ("ConvoyTarget"))
	QCmd (ACT_DISAPPEAR, ID_ALLIED_BOATS1)
		
end

--------------------------------------------------------------------------------

function DefendConvoys ()
	
	StartThread (AlliedReconnaissance)

	-- Give some time to player to rearrange his troops after the first attack

	Wait (30)

	FirstConvoy ()

	Wait (30)

	AttackCoastGuns2 ()

	Wait (30)

	SecondConvoy ()

	Wait (30)

	StartThread (LandingParty2)

	Wait (60)

	ThirdConvoy ()

	CompleteObjective (ID_OBJ_DEFEND_GUNS)
	CompleteObjective (ID_OBJ_DEFEND_CONVOYS)
	Wait (5)
	Win (0)

end

--------------------------------------------------------------------------------

function DefendGuns ()

	GiveObjective (ID_OBJ_DEFEND_GUNS)

	-- Player needs some time to deploy his troops

	Wait (35)

	StartThread (AttackCoastGuns1)
	StartThread (CallOutAlliedFighters)

	while 1 do
		Wait (5)
		
		if GetNUnitsInParty (ID_GERMANS)==0 then
			StartThread (DefendConvoys)
			break
		end
		
		-- Check if the objective 0 (defend the guns) is failed
		if 
			IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUN1)==0 and 
			IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUN2)==0 
		then
			Wait (5)
			FailObjective (ID_OBJ_DEFEND_GUNS)
			Wait (5)
			Loose ()
			return 0
		end
	end

	while 1 do
		Wait (5)
		
		-- Check if the objective 0 (defend the guns) is failed
		if 
			IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUN1)==0 and 
			IsSomeBodyAlive (ID_PLAYER, ID_COAST_GUN2)==0 
		then
			Wait (5)
			FailObjective (ID_OBJ_DEFEND_GUNS)
			Wait (5)
			Loose ()
			return 0
		end
	end

end

--------------------------------------------------------------------------------

StartThread (DefendGuns)
--StartThread (DefendConvoys)
