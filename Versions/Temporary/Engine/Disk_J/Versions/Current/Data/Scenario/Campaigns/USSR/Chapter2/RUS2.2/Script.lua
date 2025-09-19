--Batareya

--Global



--All_Func

function Task_Control()
		
	while 1 do
		
		Wait(2);
		--Secret_Task_control
		if (GetNUnitsInArea(0,"secret",0)>0) then
			GiveObjective(2);
			ChangePlayerForScriptGroup(100,0);	
			CompleteObjective(2);
			break;
		end;
	end;
	
	while 1 do
		Wait(2);
		if ((GetNUnitsInArea(0,"Shtab",0)>0) and (GetNUnitsInArea(1,"Shtab",0)==0)) then
			GiveObjective(1);
			Wait(3);
			CompleteObjective(1);
			break;
		end;
		
	end;
		
end;

function Atack_Control()
		
	Wait(3);
	GiveObjective(0);
	Wait(20);
	StartThread(Start_Atack_Avia_and_Art);
	Wait(30);
	StartThread(Attack_1_wave);
	Wait(110);
	StartThread(Til_Tank_Atack);
	Wait(65);
	GiveObjective(1);
	Wait(30);
	StartThread(Atak_2_wave);
	Wait(110);
	StartThread(Last_Wave);
	Wait(110);

	
	
end;

function Start_Atack_Avia_and_Art()

	Cmd(16, 200, 20, GetScriptAreaParams("1st_target"));
	Cmd(16, 250, 20, GetScriptAreaParams("2nd_target"));
	
	Wait(11);
	
	LandReinforcementFromMap(1,"Shturmoviki",1 , 350);
	
	Cmd(3, 350, 5, GetScriptAreaParams("Sturmovka"));
	
	Wait(1);
	
	LandReinforcementFromMap(1,"Bomber",0, 300);
	Cmd(0, 300, 20,GetScriptAreaParams("3_target"));
		
end;

function Attack_1_wave()
	Cmd(16, 200, 50, GetScriptAreaParams("defence_1"));
	Cmd(16, 250, 50, GetScriptAreaParams("defence_1"));
	Wait(10);
	Cmd(16, 200, 50, GetScriptAreaParams("defence_2"));
	Cmd(16, 250, 50, GetScriptAreaParams("defence_2"));
	
	--Razvedka
	
	Wait(5);
	
	LandReinforcementFromMap(1,"razvedka",0, 400);
	
	Cmd(3, 400, 25, GetScriptAreaParams("defence_1"));
	
	--Ataka
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, 450);
	ChangeFormation(450, 3);
	
	Cmd(3, 450, 25, GetScriptAreaParams("move_1"));
	QCmd(3, 450, 25, GetScriptAreaParams("defence_1"));
	
	Wait(1);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, 500);
	ChangeFormation(500, 3);
	
	Cmd(3, 500, 25, GetScriptAreaParams("move_1"));
	QCmd(3, 500, 25, GetScriptAreaParams("defence_2"));
	
	Wait(1);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, 550);
	ChangeFormation(550, 3);
	
	Cmd(3, 550, 25, GetScriptAreaParams("move_1"));
	QCmd(3, 550, 25, GetScriptAreaParams("defence_2"));
	
end;

function Til_Tank_Atack()
	Cmd(16, 200, 20, GetScriptAreaParams("1st_target"));
	Cmd(16, 250, 20, GetScriptAreaParams("2nd_target"));
	
	--Razvedka
	
	LandReinforcementFromMap(1,"razvedka",0, 600);
	Cmd(3, 600, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 600, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 600, 20, GetScriptAreaParams("defence_3"));
	
	Wait(5);
	
    LandReinforcementFromMap(1,"razvedka",0, 650);
	Cmd(3, 650, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 650, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 650, 20, GetScriptAreaParams("defence_3"));
	
	--Ataka
	
	LandReinforcementFromMap(1,"tank_dead",0, 700);
	Cmd(3, 700, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 700, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 700, 20, GetScriptAreaParams("defence_3"));
	Wait(5);
	
	LandReinforcementFromMap(1,"tank_dead",0, 750);
	Cmd(3, 750, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 750, 20, GetScriptAreaParams("defence_3"));
	Wait(1);
	
	--LandReinforcementFromMap(1,"tank_dead",0, 900);
	--Cmd(3, 900, 20, GetScriptAreaParams("move_2"));
	--QCmd(3, 900, 20, GetScriptAreaParams("move_3"));
	--QCmd(3, 900, 20, GetScriptAreaParams("defence_3"));
	--Wait(1);
	
	LandReinforcementFromMap(1,"samohodki",1, 800);
	Cmd(3, 800, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 800, 20, GetScriptAreaParams("defence_3"));
	Wait(5);
	
	LandReinforcementFromMap(1,"samohodki",1, 850);
	Cmd(3, 850, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 850, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 850, 20, GetScriptAreaParams("defence_3"));
	
	
end;

function Atak_2_wave()
	--Avia_razvedka
	LandReinforcementFromMap(1,"avia_razvedka",0, 950);
	--LandReinforcementFromMap(1,"avia_razvedka",1, 1000);
	Cmd(0, 950, 35, GetScriptAreaParams("sklad_1"));
	Cmd(0, 1000, 35, GetScriptAreaParams("sklad_2"));
	--Art_obstrel
	Wait(10);
	Cmd(16, 200, 20, GetScriptAreaParams("sklad_1"));
	Cmd(16, 250, 20, GetScriptAreaParams("sklad_1"));
	--Avia_nalet
	--LandReinforcementFromMap(1,"Bomber",0, 1050);
	--Cmd(0, 1050, 20, GetScriptAreaParams("defence_3"));
	Wait(2);
	LandReinforcementFromMap(1,"Bomber",0, 1100);
	Cmd(0, 1100, 20, GetScriptAreaParams("defence_3"));
	Wait(1);
	LandReinforcementFromMap(1,"Bomber",0, 1400);
	Cmd(0, 1400, 20, GetScriptAreaParams("sklad_1"));
	--Razvedka_pz222
	LandReinforcementFromMap(1,"razvedka",0, 1200);
	
	Cmd(0, 1200, 20, GetScriptAreaParams("move_2"));
	QCmd(0, 1200, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 1200, 20, GetScriptAreaParams("defence_3"));
	--Ataka
	LandReinforcementFromMap(1,"Main_inf",0, 1250);
	ChangeFormation(1250,3);
	
	Cmd(3, 1250, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 1250, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 1250, 20, GetScriptAreaParams("defence_3"));
	
	LandReinforcementFromMap(1,"Main_inf",0, 1300);
	ChangeFormation(1300,3);
	
	Cmd(3, 1300, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 1300, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 1300, 20, GetScriptAreaParams("defence_3"));
	
	LandReinforcementFromMap(1,"Assauld_inf",0, 1350);
	ChangeFormation(1350,3);
	
	Cmd(3, 1350, 20, GetScriptAreaParams("move_2"));
	QCmd(3, 1350, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 1350, 20, GetScriptAreaParams("defence_3"));
end;

function Last_Wave()
	StartThread(Last_Atak_Aviation_and_Art);
	Wait(3);
	StartThread(Razvedka);
	Wait(17);
	StartThread(Last_Atak_Tank_1);
	Wait(17);
	StartThread(Last_Atak_Pehota_1);
	Wait(17);
	StartThread(Last_Atak_Tank_2);
	Wait(17);
	StartThread(Last_Atak_Pehota_2);
end;

--Last_Atak_function

function Last_Atak_Aviation_and_Art()
	--Art_fire
	Cmd(16, 200, 20, GetScriptAreaParams("1st_target"));
	Cmd(16, 250, 20, GetScriptAreaParams("2st_target"));
	--Avia_udar
	LandReinforcementFromMap(1,"Shturmoviki",1 , 1450);
	Cmd(0, 1450, 25, GetScriptAreaParams("2nd_target"));
	
	LandReinforcementFromMap(1,"Shturmoviki",1 , 1500);
	Cmd(0, 1500, 25, GetScriptAreaParams("3_target"));
	
	LandReinforcementFromMap(1,"Bomber",1 , 1550);
	Cmd(0, 1500, 25, GetScriptAreaParams("1st_target"));
	
	--Wait(10);
	--Avia_udar
	--LandReinforcementFromMap(1,"Shturmoviki",1 , 1451);
	--Cmd(0, 1450, 25, GetScriptAreaParams("2nd_target"));
	
	--LandReinforcementFromMap(1,"Shturmoviki",1 , 1501);
	---Cmd(0, 1500, 25, GetScriptAreaParams("3_target"));
	
	--LandReinforcementFromMap(1,"Bomber",1 , 1551);
	--Cmd(0, 1500, 25, GetScriptAreaParams("1st_target"));
end;


function Razvedka()
	--Razvedka
	LandReinforcementFromMap(1,"razvedka",1, 1700);
	Cmd(0, 1700, 25, GetScriptAreaParams("move_2"));
	QCmd(3, 1700, 25, GetScriptAreaParams("defence_3"));
	
	LandReinforcementFromMap(1,"razvedka",1, 1750);
	Cmd(0, 1750, 25, GetScriptAreaParams("move_2"));
	QCmd(3, 1750, 25, GetScriptAreaParams("defence_3"));
	
	Wait(5);
	
	LandReinforcementFromMap(1,"razvedka",0, 1600);
	Cmd(0, 1600, 25, GetScriptAreaParams("move_1"));
	QCmd(3, 1600, 25, GetScriptAreaParams("defence_1"));
	
	LandReinforcementFromMap(1,"razvedka",0, 1650);
	Cmd(0, 1650, 25, GetScriptAreaParams("move_1"));
	QCmd(3, 1650, 25, GetScriptAreaParams("defence_2"));
end;

function Last_Atak_Tank_1()
	--Ataka_tank_wave1
	
	LandReinforcementFromMap(1,"tank_dead",1, 2000);
	Cmd(3, 2000, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2000, 20, GetScriptAreaParams("Sturmovka"));
	
	--LandReinforcementFromMap(1,"tank_dead",1, 2100);
	--Cmd(3, 2100, 20, GetScriptAreaParams("move_3"));
	--QCmd(3, 2100, 20, GetScriptAreaParams("Sturmovka"));
	
	Wait(10);
	
	LandReinforcementFromMap(1,"tank_dead",0, 1800);
	Cmd(3, 1800, 20, GetScriptAreaParams("move_1"));
	QCmd(3, 1800, 20, GetScriptAreaParams("1st_target"));
	
	--LandReinforcementFromMap(1,"tank_dead",0, 1900);
	--Cmd(3, 1900, 20, GetScriptAreaParams("move_1"));
	--QCmd(3, 1900, 20, GetScriptAreaParams("1st_target"));
	
end;

function Last_Atak_Pehota_1()
	--Ataka_Pehota
		
	--LandReinforcementFromMap(1,"Main_inf",0, 2300);
	--ChangeFormation(2300, 3);
	--Cmd(3, 2300, 20, GetScriptAreaParams("move_3"));
	--QCmd(3, 2300, 20, GetScriptAreaParams("Sturmovka"));
	
	LandReinforcementFromMap(1,"Main_inf",0, 2350);
	ChangeFormation(2350, 3);
	Cmd(3, 2350, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2350, 20, GetScriptAreaParams("Sturmovka"));
	
	LandReinforcementFromMap(1,"Main_inf",0, 2400);
	ChangeFormation(2400, 3);
	Cmd(3, 2400, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2400, 20, GetScriptAreaParams("Sturmovka"));
	
	Wait(10);
	
	--LandReinforcementFromMap(1,"Main_inf",1, 2150);
	--ChangeFormation(2150, 3);
	--Cmd(3, 2150, 20, GetScriptAreaParams("move_1"));
	--QCmd(3, 2150, 20, GetScriptAreaParams("3_target"));
	
	LandReinforcementFromMap(1,"Main_inf",1, 2200);
	ChangeFormation(2200, 3);
	Cmd(3, 2200, 20, GetScriptAreaParams("move_1"));
	QCmd(3, 2200, 20, GetScriptAreaParams("3_target"));
	
	--LandReinforcementFromMap(1,"Main_inf",1, 2250);
	--ChangeFormation(2250, 3);
	--Cmd(3, 2250, 20, GetScriptAreaParams("move_1"));
	--QCmd(3, 2250, 20, GetScriptAreaParams("3_target"));

end;

function Last_Atak_Tank_2()
	--Tank_2_wave
	
	LandReinforcementFromMap(1,"samohodki",1, 2600);
	Cmd(3, 2600, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2600, 20, GetScriptAreaParams("Sturmovka"));
	
	LandReinforcementFromMap(1,"samohodki",1, 2650);
	Cmd(3, 2650, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2650, 20, GetScriptAreaParams("Sturmovka"));
	
	Wait(10);
	
	--LandReinforcementFromMap(1,"samohodki",0, 2500);
	--Cmd(3, 2500, 20, GetScriptAreaParams("move_1"));
	--QCmd(3, 2500, 20, GetScriptAreaParams("2nd_target"));
	--QCmd(3, 2500, 20, GetScriptAreaParams("3_target"));
	
	LandReinforcementFromMap(1,"samohodki",0, 2550);
	Cmd(3, 2550, 20, GetScriptAreaParams("move_1"));
	QCmd(3, 2550, 20, GetScriptAreaParams("2nd_target"));
	QCmd(3, 2550, 20, GetScriptAreaParams("3_target"));
	
end;

function Last_Atak_Pehota_2()
	--Pehota_2
	
	LandReinforcementFromMap(1,"Assauld_inf",0, 2850);
	ChangeFormation(2850, 3);
	Cmd(3, 2850, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2850, 20, GetScriptAreaParams("sklad_1"));
	QCmd(3, 2850, 20, GetScriptAreaParams("Sturmovka"));
	
	--LandReinforcementFromMap(1,"Assauld_inf",0, 2900);
	--ChangeFormation(2900, 3);
	--Cmd(3, 2900, 20, GetScriptAreaParams("move_3"));
	--QCmd(3, 2900, 20, GetScriptAreaParams("sklad_1"));
	--QCmd(3, 2900, 20, GetScriptAreaParams("Sturmovka"));
	
	LandReinforcementFromMap(1,"Assauld_inf",0, 2950);
	ChangeFormation(2950, 3);
	Cmd(3, 2950, 20, GetScriptAreaParams("move_3"));
	QCmd(3, 2950, 20, GetScriptAreaParams("sklad_1"));
	QCmd(3, 2950, 20, GetScriptAreaParams("Sturmovka"));
	
	Wait(8);
	
	--LandReinforcementFromMap(1,"Assauld_inf",1, 2700);
	--ChangeFormation(2700, 3);
	--Cmd(3, 2700, 20, GetScriptAreaParams("move_1"));
	--QCmd(3, 2700, 20, GetScriptAreaParams("3_target"));
	
	LandReinforcementFromMap(1,"Assauld_inf",1, 2750);
	ChangeFormation(2750, 3);
	Cmd(3, 2750, 20, GetScriptAreaParams("move_1"));
	QCmd(3, 2750, 20, GetScriptAreaParams("3_target"));
	
	LandReinforcementFromMap(1,"Assauld_inf",1, 2800);
	ChangeFormation(2800, 3);
	Cmd(3, 2800, 20, GetScriptAreaParams("move_1"));
	QCmd(3, 2800, 20, GetScriptAreaParams("3_target"));
	
end;

function Batareya_Final()
	while 1 do
		Wait(2);
		if ((GetNUnitsInScriptGroup(3000, 2)==0) and (GetNUnitsInScriptGroup(3100, 2)==0) and (GetNUnitsInScriptGroup(3200, 2)==0)) then
			--Art_fire
			Cmd(16, 200, 20, GetScriptAreaParams("1st_target"));
			Cmd(16, 250, 20, GetScriptAreaParams("1st_target"));
			--Avia_udar
			LandReinforcementFromMap(1,"Bomber",1 , 3300);
			Cmd(0, 3300, 25, GetScriptAreaParams("2nd_target"));
			
			Wait(5);
			
			--LandReinforcementFromMap(1,"Bomber",1 , 3400);
			--Cmd(0, 3400, 25, GetScriptAreaParams("3_target"));
			
			--Wait(5);
			
			LandReinforcementFromMap(1,"Bomber",1 , 3500);
			Cmd(0, 3500, 25, GetScriptAreaParams("1st_target"));
			
			Wait(5);
			
			--LandReinforcementFromMap(1,"Bomber",1 , 3600);
			--Cmd(0, 3600, 25, GetScriptAreaParams("2nd_target"));
			
			Wait(5);
			
			LandReinforcementFromMap(1,"Bomber",1 , 3700);
			Cmd(0, 3700, 25, GetScriptAreaParams("3_target"));
			
			Wait(5);
			
			--LandReinforcementFromMap(1,"Bomber",1 , 3800);
			--Cmd(0, 3800, 25, GetScriptAreaParams("3_target"));
			break;
		end;
	end;
end;

--WINNERS\LOOSES

function PlayerWin()
	while 1 do
		Wait(1);
		if (GetNUnitsInScriptGroup (100100, 0)> 0) then
		    Wait(5);
		    CompleteObjective(0)
		    Wait (5)
		    CompleteObjective(1)
		    Wait (5)
			Win(0);
			return 0;
		end;
		
	end;
end;

function PlayerLoose_1()
	while 1 do
		Wait(1);
		if((GetNUnitsInScriptGroup(1,2)==0) and (GetNUnitsInScriptGroup(2,2)==0) and (GetNUnitsInScriptGroup(3,2)==0))then
			
			Wait(5);
			Win(1);
			return 1;
		end;
	end;
end;

function PlayerLoose_2()
	while 1 do
		Wait(1);
		if((IsSomePlayerUnit(0)~=1) and (GetReinforcementCallsLeft(0)==0))then
			
			Wait(3);
			Win(1);
			return 1;
		end;
	end;
end;

function Kill ()
    while 1 do
     Wait (3)
     if (GetNUnitsInArea (0, "Base", 0) < 1) and (GetNUnitsInArea (1, "Base", 0) > 0) then
     Wait (10)
     LandReinforcementFromMap (1, "Bomber", 1, 100101);
     Cmd (0, 100101, 50, 5813, 2557);
     Wait (10)
     LandReinforcementFromMap (1, "Bomber", 1, 100102);
     Cmd (0, 100102, 50, 6346, 2473);
     Wait (10)
     LandReinforcementFromMap (1, "Bomber", 1, 100103);
     Cmd (0, 100103, 50, 6369, 2503);
     Wait (5)
     break
     end;
    end;
end;


--MAIN_START
StartThread(Task_Control);
StartThread(Atack_Control);
StartThread(PlayerLoose_1);
StartThread(PlayerLoose_2);
StartThread(Batareya_Final);
StartThread (Kill);
StartThread (PlayerWin);