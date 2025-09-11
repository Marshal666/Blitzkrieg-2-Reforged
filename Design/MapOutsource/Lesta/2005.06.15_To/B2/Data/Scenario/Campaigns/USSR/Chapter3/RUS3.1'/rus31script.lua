--------------------------------------------------------------------------------

__AUTO_ID = 2000;

function AutoID ()
	__AUTO_ID = __AUTO_ID + 1;
	return __AUTO_ID;
end;

--------------------------------------------------------------------------------

ID_OBJ_HOLD_SOUTH	= 0;
ID_OBJ_HOLD_NORTH	= 1;
ID_OBJ_HOLD_CENTER	= 2;

--------------------------------------------------------------------------------

ID_PLAYER 	= 0;
ID_GERMANS 	= 1;
ID_ALLIES 	= 2;

--------------------------------------------------------------------------------

ID_GERMAN_PZ1 = 500;
ID_GERMAN_PZ2 = 501;
ID_GERMAN_PZ3 = 502;
ID_GERMAN_PZ4 = 503;
ID_GERMAN_PZ5 = 504;
ID_GERMAN_PZ6 = 505;
ID_GERMAN_PZ7 = 506;
ID_GERMAN_PZ8 = 507;

ID_GERMAN_PZ9 = 600;
ID_GERMAN_PZ10 = 601;
ID_GERMAN_PZ11 = 602;
ID_GERMAN_PZ12 = 603;
ID_GERMAN_PZ13 = 604;
ID_GERMAN_PZ14 = 605;

ID_GERMAN_SDKFZ6 = 606;
ID_GERMAN_SDKFZ7 = 607;
ID_GERMAN_SDKFZ8 = 608;
ID_GERMAN_SDKFZ9 = 609;
ID_GERMAN_SDKFZ10 = 610;
ID_GERMAN_SDKFZ11 = 611;

ID_ALLIED_TANKS = 1000;

--------------------------------------------------------------------------------

function GermansAttackSouth ()

	Cmd (ACT_SWARM, ID_GERMAN_PZ1, 150, GetScriptAreaParams ("Pz1_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ1, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ2, 150, GetScriptAreaParams ("Pz2_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ2, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ3, 150, GetScriptAreaParams ("Pz1_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ3, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ4, 150, GetScriptAreaParams ("Pz2_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ4, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ5, 150, GetScriptAreaParams ("Pz5_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ5, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ6, 150, GetScriptAreaParams ("Pz6_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ6, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ7, 150, GetScriptAreaParams ("Pz7_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ7, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ8, 150, GetScriptAreaParams ("Pz8_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ8, 1);

end;

--------------------------------------------------------------------------------

function GermansAttackCenterAndNorth ()

	Cmd (ACT_SWARM, ID_GERMAN_PZ9, 150, GetScriptAreaParams ("Pz9_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ9, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ10, 150, GetScriptAreaParams ("Pz10_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ10, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ11, 150, GetScriptAreaParams ("Pz11_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ11, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ12, 150, GetScriptAreaParams ("Pz12_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ12, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ13, 150, GetScriptAreaParams ("Pz13_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ13, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_PZ14, 150, GetScriptAreaParams ("Pz14_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_PZ14, 1);
	Wait (5);

	Cmd (ACT_SWARM, ID_GERMAN_SDKFZ6, 150, GetScriptAreaParams ("SDKFZ6_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_SDKFZ6, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_SDKFZ7, 150, GetScriptAreaParams ("SDKFZ7_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_SDKFZ7, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_SDKFZ8, 150, GetScriptAreaParams ("SDKFZ8_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_SDKFZ8, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_SDKFZ9, 150, GetScriptAreaParams ("SDKFZ9_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_SDKFZ9, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_SDKFZ10, 150, GetScriptAreaParams ("SDKFZ10_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_SDKFZ10, 1);
	Wait (5);
	Cmd (ACT_SWARM, ID_GERMAN_SDKFZ11, 150, GetScriptAreaParams ("SDKFZ11_Target"));
	QCmd (ACT_ENTRENCH, ID_GERMAN_SDKFZ11, 1);

end;

--------------------------------------------------------------------------------

function AlliesAttackCenter ()
	Wait (10);
	Cmd (ACT_SWARM, ID_ALLIED_TANKS, 150, GetScriptAreaParams ("CentralVillage"));
end;

--------------------------------------------------------------------------------

PLAYER_CAN_WIN = 0;

--------------------------------------------------------------------------------

function CallAlliedReinforcement ()

	Wait (60);

	local ReinfTypes = 
	{ 
		"AlliedLightTanks", 
		"AlliedMediumTanks" 
	};
	ReinfTypes.n = 2;

	local AttackPoints = 
	{
		"AlliesAP1",
		"AlliesAP2",
		"AlliesAP3",
		"AlliesAP4",
		"AlliesAP5"
	};
	AttackPoints.n = 5;

	for i = 1, 6 do
		
		-- Wait for random time
		Wait (30+Random (30));

		-- Select reinforcement type
		local reinf_type = ReinfTypes [ Random (ReinfTypes.n) ];
		local group_id = AutoID ();

		LandReinforcementFromMap (ID_ALLIES, reinf_type, 0, group_id);

		-- Select the attack point
		local atack_pt = AttackPoints [Random (AttackPoints.n)];

		-- Send group into battle
		Cmd (ACT_SWARM, group_id, 150, GetScriptAreaParams (atack_pt));
		QCmd (ACT_ENTRENCH, group_id, 1);

	end;
end;

--------------------------------------------------------------------------------

function CallGermanReinforcement ()

	Wait (60);

	local ReinfTypes = 
	{ 
		"GermanLightTanks", 
		"GermanMediumTanks" 
	};
	ReinfTypes.n = 2;

	local AttackPoints = 
	{
		{
			"Pz1_Target",		"Pz2_Target",		"Pz3_Target",	
			"Pz4_Target",		"Pz5_Target",		"Pz6_Target",
			"Pz7_Target",		"Pz8_Target",		"Pz9_Target",	
			"SDKFZ1_Target",	"SDKFZ2_Target",    "SDKFZ3_Target",
			"SDKFZ4_Target",	"SDKFZ5_Target"
		},
		{
			"Pz10_Target",		"Pz11_Target",		"Pz12_Target",
			"Pz13_Target",		"Pz14_Target",
			"SDKFZ6_Target",	"SDKFZ7_Target",	"SDKFZ8_Target",
			"SDKFZ9_Target",	"SDKFZ10_Target",	"SDKFZ11_Target"
		}
	};

	AttackPoints[1].n = 14;
	AttackPoints[2].n = 11;

	for i = 1, 6 do
		
		-- Wait for random time
		Wait (30+Random (30));

		GiveReinforcementCalls (ID_GERMANS, 2);

		-- Generate attacking wave
		for j = 1, 3 do

			-- Now we must select the point where the reinforcement will appear
			local reinf_pt = Random (2)-1;

			-- Select reinforcement type
			local reinf_type = ReinfTypes [ Random (ReinfTypes.n) ];
			local group_id = AutoID ();
		
			LandReinforcementFromMap (ID_GERMANS, reinf_type, reinf_pt, group_id);

			-- Select the attack point
			local point_list = AttackPoints[reinf_pt+1]; 
			local atack_pt = point_list [Random (point_list.n)];

			-- Send group into battle
			Cmd (ACT_SWARM, group_id, 150, GetScriptAreaParams (atack_pt));
			QCmd (ACT_ENTRENCH, group_id, 1);

		end;

	end;

	Wait (60);

	PLAYER_CAN_WIN = 1;

end;

--------------------------------------------------------------------------------

OBJ1_COMPLETED = 0;

function CheckObjective1 ()
	while 1 do
		Wait (5);
		if GetNUnitsInArea (ID_GERMANS, "SouthernVillage", 0)==0 then
			OBJ1_COMPLETED = 1;
			CompleteObjective (ID_OBJ_HOLD_SOUTH);
			break;
		end
	end;
end;

--------------------------------------------------------------------------------

OBJ2_COMPLETED = 0;

function CheckObjective2 ()
	while 1 do
		Wait (5);
		if GetNUnitsInArea (ID_GERMANS, "NorthernVillage", 0)==0 then
			OBJ2_COMPLETED = 1;
			CompleteObjective (ID_OBJ_HOLD_NORTH);
			break;
		end;
	end;
end;

--------------------------------------------------------------------------------

OBJ3_COMPLETED = 0;

function CheckObjective3 ()
	while 1 do
		Wait (5);
		if GetNUnitsInArea (ID_GERMANS, "CentralVillage", 0)==0 then
			OBJ3_COMPLETED = 1;
			CompleteObjective (ID_OBJ_HOLD_CENTER);
			break;
		end;
	end;
end;

--------------------------------------------------------------------------------

ID_BRIDGE_SOUTH = 777;
ID_BRIDGE_NORTH = 778;

ID_MEGATRAIN = 555;

function BridgeMission ()

	Wait (30);

	while 1 do
		Wait (5);
		if GetScriptObjectHPs (ID_BRIDGE_SOUTH)>0 and GetScriptObjectHPs (ID_BRIDGE_NORTH)>0 then
			break;
		end;
	end;

	while 1 do
		Wait (5);
		if GetNUnitsInArea (ID_PLAYER, "Train", 0)==0 then
			ChangePlayerForScriptGroup (ID_MEGATRAIN, ID_PLAYER);
			break;
		end;
	end;

end;

--------------------------------------------------------------------------------

function CheckLooseConditions ()
	if GetNUnitsInParty (ID_PLAYER)==0 and GetReinforcementCallsLeft (ID_PLAYER)==0 then
		Loose ();
		return 1;
	end;

	return 0;
end;

--------------------------------------------------------------------------------

function Main ()
	StartThread (GermansAttackSouth);
	StartThread (GermansAttackCenterAndNorth);
	StartThread (AlliesAttackCenter);

	StartThread (CallGermanReinforcement);
	StartThread (CallAlliedReinforcement);

	GiveObjective (ID_OBJ_HOLD_SOUTH);
	GiveObjective (ID_OBJ_HOLD_NORTH);

	StartThread (BridgeMission);

	while 1 do
		Wait (5);
		
		if CheckLooseConditions ()==1 then
			break;
		end;

		if PLAYER_CAN_WIN==1 then
			GiveObjective (ID_OBJ_HOLD_CENTER);
			StartThread (CheckObjective1);
			StartThread (CheckObjective2);
			StartThread (CheckObjective3);
			break;
		end;
	end;

	while 1 do
		Wait (5);
		
		if CheckLooseConditions ()==1 then
			break;
		end;

		if OBJ1_COMPLETED==1 and OBJ2_COMPLETED==1 and OBJ3_COMPLETED==1 then
			Win (ID_PLAYER);
			break;
		end;
	end;
end;

--------------------------------------------------------------------------------

StartThread (Main);