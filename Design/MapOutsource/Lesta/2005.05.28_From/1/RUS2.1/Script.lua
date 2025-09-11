--Sapun_Gora
--Global

attack_num=0

--Starting function...
function StartArt_and_Bomb()
	GiveObjective(0);
	Wait(15);

	Cmd(16, 400, 50,GetScriptAreaParams("Artillery_zone_center"));
	Cmd(16, 500, 50,GetScriptAreaParams("Artillery_zone_center"));

	Wait(15);

--Bombing
	LandReinforcementFromMap(1,"Bomber",0,600);

	Cmd(0, 600, 25, GetScriptAreaParams("Bombing_zone_1"));

	Wait(3);

	LandReinforcementFromMap(1,"Bomber",0,610);

	Cmd(0, 610, 25, GetScriptAreaParams("Bombing_zone_1"));

	Wait(3);

	LandReinforcementFromMap(1,"Bomber",0,620);

	Cmd(0, 620, 25, GetScriptAreaParams("Bombing_zone_1"));


--End of Artillery fire and 1-st attack wave start

	Wait(30);

	Cmd(9, 400);
	Wait(2);
	Cmd(ACT_AMBUSH,400);

	Cmd(9, 500);
	Wait(2);
	Cmd(ACT_AMBUSH,500);

	StartThread(StartAttack);

end;

function StartAttack()
	attack_num=1;

--Reconnaissance

	Cmd(3, 300, 25, GetScriptAreaParams("Defence"));

	Wait(20);

--Attack

	Cmd(3, 100, 25, GetScriptAreaParams("Defence"));
	Cmd(3, 150, 30, GetScriptAreaParams("Defence"));

	Cmd(0, 200, 30, GetScriptAreaParams("move"));
	QCmd(3,200, 20, GetScriptAreaParams("Left_zone"));
	QCmd(3,200, 20, GetScriptAreaParams("Defence"));

	Cmd(0, 250, 30, GetScriptAreaParams("move"));
	QCmd(3,250, 30, GetScriptAreaParams("Left_zone"));
	QCmd(3,250, 30, GetScriptAreaParams("Defence"));

	Wait(80);
	
	GiveObjective(1);
	
	Wait(2);
	
	

	Wait(5);

	StartThread(Attack_2);

end;

function Attack_2()
	attack_num=2;

--Artillery Fire
	Cmd(16, 400, 50,GetScriptAreaParams("Left_zone"));
	Cmd(16, 500, 50,GetScriptAreaParams("Left_zone"));

	Wait(10);

--Reconnaissance 

	LandReinforcementFromMap(1,"Razvedka",1,700);
	LandReinforcementFromMap(1,"Razvedka",1,701);
	
	Cmd(0, 700, 25, GetScriptAreaParams("move"));
	QCmd(3, 700, 25, GetScriptAreaParams("Left_zone"));
	QCmd(3, 700, 25, GetScriptAreaParams("Defence"));
	
	Cmd(0, 701, 25, GetScriptAreaParams("move"));
	QCmd(3, 701, 25, GetScriptAreaParams("Left_zone"));
	QCmd(3, 701, 25, GetScriptAreaParams("Defence"));

--Attack

	LandReinforcementFromMap(1,"Assauld_inf",1,800);
	LandReinforcementFromMap(1,"Assauld_inf",1,900);
	LandReinforcementFromMap(1,"Assauld_inf",1,905);
	LandReinforcementFromMap(1,"Assauld_inf",1,907);
	

	ChangeFormation(800,3);
	ChangeFormation(900,3);
	ChangeFormation(905,3);
	ChangeFormation(907,3);

	Cmd(0, 800,25, GetScriptAreaParams("move"));
	QCmd(3, 800,25, GetScriptAreaParams("Left_zone"));
	QCmd(0, 800,25, GetScriptAreaParams("move_left"));
	QCmd(3, 800,30, GetScriptAreaParams("manevr_til"));
	QCmd(3, 800,30, GetScriptAreaParams("Defence"));

	Wait(5);

	Cmd(0, 900,25, GetScriptAreaParams("move"));
	QCmd(3, 900,25, GetScriptAreaParams("Left_zone"));
	QCmd(0, 900,25, GetScriptAreaParams("move_left"));
	QCmd(3, 900,30, GetScriptAreaParams("manevr_til"));
	QCmd(3, 900,30, GetScriptAreaParams("Defence"));
	
	Wait(5);
	
	Cmd(0, 905,25, GetScriptAreaParams("move"));
	QCmd(3, 905,25, GetScriptAreaParams("Left_zone"));
	QCmd(0, 905,25, GetScriptAreaParams("move_left"));
	QCmd(3, 905,30, GetScriptAreaParams("manevr_til"));
	QCmd(3, 905,30, GetScriptAreaParams("Defence"));
	
	Wait(3);

	Cmd(0, 907,25, GetScriptAreaParams("move"));
	QCmd(3, 907,25, GetScriptAreaParams("Left_zone"));
	QCmd(0, 907,25, GetScriptAreaParams("move_left"));
	QCmd(3, 907,30, GetScriptAreaParams("manevr_til"));
	QCmd(3, 907,30, GetScriptAreaParams("Defence"));

	Wait(80);

	StartThread(Attack_3);

end;

function Attack_3()
	attack_num=3;

--Air Attack with attack planes 

	LandReinforcementFromMap(1,"Shturmoviki",0,1000);
	LandReinforcementFromMap(1,"Shturmoviki",0,1005);

	Cmd(0, 1000, 10, GetScriptAreaParams("shturmovka"));
	Cmd(0, 1005, 10, GetScriptAreaParams("shturmovka"));
	

--Artillery Fire

	Cmd(16, 400, 70,GetScriptAreaParams("Defence"));
	Cmd(16, 500, 70,GetScriptAreaParams("Defence"));

	Wait(10);

	Cmd(16, 400, 70,GetScriptAreaParams("artpodgotovka"));
	Cmd(16, 500, 70,GetScriptAreaParams("artpodgotovka"));

	Wait(5);

--Reconnaissance

	LandReinforcementFromMap(1,"Razvedka",0,1100);
	LandReinforcementFromMap(1,"Razvedka",0,1111);

	Cmd(3, 1100, 25, GetScriptAreaParams("shturmovka"));
	Cmd(3, 1111, 25, GetScriptAreaParams("shturmovka"));

--Attack assault - and manoeuvre in the enemy rear

	LandReinforcementFromMap(1,"anti_tank",0,1200);
	LandReinforcementFromMap(1,"anti_tank",0,1205);
	LandReinforcementFromMap(1,"anti_tank",0,1208);

	Cmd(3, 1200, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 1200, 25, GetScriptAreaParams("Defence"));
	
	Cmd(3, 1205, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 1205, 25, GetScriptAreaParams("Defence"));
	
	Cmd(3, 1208, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 1208, 25, GetScriptAreaParams("Defence"));

	LandReinforcementFromMap(1,"Assauld_inf",0,1300);
	LandReinforcementFromMap(1,"Assauld_inf",0,1400);
	LandReinforcementFromMap(1,"Assauld_inf",0,1500);

	ChangeFormation(1300,3);
	ChangeFormation(1400,3);
	ChangeFormation(1500,3);

	Cmd(3, 1300, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 1300, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 1300, 25, GetScriptAreaParams("Defence"));

	Cmd(3, 1400, 25, GetScriptAreaParams("Defence"));
	Cmd(3, 1500, 25, GetScriptAreaParams("Defence"));
	
	Wait(90);
	
	StartThread(LastAttack_1);
end;

function LastAttack_1()
	attack_num=4;

--Bombing

	LandReinforcementFromMap(1,"Bomber",0,1600);

	Cmd(0, 1600, 50, GetScriptAreaParams("Defence"));
	
	Cmd(16, 400, 80,GetScriptAreaParams("Defence"));
	Cmd(16, 500, 80,GetScriptAreaParams("Defence"));
	
	
--Reconnaissance patrol - scout

	Wait(5);
	
	LandReinforcementFromMap(1,"Razvedka",0,1700);
	LandReinforcementFromMap(1,"Razvedka",0,1800);
	
	Cmd(3, 1700, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 1700, 25, GetScriptAreaParams("Defence"));
	
	Cmd(3, 1800, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 1800, 25, GetScriptAreaParams("Defence"));
	

--Attack and Assault

	LandReinforcementFromMap(1,"Assauld_inf",0,1900);
	LandReinforcementFromMap(1,"Assauld_inf",0,2000);
	LandReinforcementFromMap(1,"Assauld_inf",1,2100);
	LandReinforcementFromMap(1,"Assauld_inf",1,2105);
	LandReinforcementFromMap(1,"anti_tank",0,2106);
	LandReinforcementFromMap(1,"anti_tank",0,2107);
	
	ChangeFormation(1900,3);
	ChangeFormation(2000,3);
	ChangeFormation(2100,3);
	ChangeFormation(2105,3);
	
	Cmd(3, 1900, 25, GetScriptAreaParams("shturmovka"));
	Cmd(3, 2000, 25, GetScriptAreaParams("Defence"));
	Cmd(0, 2100, 25, GetScriptAreaParams("move"));
	QCmd(3, 2100, 25, GetScriptAreaParams("Left_zone"));
	QCmd(3, 2100, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 2100, 25, GetScriptAreaParams("Defence"));
	
	Wait(2);
	
	QCmd(3, 2105, 25, GetScriptAreaParams("Left_zone"));
	QCmd(3, 2105, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 2105, 25, GetScriptAreaParams("Defence"));
	
	Wait(3);
	
	QCmd(3, 2106, 25, GetScriptAreaParams("Left_zone"));
	QCmd(3, 2106, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 2106, 25, GetScriptAreaParams("Defence"));
	
	QCmd(3, 2107, 25, GetScriptAreaParams("Left_zone"));
	QCmd(3, 2107, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 2107, 25, GetScriptAreaParams("Defence"));
	
	Wait(110);
	StartThread(Last_Atack_2);
	
end;

function Last_Atack_2()

--Reconnaissance
	
	LandReinforcementFromMap(1,"Razvedka",0,2200);
	LandReinforcementFromMap(1,"Razvedka",0,2300);
	
	Cmd(3, 2200, 25, GetScriptAreaParams("shturmovka"));
	Cmd(3, 2300, 25, GetScriptAreaParams("Defence"));
	
	Wait(10);

--Attack
	
	LandReinforcementFromMap(1,"Razvedka",0,2400);
	Cmd(3, 2400, 25, GetScriptAreaParams("manevr_til"));
	QCmd(3, 2400, 25, GetScriptAreaParams("Defence"));
	Wait(1);
	LandReinforcementFromMap(1,"anti_tank",0,2500);
	Cmd(3, 2500, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 2500, 25, GetScriptAreaParams("Defence"));
	Wait(2);
	LandReinforcementFromMap(1,"anti_tank",0,2600);
	Cmd(3, 2600, 25, GetScriptAreaParams("shturmovka"));
	QCmd(3, 2600, 25, GetScriptAreaParams("Defence"));
	Wait(1);
	LandReinforcementFromMap(1,"anti_tank",1,2700);
	Cmd(3, 2700, 25, GetScriptAreaParams("Defence"));
	Wait(1);
	LandReinforcementFromMap(1,"anti_tank",1,2800);
	Cmd(3, 2800, 25, GetScriptAreaParams("Defence"));

--Final - Victory

	Wait(90);
	CompleteObjective(0);
	Wait(3);
	StartThread(Pobeda);
end;


function Secret()

	while 1 do
		Wait(1);
		
		if((GetNUnitsInArea(0,'Secret_Zone_1',0)>0) or (GetNUnitsInArea(0,'Secret_Zone_2',0)>0))then
			Wait(1);
			GiveObjective(2);
			
			Wait(2);
			
			CompleteObjective(2);
			
			break;
		end;
		
		
	end;

end;

--Victory and Loose

function Pobeda()
	
	while 1 do
		Wait(1);
		if ((GetNUnitsInScriptGroup(400,1)<1) and (GetNUnitsInScriptGroup(500,1)<1)) then
		Wait(4);
		Win(0);
		
		return 0;
		
		end;

	end;
end;

function GameOver_1()
	while 1 do
		Wait(1);
		if((GetReinforcementCallsLeft(0)==0) and (GetNUnitsInParty(0)==0))then
			Wait(4);
			Win(1);
			
			return 1;
			
		end;
	end;
end;

function GameOver_2()
	while 1 do 
		Wait(1);
		if((GetNUnitsInArea(1,'Defence',0)>0) and (GetNUnitsInArea(0,'Defence',0)==0))then
			Wait(4);
			Win(1);
			
			return 1;
			
		end;
	end;
end;
----------------

---MAIN_START

StartThread(StartArt_and_Bomb);
StartThread(GameOver_1);
StartThread(GameOver_2);
StartThread(Secret);