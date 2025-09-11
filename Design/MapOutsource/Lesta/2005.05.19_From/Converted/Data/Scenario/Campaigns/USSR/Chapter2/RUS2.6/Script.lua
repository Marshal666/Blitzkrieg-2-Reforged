--Night_Landing

--Global
armored_units=0;

--column
	--moto
	First_moto=500;
	Second_moto=510;
	Alarm_moto=515;
	Alarm_moto_1=2100;
	Alarm_moto_2=2150;
	
	--Machinery
	
	Machinery_1=520;
	Machinery_2=525;
	
	--Transport_for_gun
	
	Transport_for_gun_1=550;
	Transport_for_gun_2=555;

	--Gun

	Gun_1=600;
	Gun_2=610;

	--Machinery

	LastMachinery=530;
	
--Coast_Battery

	--Transport_for_gun
	
	Transport_for_gun_3=350;
	Transport_for_gun_4=400;
	
	--Gun
	
	Gun_3=410;
	Gun_4=415;
	
	--Alarm_Machinery
	
	Alarm_Machinery_1=420;
	Alarm_Machinery_2=425;
	
	--Alarm_Inf
	
	Inf_1=1000;
	Inf_2=1100;
	
--Secret

	--SecretTank
	
	SecretTank_1=800;
	SecretTank_2=810;
	
--Village_reinf
	
	--Tank
	
	Tank_1=900;
	Tank_2=910;
	
	--Reinf_Machinery
	
	Reinf_Machinery_1=915;
	Reinf_Machinery_2=920;
	Reinf_Machinery_3=925;
	Reinf_Machinery_4=930;
	Reinf_Machinery_5=935;
	Reinf_Machinery_6=940;
	
--Marines - landing_operation

	--Boat
	
	Boat_1=100;
	Boat_2=150;
	
	--Marines
	
	Elite=200;
	Sniper=250;
	Main_Marines=300;
	
--Armored_units_Column

	Moto_Column_1=700;
	Moto_Column_2=710;
	
--Rein_from_Map

	Reinf_Tank=1500;
	Reinf_Inf=1600;

--CoastParty

	Coast_Inf=2000;

--Main_Function

function Landing()
	Wait(1);
	
	Cmd(ACT_MOVE, Boat_1, 1, 5145, 4867);
	QCmd(ACT_UNLOAD, Boat_1, 1, 5060, 4911);
	
	Cmd(ACT_MOVE, Boat_2, 1, 5769, 5137);
	QCmd(ACT_UNLOAD, Boat_2, 1, 5611, 5274);
	
	Wait(34);
	
	Cmd(0, Boat_1, 1, GetScriptAreaParams("Destroy"));
	QCmd(ACT_DISAPPEAR, Boat_1);
	
	Cmd(0, Boat_2, 1, GetScriptAreaParams("Destroy"));
	QCmd(ACT_DISAPPEAR, Boat_2);
	
end;

function battery_move()
	--moto_move
	--1
	
	GiveObjective(0);
	Wait(50);
	
	
	Cmd(3, First_moto, 1, GetScriptAreaParams("move_1"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_2"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_3"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_4"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_5"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_6"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_7"));
	QCmd(3, First_moto, 1, GetScriptAreaParams("move_8"));
	QCmd(3, First_moto, 10, GetScriptAreaParams("moto_parking"));
	--2
	Wait(1);
	
	Cmd(3, Second_moto, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_5"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_6"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_7"));
	QCmd(3, Second_moto, 1, GetScriptAreaParams("move_8"));
	QCmd(3, Second_moto, 10, GetScriptAreaParams("moto_parking"));
	--3
	Wait(1);
	
	Cmd(3, Alarm_moto, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_5"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_6"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_7"));
	QCmd(3, Alarm_moto, 1, GetScriptAreaParams("move_8"));
	QCmd(3, Alarm_moto, 10, GetScriptAreaParams("moto_parking"));
	
	
	--Alarm_masters
	Wait(2);
	
	Cmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_5"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_6"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_7"));
	QCmd(3, Alarm_moto_1, 1, GetScriptAreaParams("move_8"));
	QCmd(3, Alarm_moto_1, 10, GetScriptAreaParams("moto_parking"));
	
	Cmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_5"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_6"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_7"));
	QCmd(3, Alarm_moto_2, 1, GetScriptAreaParams("move_8"));
	QCmd(3, Alarm_moto_2, 10, GetScriptAreaParams("moto_parking"));
	
	--Machinery_move
	--1
	Wait(1);
	
	Cmd(3, Machinery_1, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Machinery_1, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Machinery_1, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Machinery_1, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Machinery_1, 1, GetScriptAreaParams("move_5"));
	QCmd(3, Machinery_1, 1, GetScriptAreaParams("move_6"));
	QCmd(3, Machinery_1, 1, GetScriptAreaParams("move_7"));
	QCmd(3, Machinery_1, 10, GetScriptAreaParams("parking"));
	--2
	Wait(1);
	
	Cmd(3, Machinery_2, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Machinery_2, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Machinery_2, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Machinery_2, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Machinery_2, 1, GetScriptAreaParams("move_5"));
	QCmd(3, Machinery_2, 1, GetScriptAreaParams("move_6"));
	QCmd(3, Machinery_2, 1, GetScriptAreaParams("move_7"));
	QCmd(3, Machinery_2, 10, GetScriptAreaParams("parking"));
	--Battery_move
	--1
	Wait(1);
	
	Cmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_1"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_2"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_3"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_4"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_5"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_6"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_7"));
	QCmd(0, Transport_for_gun_1, 1, GetScriptAreaParams("move_8"));
	QCmd(0, Transport_for_gun_1, 10, GetScriptAreaParams("target_point"));
	--2
	Wait(1);
	
	Cmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_1"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_2"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_3"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_4"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_5"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_6"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_7"));
	QCmd(0, Transport_for_gun_2, 1, GetScriptAreaParams("move_8"));
	QCmd(0, Transport_for_gun_2, 10, GetScriptAreaParams("target_point"));
	--Machinery_move
	--3
	
	Wait(5);
	
	Cmd(3, LastMachinery, 1, GetScriptAreaParams("move_1"));
	QCmd(3, LastMachinery, 1, GetScriptAreaParams("move_2"));
	QCmd(3, LastMachinery, 1, GetScriptAreaParams("move_3"));
	QCmd(3, LastMachinery, 1, GetScriptAreaParams("move_4"));
	QCmd(3, LastMachinery, 1, GetScriptAreaParams("move_5"));
	QCmd(3, LastMachinery, 1, GetScriptAreaParams("move_6"));
	QCmd(3, LastMachinery, 1, GetScriptAreaParams("move_7"));
	QCmd(3, LastMachinery, 10, GetScriptAreaParams("parking"));
	
	Wait(10);
	
	Armored_units_Contoroller();
	
	armored_units=1;
	
end;

function Obj_Controller_1()
	while 1 do
		Wait(1);
		if((GetNScriptUnitsInArea(Transport_for_gun_1, "target_point", 0)>0) and (GetNScriptUnitsInArea(Transport_for_gun_2, "target_point", 0)>0))then
			GiveObjective(1);
			break;
		end;
	end;
end;

function Obj_0_Complete()
	while 1 do
		Wait(1);
		if((GetNUnitsInScriptGroup(Gun_1, 1)==0) and (GetNUnitsInScriptGroup(Gun_2, 1)==0) )then
			CompleteObjective(0);
			GiveObjective(1);
			break;
		end;
	end;
end;

function Armored_units_Contoroller() 
	while 1 do
		Wait(1); 
		if(armored_units==1)then 
			Wait(90); 
			a=Random(2); 
			if(a==1)then 
				move_from_0_to_1(); 
			end; 
			if(a==2)then 
				move_from_1_to_0(); 
			end; 
		end;
		Wait(1);
		if(armored_units==0)then
			--ViewZone ( "move_10", 1);
			move_from_0_to_1();
		end; 
	end;
end;

function Secret_Task_Controller()
	while 1 do 
		Wait(1);
		if((GetNUnitsInScriptGroup(SecretTank_1, 1)==0) or (GetNUnitsInScriptGroup(SecretTank_2, 1)==0))then
			GiveObjective(2);
		end;
		if((GetNUnitsInScriptGroup(SecretTank_1, 1)==0) and (GetNUnitsInScriptGroup(SecretTank_2, 1)==0))then
			CompleteObjective(2);
			break;
		end;
	end;
end;

function we_are_under_fire()
	while 1 do
		Wait(1);
		if((GetNUnitsNearScriptObj(0, First_moto, 100)>0) or (GetNUnitsNearScriptObj(0, Second_moto, 100)>0) or (GetNUnitsNearScriptObj(0, Alarm_moto, 100)>0) or (GetNUnitsNearScriptObj(0, Machinery_1, 100)>0))then
			
			Cmd(0, Alarm_moto, 5, GetScriptAreaParams("help_me"));
			Cmd(0, Alarm_moto_1, 5, GetScriptAreaParams("help_me"));
			Cmd(0, Alarm_moto_2, 5, GetScriptAreaParams("help_me"));
			
			Wait(5);
			
			StartThread(help_go);
			
			break;
		end;
	end;
end;

function reinf_enemy()
	while 1 do
		Wait(1);
		if((GetNUnitsNearScriptObj(0, Inf_1, 100)>0) or (GetNUnitsNearScriptObj(0, Inf_2, 100)>0))then
			Cmd(0, Alarm_Machinery_1, 5, GetScriptAreaParams("help_me"));
			Wait(2);
			Cmd(0, Alarm_Machinery_2, 5, GetScriptAreaParams("help_me"));
			StartThread(reinf_go);
			break;
		end;
	end;
end;

function Party()
	while 1 do
		Wait(1);
		if(GetNUnitsInArea(1, "Party", 0)>2)then
			Cmd(3, Coast_Inf, 15, GetScriptAreaParams("Party"));
			break;
		end;
	end;
end;

--Slave_Function

function reinf_go()
	while 1 do
		Wait(1);
		if((GetNScriptUnitsInArea(Alarm_Machinery_1, "help_my", 0)>0) or (GetNScriptUnitsInArea(Alarm_Machinery_2, "help_my", 0)>0))then
			Wait(60);
			LandReinforcementFromMap(1, "Tank", 0, Reinf_Tank);
			Cmd(3, Reinf_Tank, 5, GetScriptAreaParams("target_point"));
			Wait(2);
			LandReinforcementFromMap(1, "Assauld_inf", 0, Reinf_Inf);
			ChangeFormation(Reinf_Inf, 3);
			Cmd(3, Reinf_Inf, 5, GetScriptAreaParams("target_point"));
		end;
	end;
end;

function move_from_0_to_1()
	--ViewZone ( "Destroy_2", 1);
	LandReinforcementFromMap(1, "moto", 0, Moto_Column_1);
	Cmd(0, Moto_Column_1, 1, GetScriptAreaParams("move_9"));
	QCmd(3, Moto_Column_1, 1, GetScriptAreaParams("move_10"));
	QCmd(3, Moto_Column_1, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Moto_Column_1, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Moto_Column_1, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Moto_Column_1, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Moto_Column_1, 1, GetScriptAreaParams("Destroy_2"));
	QCmd(ACT_DISAPPEAR, Moto_Column_1);
	Wait(10);
end;

function move_from_1_to_0()
	LandReinforcementFromMap(1, "moto", 0, Moto_Column_2);
	Cmd(3, Moto_Column_2, 1, GetScriptAreaParams("move_1"));
	QCmd(3, Moto_Column_2, 1, GetScriptAreaParams("move_2"));
	QCmd(3, Moto_Column_2, 1, GetScriptAreaParams("move_3"));
	QCmd(3, Moto_Column_2, 1, GetScriptAreaParams("move_4"));
	QCmd(3, Moto_Column_2, 1, GetScriptAreaParams("move_10"));
	QCmd(3, Moto_Column_2, 1, GetScriptAreaParams("move_9"));
	QCmd(3, Moto_Column_2, 1, GetScriptAreaParams("Destroy_3"));
	QCmd(ACT_DISAPPEAR, Moto_Column_2);
	Wait(10);
end;

function help_go()
	while 1 do
		Wait(1);
		if((GetNScriptUnitsInArea(Alarm_moto, "help_my", 0)>0) and (GetNScriptUnitsInArea(Alarm_moto_1, "help_my", 0)>0) and (GetNScriptUnitsInArea(Alarm_moto_2, "help_my", 0)>0))then
			Cmd(3, Alarm_moto, 5, GetScriptAreaParams("help"));
			Cmd(3, Alarm_moto_1, 5, GetScriptAreaParams("help"));
			Cmd(3, Alarm_moto_2, 5, GetScriptAreaParams("help"));
			Cmd(3, SecretTank_1, 5, GetScriptAreaParams("help"));
			Cmd(3, SecretTank_2, 5, GetScriptAreaParams("help"));
			Cmd(3, Tank_1, 5, GetScriptAreaParams("help"));
			Cmd(3, Tank_2, 5, GetScriptAreaParams("help"));
			Cmd(3, Reinf_Machinery_1, 5, GetScriptAreaParams("help"));
			Cmd(3, Reinf_Machinery_2, 5, GetScriptAreaParams("help"));
			Cmd(3, Reinf_Machinery_3, 5, GetScriptAreaParams("help"));
			Cmd(3, Reinf_Machinery_4, 5, GetScriptAreaParams("help"));
			Cmd(3, Reinf_Machinery_5, 5, GetScriptAreaParams("help"));
			Cmd(3, Reinf_Machinery_6, 5, GetScriptAreaParams("help"));
			
			Wait(20);
			
			StartThread(Go_to_home);
			
			break;
		end;
	end;
end;

function Go_to_home()
	Cmd(3, Alarm_moto, 25, GetScriptAreaParams("reinf_1"));
	Cmd(3, SecretTank_1, 25, GetScriptAreaParams("reinf_1"));
	Cmd(3, SecretTank_2, 25, GetScriptAreaParams("reinf_1"));
	Cmd(3, Tank_1, 25, GetScriptAreaParams("reinf_2"));
	Cmd(3, Tank_2, 25, GetScriptAreaParams("reinf_2"));
	Cmd(3, Reinf_Machinery_1, 25, GetScriptAreaParams("reinf_3"));
	Cmd(3, Reinf_Machinery_2, 25, GetScriptAreaParams("reinf_3"));
	Cmd(3, Reinf_Machinery_3, 25, GetScriptAreaParams("reinf_4"));
	Cmd(3, Reinf_Machinery_4, 25, GetScriptAreaParams("reinf_4"));
	Cmd(3, Reinf_Machinery_5, 25, GetScriptAreaParams("reinf_5"));
	Cmd(3, Reinf_Machinery_6, 25, GetScriptAreaParams("reinf_5"));
end;

--Win\Loose
function Player_Win()
	while 1 do
		Wait(1);
		if((GetNUnitsInScriptGroup(Gun_3, 1)==0) and (GetNUnitsInScriptGroup(Gun_4, 1)==0) and (GetNUnitsInScriptGroup(Gun_1, 1)==0) and (GetNUnitsInScriptGroup(Gun_2, 1)==0))then
			Wait(5);
			
			Win(0);
			
			return 0;
		end;
	end;
end;

function Player_Loose()
	while 1 do
		Wait(1);
		if((GetReinforcementCallsLeft(0)==0) and (GetNUnitsInScriptGroup(Elite, 0)==0) and (GetNUnitsInScriptGroup(Sniper, 0)==0) and (GetNUnitsInScriptGroup(Main_Marines, 0)==0) and (IsSomeUnitInParty(0)~1))then
			Wait(5);
			
			Win(1);
			
			return 1;
		end;
	end;
end;
--MAIN_START
StartThread(Landing);
StartThread(battery_move);
StartThread(Obj_Controller_1);
StartThread(Obj_0_Complete);
StartThread(Secret_Task_Controller);
StartThread(we_are_under_fire);
StartThread(reinf_enemy);
StartThread(Party);
StartThread(Player_Win);
StartThread(Player_Loose);