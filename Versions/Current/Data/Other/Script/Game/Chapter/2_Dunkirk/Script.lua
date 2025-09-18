-- deploy templates id consts
Deploy_Tanks = 9;
Deploy_MainInf = 11;
Deploy_TD = 10;
Deploy_GA = 12;
Deploy_Fighters = 13;
Deploy_Artillery = 14;
Deploy_HeavyArtillery = 15;

-- player reinf id consts
Reinf_Player_Tanks = 59;
Reinf_Player_Artillery = 48;
Reinf_Player_MainInf = 57;
Reinf_Player_HeavyArtillery = 55;
Reinf_Player_Fighters = 53;
Reinf_Player_GA = 54;
Reinf_Player_TD = 58;


-- enemy reinf id consts
Reinf_Enemy_Tanks = 116;
Reinf_Enemy_TD = 69;
Reinf_Enemy_Inf = 72;
Reinf_Enemy_GA = 75;



-- other

DISPERSION = 500;


--Start Mission Reveal objectives 1

function RevealObjective1()
	Trace("StartMission DUNK Run!");
	Wait(10);
	ObjectiveChanged(1, 1);
	StartThread( Reinf_Attack );
	StartThread( Reinf_Attack2 );
	StartThread( LoseCheck );
	Trace("Objective1 is reveal. Reflect the attacks of the enemy in current five minutes!");
end;

--Lose Check

function LoseCheck()
	while 1 do
        if GetNUnitsInArea(1, "Zone") > 0 and GetIGlobalVar("temp.Dunk,objective1", 1) ~= 2 then 
        Trace("Loose!");
        ObjectiveChanged(1, 3);
        Wait( 2 );
		Loose(0);
        return 1;
		end;
	Wait(5);
	end;
end;

--Attack German Tanks

function Reinf_Attack()
	while 1 do
        if GetIGlobalVar("temp.Dunk,objective1", 1) ~= 2 then 
		Wait( 25 );
		Trace("Enemy reinf landed");
		LandReinforcement( 1, 116, 9, 1 );
		Wait( 3 );
		Attack_Group = GetUnitListInAreaArray( 1, "Enemy_Reinforcement_1" );
		CmdArrayDisp( ACT_SWARM, Attack_Group, DISPERSION, GetScriptAreaParams( "Zone" ) );
		Wait( 55 );
		StartThread( Reinf_Attack );
        return 1;
		end;
	Wait(5);
	end;
end;


function Reinf_Attack2()
	while 1 do
        if GetIGlobalVar("temp.Dunk,objective1", 1) ~= 2 then 
		Wait( 25 );
		Trace("Enemy reinf landed");
		LandReinforcement( 1, 116, 9, 2 );
		Wait( 3 );
		Attack_Group_2 = GetUnitListInAreaArray( 1, "Enemy_Reinforcement_2" );
		CmdArrayDisp( ACT_SWARM, Attack_Group_2, DISPERSION, GetScriptAreaParams( "Zone" ) );
		Wait( 55 );
		StartThread( Reinf_Attack2 );
        return 1;
		end;
	Wait(5);
	end;
end;

--Evacuation of the union troopses  Winner

function GB_Reinf()
	ViewZone ( "BR_Reinf_1", 1 );
	ViewZone ( "BR_Reinf_2", 1 );
	Wait( 30 );
	GiveCommand(ACT_MOVE,300,3336,6354);
	Wait( 50 );
	RemoveScriptGroup( 300 );
	GiveCommand(ACT_MOVE,301,3336,6354);
	Wait( 50 );
	RemoveScriptGroup( 301 );
	GiveCommand(ACT_MOVE,302,3336,6354);
	Wait( 50 );
	RemoveScriptGroup( 302 );
	GiveCommand(ACT_MOVE,303,3336,6354);
	Wait( 50 );
	RemoveScriptGroup( 303 );
	GiveCommand(ACT_MOVE,304,3336,6354);
	Wait( 50 );
	RemoveScriptGroup( 304 );
	Wait( 2 );
	GiveCommand(ACT_MOVE,700,442,5929);
	Wait( 15 );
	RemoveScriptGroup( 700 );
	SetIGlobalVar( "temp.Dunk,objective1", 2 );
	ObjectiveChanged(1, 2);
	Wait( 2 );
	Win (0);
end;




--Main
StartThread( RevealObjective1 );
StartThread( GB_Reinf );
