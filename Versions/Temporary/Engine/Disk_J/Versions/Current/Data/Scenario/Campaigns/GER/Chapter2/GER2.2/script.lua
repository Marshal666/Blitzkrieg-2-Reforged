obj_1 = 0;
---------------- OBJECTIVE 0 ------------------ begin

---- force to Flaks

function attacks_on_aa_position()	
	Wait(90);
	Trace("Thread attacks_on_aa_position has been started...");
		Cmd(ACT_SWARM,6766,500,2000,5500);
		Wait(50);
		Cmd(ACT_MOVE,6760,0,950,3900);
		QCmd(ACT_DEPLOY,6760,0,950,3900);
		StartThread(infantry_attack);
		Wait(50);
		Cmd(ACT_SWARM,6761,500,2000,5500);
		Wait(50);
		if (GetDifficultyLevel()==0) then
			RemoveScriptGroup(6763);
			RemoveScriptGroup(6764);
			Cmd(ACT_SWARM,6762,500,2000,5500);
		end;
		if (GetDifficultyLevel()==1) then
			RemoveScriptGroup(6764);
			Cmd(ACT_SWARM,6762,500,2000,5500);
			Cmd(ACT_SWARM,6763,500,2000,5500);
		end;
		if (GetDifficultyLevel()==2) then
			Cmd(ACT_SWARM,6762,500,2000,5500);
			Cmd(ACT_SWARM,6763,500,2000,5500);
			Cmd(ACT_SWARM,6764,500,2000,5500);
		end;
end;

function infantry_attack()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(6860,"infantry",0)>0) then
			Wait(10);
			Cmd(ACT_SWARM,6860,500,2000,5500)
			break;
		end;
	end;
end;


function intercept_trucks()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(10001,"AntiAirArea",0)>0 or GetNScriptUnitsInArea(10002,"AntiAirArea",0)>0 or GetNScriptUnitsInArea(10003,"AntiAirArea",0)>0) then
		--if (obj_1==0) then
			if (GetNUnitsInScriptGroup(676,1) > 0) then
				Trace("Humber condition success!!!");
				for i=1,1+2*GetDifficultyLevel() do
					LandReinforcementFromMap(1,"humber",0,530+i);
					Trace("Humber has been landed...")
					Cmd(ACT_SWARM,530+i,0,3002, 793);
					QCmd(ACT_SWARM,530+i,0,4841, 1777);
					QCmd(ACT_SWARM,530+i,0,5370, 2720);
					if (i~=1) then
						QCmd(ACT_SWARM,530+i,0,5097, 4176);
					end;
					Wait(3);
				end;
			end;
			if (GetDifficultyLevel()~=0) then
				for i=1,GetDifficultyLevel() do
					ScriptID = 611+i;
					Cmd(ACT_MOVE,ScriptID,0,1950, 954);
					QCmd(ACT_MOVE,ScriptID,0,2622, 964);
					QCmd(ACT_MOVE,ScriptID,0,3025, 753);
					QCmd(ACT_MOVE,ScriptID,0,3552, 1281);
					QCmd(ACT_MOVE,ScriptID,0,4833, 1780);
					QCmd(ACT_MOVE,ScriptID,0,5216, 2741);
					QCmd(ACT_MOVE,ScriptID,0,5251, 4100);
					if i == 1 then
						QCmd(ACT_DEPLOY,ScriptID,0,4759,4244);
						QCmd(ACT_MOVE,ScriptID,0,4485, 4481);
						QCmd(ACT_MOVE,ScriptID,0,5069,3908);
					else
						QCmd(ACT_DEPLOY,ScriptID,0,4908,4653);
						QCmd(ACT_MOVE,ScriptID,0,4616,4616);
						QCmd(ACT_MOVE,ScriptID,0,5178,4360);
					end;
					Wait(8);
				end;
			else
				ScriptID = 614;
				Cmd(ACT_MOVE,ScriptID,0,1950, 954);
				QCmd(ACT_MOVE,ScriptID,0,2622, 964);
				QCmd(ACT_MOVE,ScriptID,0,3025, 753);
				QCmd(ACT_MOVE,ScriptID,0,3552, 1281);
				QCmd(ACT_MOVE,ScriptID,0,4833, 1780);
				QCmd(ACT_DEPLOY,ScriptID,0,5216, 2741);
				QCmd(ACT_MOVE,ScriptID,0,5313,3103);
				StartThread(cannon622);
				StartThread(cannon623);
				StartThread(cannon624);
			end;
		break;
		end;
	end;
end;

function cannon622()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(622,"cannon_622",0)>0) then
			Wait(10);
			Cmd(ACT_ROTATE,622,0,2000,5600);
			QCmd(ACT_ENTRENCH,622,1);
			break;
		end;
	end;
end;

function cannon623()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(623,"cannon_623",0)>0) then
			Wait(10);
			Cmd(ACT_ROTATE,623,0,2000,5600);
			QCmd(ACT_ENTRENCH,623,1);
			break;
		end;
	end;
end;

function cannon624()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(624,"cannon_622",0)>0) then
			Wait(10);
			Cmd(ACT_ROTATE,624,0,2000,5600);
			QCmd(ACT_ENTRENCH,624,1);
			break;
		end;
	end;
end;

function key_point_attacks()
	i = 0;
	while i<=6 do
		Wait(1);
		if ((GetNUnitsInScriptGroup(676,1)>0 and GetNUnitsInScriptGroup(1150) < 2) or (GetNUnitsInScriptGroup(676,1)>0 and GetGameTime()>150)) then
			if (GetNUnitsInScriptGroup(500,0)>0) then
				i = i+1;
				delay = 110;
					LandReinforcementFromMap(1,"infantry",0,680+i);
					Cmd(ACT_SWARM,680+i,200,5457, 2663);
					QCmd(ACT_SWARM,680+i,200,6551, 2021);
					QCmd(ACT_SWARM,680+i,200,6350, 947);
					Wait(delay);
				if (GetNUnitsInScriptGroup(676,1)>0) then
					LandReinforcementFromMap(1,"crusader",0,780+i);
					Cmd(ACT_SWARM,780+i,200,5457, 2663);
					QCmd(ACT_SWARM,780+i,200,6551, 2021);
					QCmd(ACT_SWARM,780+i,200,6350, 947);
					Wait(delay);
				end;
			end;
		end;
	end;
end;

function take_artillery_on_player_position()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(1,"KeyArea",0)>0 and GetNUnitsInArea(0,"KeyArea",0) < 1) then
			Tank_ID = 630+GetDifficultyLevel();
			Cmd(ACT_SWARM,Tank_ID,200,3011, 798);
			QCmd(ACT_SWARM,Tank_ID,200,5457, 2663);
			QCmd(ACT_SWARM,Tank_ID,200,6551, 2021);
			QCmd(ACT_SWARM,Tank_ID,200,6637, 1897);
			QCmd(ACT_SWARM,Tank_ID,0,6374, 1597);
			Wait(2);
			Cmd(ACT_MOVE,610,200,1740, 966);
			QCmd(ACT_MOVE,610,200,3011, 798);
			QCmd(ACT_MOVE,610,200,5457, 2663);
			QCmd(ACT_MOVE,610,200,6551, 2021);
			QCmd(ACT_MOVE,610,200,6637, 1897);
			QCmd(ACT_DEPLOY,610,0,6535, 1838);
			QCmd(ACT_MOVE,610,0,6235, 638);
			Wait(6);
			Cmd(ACT_MOVE,611,200,1740, 966);
			QCmd(ACT_MOVE,611,200,3011, 798);
			QCmd(ACT_MOVE,611,200,5457, 2663);
			QCmd(ACT_MOVE,611,200,6551, 2021);
			QCmd(ACT_MOVE,611,200,6637, 1897);
			QCmd(ACT_DEPLOY,611,0,6145, 1889);
			QCmd(ACT_MOVE,611,0,6135, 438);
			StartThread(Cannons_1entrench);
			StartThread(Cannons_2entrench);
			break;
		end;
	end;
end;

function Cannons_1entrench()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(620,"cannon_1",0)>0) then
			Wait(10);
			Cmd(ACT_ROTATE,620,0,6575, 2959);
			QCmd(ACT_ENTRENCH,620,1);
			break;
		end;
	end;
end;

function Cannons_2entrench()
	while 1 do
		Wait(1);
		if (GetNScriptUnitsInArea(621,"cannon_2",0)>0) then
			Wait(10);
			Cmd(ACT_ROTATE,621,0,4417, 4685);
			QCmd(ACT_ENTRENCH,621,1);
			break;
		end;
	end;
end;

function InitialConditions()
	if (GetDifficultyLevel() == 0) then
		RemoveScriptGroup(1402);
		RemoveScriptGroup(1401);
	end;
	if (GetDifficultyLevel() == 1) then
		RemoveScriptGroup(1402);
		RemoveScriptGroup(1400);
	end;
	if (GetDifficultyLevel() == 2) then
		RemoveScriptGroup(1400);
		RemoveScriptGroup(1401);
		StartThread(key_point_attacks);
	end;
end;

function counter_attack()
	while 1 do	
		Wait(1);
		if (GetNUnitsInArea(0,"attack_2",0) > 1) then
			Trace("Player has got more then one unit in approaching zone");
			Cmd(ACT_SWARM,1403,500,5200,3500);
			ScriptID = 1400 + GetDifficultyLevel();
			Trace("Attacking forces ScriptID is %g",ScriptID);
			Cmd(ACT_SWARM,ScriptID,500,5200,3500);
			break;
		end;
	end;
end;

function ReinforcementManager()
	if (GetDifficultyLevel() == 0) then
		StartThread(resurrection_easy);
	end;
	if (GetDifficultyLevel() == 1) then
		StartThread(resurrection_normal);
	end;
end;

function smoke()
	Wait(1);
	while 1 do		
		if (GetGameTime() < 150) then
			if (GetNUnitsInScriptGroup(1150) == 2) then
				PlayEffect(5,5192, 2296,50);
				PlayEffect(5,5087, 2158,50);
				PlayEffect(5,5092, 2025,50);
				PlayEffect(5,4838, 2498,50);
				Wait(30);
			else
				break;
			end;
		else
			break;
		end;
		Wait(1);
	end;
end;


function RevealObjective0()

    Wait(1);

	ObjectiveChanged(0, 1);

	Wait(3);

	StartThread( lose );

end;





function Objective0()

	if (GetNUnitsInArea(0, "AntiAirArea",0) > 0 ) then

		return 1;

    end;

end;



function CompleteObjective0()
	StartThread(Change_player201);
	Wait(1);
	StartThread(TrucksReinf);
	Wait(1);
	StartThread(ArtilleryCrewReinf);
	ObjectiveChanged(0, 2);
	Wait(1);
	StartThread( RevealObjective1 );
	Trigger( Objective1, CompleteObjective1 );
	StartThread(attack_trucks_arriving);
	Cmd(ACT_SWARM,116,500,2200,5500);
end;


---------------- OBJECTIVE 0 ------------------ end



---------------- OBJECTIVE 1 ------------------ begin

---- Safe Flaks

function RevealObjective1()

    Wait(5);
	
	ObjectiveChanged(1, 1);

end;





function Objective1()

	if ( GetNScriptUnitsInArea(201, "KeyArea", 0) == GetNUnitsInScriptGroup(201)) then

        return 1;

    end;

end;





function CompleteObjective1()

	Wait(5);

	ObjectiveChanged(1, 2);
	Wait(3);

	Win(0);

end;

---------------- OBJECTIVE 1 ------------------ end

---------------- TRUCK       ------------------ begin
function TrucksReinf()
	Trace("Trucks reinforcement has started...");
	Wait(3);
	LandReinforcementFromMap(0, "231", 0, 10006);
	Cmd(ACT_MOVE, 10006, 0, 6625, 1471);
	Wait(3);
	LandReinforcementFromMap(0, "Trucks", 0, 10001);
	Cmd(ACT_MOVE, 10001, 0, 6578, 1278);
	Wait(3);
	LandReinforcementFromMap(0, "Trucks", 0, 10002);
	Cmd(ACT_MOVE, 10002, 0, 6526, 1055);
	Wait(3);
	LandReinforcementFromMap(0, "Trucks", 0, 10003);
	Cmd(ACT_MOVE, 10003, 0, 6467, 843);
	Wait(5);
	LandReinforcementFromMap(0, "231", 0, 10004);
	Cmd(ACT_MOVE, 10004, 0, 6409, 612);
	StartThread(ReinforcementManager);
	--LandReinforcementFromMap(0, "231", 0, 10007);
	--Cmd(ACT_MOVE, 10007, 0, 6153, 170);
	--Wait(3);
	obj_1 = 1;
end;

function resurrection_easy()
	while 1 do
		Wait(1);
		if (IsAlive(GetObjectList(10001)) == 0) then
			LandReinforcementFromMap(0, "Trucks", 0, 10001);
			Cmd(ACT_MOVE, 10001, 0, 6578, 1278);
			Wait(5);
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
		end;
		if (IsAlive(GetObjectList(10002)) == 0) then
			LandReinforcementFromMap(0, "Trucks", 0, 10002);
			Cmd(ACT_MOVE, 10002, 0, 6526, 1055);
			Wait(5);
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
		end;
		if (IsAlive(GetObjectList(10003)) == 0) then
			LandReinforcementFromMap(0, "Trucks", 0, 10003);
			Cmd(ACT_MOVE, 10003, 0, 6467, 843);
			Wait(5);
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
		end;
	end;
end;

function resurrection_normal()
	while 1 do
		Wait(1);
		if (IsAlive(GetObjectList(10001)) == 0) then
			LandReinforcementFromMap(0, "Trucks", 0, 10001);
			Cmd(ACT_MOVE, 10001, 0, 6578, 1278);
			Wait(5);
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
			break;
		end;
	end;
	while 1 do
		Wait(1);
		if (IsAlive(GetObjectList(10001)) == 0) then
			LandReinforcementFromMap(0, "Trucks", 0, 10001);
			Cmd(ACT_MOVE, 10001, 0, 6578, 1278);
			Wait(5);
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
			break;
		end;
	end;
	while 1 do
		Wait(1);
		if (IsAlive(GetObjectList(10001)) == 0) then
			LandReinforcementFromMap(0, "Trucks", 0, 10001);
			Cmd(ACT_MOVE, 10001, 0, 6578, 1278);
			Wait(5);
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
			break;
		end;
	end;
end;



function ArtilleryCrewReinf()
	Trace("Artillery crew reinforcement has started...");
	Wait(1);
	N = GetNUnitsInScriptGroup(201,0);
	if (N < 3) then
		for i = 1,(3 - N) do
			Wait(1);
			LandReinforcementFromMap(0, "crew", 0, 209);
			Cmd(ACT_MOVE, 209, 800, 6750, 940);
		end;
	end;
end;

---------------- TRUCK       ------------------ end



---------------- ATTACK ----------------------- begin

function attack1() 
	while 1 do  
	Wait(1); 
		if (GetNUnitsInArea(0, "PlayerApproach", 0) > 0) then 
			Wait(1); 
			Cmd(ACT_SWARM, 114, 1, 4073, 4706);
			Wait(40);
			if (GetDifficultyLevel() == 0 or GetDifficultyLevel() == 1) then
				LandReinforcementFromMap(2,"fighter", 0, 1001);
				Cmd(ACT_MOVE, 1001, 2000, 4400, 4400);
			end;
			Wait(20); 			
			LandReinforcementFromMap(1,"GAP", 0, 110);
			Cmd(ACT_MOVE, 110, 2000, 4400, 4400);
			break; 
		end; 
	end; 
end; 

---------------- ATTACK ----------------------- end



---------------- ATTACK_2 --------------------- begin

function attack_trucks_arriving()
	if (GetNUnitsInScriptGroup(676,1) > 0) then
		if (GetDifficultyLevel() == 0) then
			LandReinforcementFromMap(1,"humber",0,600);
			Cmd(ACT_SWARM,600,300,3011, 798);
			QCmd(ACT_SWARM,600,300,4787, 1740);
			QCmd(ACT_SWARM,600,300,5351, 3005);
			QCmd(ACT_SWARM,600,300,5069, 4220);
			Wait(4);
		end;
		if (GetDifficultyLevel() == 1 or GetDifficultyLevel() == 2) then
			for i=1,2 do
				LandReinforcementFromMap(1,"humber",0,600+i);
				Cmd(ACT_SWARM,600+i,300,3011, 798);
				QCmd(ACT_SWARM,600+i,300,4787, 1740);
				QCmd(ACT_SWARM,600+i,300,5351, 3005);
				QCmd(ACT_SWARM,600+i,300,5069, 4220);
				Wait(4);
			end;
		end;
	end;
end;

---------------- ATTACK_2 --------------------- end



---------------- LOOSE ------------------------ begin

function lose()

	while 1 do

        if ( (GetNUnitsInParty(0) == 0 and GetReinforcementCallsLeft(0) == 0) or GetNUnitsInScriptGroup(201) < 2 or (GetNUnitsInScriptGroup(10001) == 0 and GetNUnitsInScriptGroup(10002) == 0 and GetNUnitsInScriptGroup(10003) == 0 and obj_1 == 1)) then

                Trace("My proigrali!!!");

				Wait(2);

				Loose(0);

        return 1;

		end;

	Wait(5);

	end;

end;



---------------- LOOSE ------------------------ end

function Change_player201()

local Objects = {};

	Objects = GetObjectListArray( 201 );

	for i = 1, Objects.n do

		if (IsAlive(Objects[i]) == 1) then

			ChangePlayer( Objects[i], 0 );

		end;

	end;

end;



function Change_player202()

local Objects = {};

	Objects = GetObjectListArray( 202 );

	for i = 1, Objects.n do

		if (IsAlive(Objects[i]) == 1) then

			ChangePlayer( Objects[i], 0 );

		end;

	end;

end;

function gift()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup(676,0)>0) then
			Trace("Reinforcement has arrived...");
			LandReinforcementFromMap(0,"tanks",1,10);
			Cmd(ACT_SWARM,10,0,3000,900);
			break;
		end;
	end;
end;


function attack_aa_position()
	while 1 do
		Wait(1);
		if (GetNUnitsInArea(0,"attack_1",0) > 0 or GetNUnitsInArea(0,"attack_2",0) > 0) then 
			Cmd(ACT_SWARM, 111,500,2000,5500);
		end;
	end;
end;

function crew_reinf()
	while 1 do
		Wait(5);
		if GetNUnitsInScriptGroup(201,3) > 0 then
			Trace("Not enough Squads!!!");
			LandReinforcementFromMap(0, "crew", 0, 2090);
			Cmd(ACT_MOVE, 2090, 800, 6750, 940);
		end;
	end;
end;

StartThread(gift);
StartThread(intercept_trucks);
StartThread(take_artillery_on_player_position);
StartThread(counter_attack);
StartThread(RevealObjective0);
StartThread(smoke);
StartThread(InitialConditions);
Trigger( Objective0, CompleteObjective0 );

StartThread( attack1);
StartThread(attack_aa_position);
StartThread(attacks_on_aa_position);
--StartThread(key_point_attacks);