--Night_Landing

--Global
armored_units=0;
a=0;


--column
	--moto
	First_moto=500;
	Second_moto=510;
	Alarm_moto=515;
	Alarm_moto_1=2100;
	Alarm_moto_2=2150;
	
	--Machinery
	
	Machinery_1=520;
	--Machinery_2=525;
	
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
	
--Enemy_Sniper

	En_Sniper_1=2115;
	En_Sniper_2=2110;

--Main_Function

function Landing()
	Wait(1);
	
	local x, y, h = GetScriptAreaParams("goal_for_boat_01");
	Cmd(ACT_MOVE, Boat_1, h, x, y);
	QCmd(ACT_UNLOAD, Boat_1, h, x, y);
	
	local x, y, h = GetScriptAreaParams("goal_for_boat_02");
	Cmd(ACT_MOVE, Boat_2, h, x, y);
	QCmd(ACT_UNLOAD, Boat_2, h, x, y);
	
	Wait(34);
	
	Cmd(0, Boat_1, 1, GetScriptAreaParams("Destroy"));
	QCmd(ACT_DISAPPEAR, Boat_1);
	
	Cmd(0, Boat_2, 1, GetScriptAreaParams("Destroy"));
	QCmd(ACT_DISAPPEAR, Boat_2);
	
end;

function battery_move()
	--moto_move
	--1
	
	Wait(2);
	GiveObjective(0);
	Wait(25);
--	Wait(65);
	
	
	Cmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_SWARM, First_moto, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_MOVE, First_moto, 20, GetScriptAreaParams("moto_parking"));
	
	--2
	Wait(1);
	
	Cmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_SWARM, Second_moto, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_SWARM, Second_moto, 20, GetScriptAreaParams("moto_parking"));
	--3
	Wait(1);
	
	Cmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_MOVE, Alarm_moto, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_MOVE, Alarm_moto, 20, GetScriptAreaParams("moto_parking"));
	
	
	--Alarm_masters
	Wait(1);
	
	Cmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_MOVE, Alarm_moto_1, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_MOVE, Alarm_moto_1, 20, GetScriptAreaParams("moto_parking"));
	
	Cmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_MOVE, Alarm_moto_2, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_MOVE, Alarm_moto_2, 20, GetScriptAreaParams("moto_parking"));
	
	--Machinery_move
	--1
	Wait(1);
	
	Cmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_SWARM, Machinery_1, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_SWARM, Machinery_1, 20, GetScriptAreaParams("parking"));
	QCmd(ACT_STAND, Machinery_1);
	--2
	
	--Battery_move
	--1
	--Wait(1);
	
	Cmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_MOVE, Transport_for_gun_1, 20, GetScriptAreaParams("target_point"));
	--2
	--Wait(1);
	
	Cmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 15, GetScriptAreaParams("move_8"));
	QCmd(ACT_MOVE, Transport_for_gun_2, 20, GetScriptAreaParams("target_point"));
	--Machinery_move
	--3
	
	Wait(4);
	
	Cmd(ACT_MOVE, LastMachinery, 15, GetScriptAreaParams("move_1"));
	QCmd(ACT_MOVE, LastMachinery, 15, GetScriptAreaParams("move_2"));
	QCmd(ACT_MOVE, LastMachinery, 15, GetScriptAreaParams("move_3"));
	QCmd(ACT_MOVE, LastMachinery, 15, GetScriptAreaParams("move_4"));
	QCmd(ACT_MOVE, LastMachinery, 15, GetScriptAreaParams("move_5"));
	QCmd(ACT_SWARM, LastMachinery, 15, GetScriptAreaParams("move_6"));
	QCmd(ACT_SWARM, LastMachinery, 15, GetScriptAreaParams("move_7"));
	QCmd(ACT_SWARM, LastMachinery, 20, GetScriptAreaParams("parking"));
	QCmd(ACT_STAND, LastMachinery);
	
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
--	Trace("Armored_units_Contoroller");
	while 1 do
		Wait(1); 
--		Trace("Armored_units_Contoroller_1");
		if(armored_units==1)then 
			Wait(90); 
			a=Random(2); 
			if(a==1)then 
--				Trace("Armored_units_Contoroller_2");
				move_from_0_to_1(); 
			end; 
			if(a==2)then 
--				Trace("Armored_units_Contoroller_3");
				move_from_1_to_0(); 
			end; 
		end;
		Wait(1);
		if(armored_units==0)then
--			Trace("Armored_units_Contoroller_4");
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
--	Trace("we_are_under_fire");
	while 1 do
		Wait(1);
		if((GetScriptObjectHPs(First_moto)<1) or (GetScriptObjectHPs(Second_moto)<1) or (GetScriptObjectHPs(Alarm_moto)<1) or (GetScriptObjectHPs(Machinery_1)<1))then
--			Trace("we_are_under_fire_help_go");
			Cmd(ACT_MOVE, Alarm_moto, 25, GetScriptAreaParams("move_4"));
			QCmd(ACT_MOVE, Alarm_moto, 25, GetScriptAreaParams("help_me"));
			
			Cmd(ACT_MOVE, Alarm_moto_1, 25, GetScriptAreaParams("move_4"));
			QCmd(ACT_MOVE, Alarm_moto_1, 25, GetScriptAreaParams("help_me"));
			
			Cmd(ACT_MOVE, Alarm_moto_2, 25, GetScriptAreaParams("move_4"));
			QCmd(0, Alarm_moto_2, 25, GetScriptAreaParams("help_me"));
			
			Cmd(ACT_MOVE, First_moto, 25, GetScriptAreaParams("move_4"));
			QCmd(ACT_MOVE, First_moto, 25, GetScriptAreaParams("help_me"));
			
			Cmd(ACT_MOVE, Second_moto, 25, GetScriptAreaParams("move_4"));
			QCmd(ACT_MOVE, Second_moto, 25, GetScriptAreaParams("help_me"));
			
			--Wait(5);
			
			StartThread(help_go);
--			Trace("we_are_under_fire_help_go_execute");
			break;
		end;
	end;
end;

function reinf_enemy()
--	Trace("REINF_ENEMY!!!");
	while 1 do
		Wait(1);
		if(GetNUnitsInArea ( 0, "Alarm", 0)>0)then
--			Trace("REINF_ENEMY_GO!!!");
			Cmd(ACT_MOVE, Alarm_Machinery_1, 5, GetScriptAreaParams("move_6"));
			Wait(4);
			QCmd(ACT_MOVE, Alarm_Machinery_1, 5, GetScriptAreaParams("help_me"));
			Wait(4);
			Cmd(ACT_MOVE, Alarm_Machinery_2, 5, GetScriptAreaParams("move_6"));
			QCmd(ACT_MOVE, Alarm_Machinery_2, 5, GetScriptAreaParams("help_me"));
			StartThread(reinf_go);
--			Trace("REINF_EXECUTE");
			break;
		end;
	end;
end;

function Party()
--	Trace("PARTY!!!");
	while 1 do
		Wait(1);
		if(GetNUnitsInArea(0, "party", 0)>0)then
--			Trace("PARTY_START");
			Cmd(ACT_SWARM, Coast_Inf, 15, GetScriptAreaParams("Party"));
			break;
		end;
	end;
end;

--Slave_Function

function ALL_ENEMY_HOLD_POS_START()
--	Trace("HOLD_POS");
	Cmd(ACT_STAND, SecretTank_1);
	Cmd(ACT_STAND, SecretTank_2);
	Cmd(ACT_STAND, Tank_1);
	Cmd(ACT_STAND, Tank_2);
	Cmd(ACT_STAND, Reinf_Machinery_1);
	Cmd(ACT_STAND, Reinf_Machinery_2);
	Cmd(ACT_STAND, Reinf_Machinery_3);
	Cmd(ACT_STAND, Reinf_Machinery_4);
	Cmd(ACT_STAND, Reinf_Machinery_5);
	Cmd(ACT_STAND, Reinf_Machinery_6);
	Cmd(ACT_STAND, En_Sniper_1);
	Cmd(ACT_STAND, En_Sniper_2);
	Cmd(ACT_STAND, Alarm_Machinery_1);
	Cmd(ACT_STAND, Alarm_Machinery_2);
	
end;

function reinf_go()
--	Trace("reinf_go");
	while 1 do
		Wait(1);
		if((GetNScriptUnitsInArea(Alarm_Machinery_1, "help_me", 0)>0) or (GetNScriptUnitsInArea(Alarm_Machinery_2, "help_me", 0)>0))then
--			Trace("Start_reinf_go");
			Wait(60);
			LandReinforcementFromMap(1, "Tank", 0, Reinf_Tank);
			Cmd(ACT_SWARM, Reinf_Tank, 5, GetScriptAreaParams("target_point"));
			Wait(2);
			LandReinforcementFromMap(1, "Assauld_inf", 0, Reinf_Inf);
			ChangeFormation(Reinf_Inf, 3);
			Cmd(ACT_SWARM, Reinf_Inf, 5, GetScriptAreaParams("target_point"));
		end;
	end;
end;

function move_from_0_to_1()
	--ViewZone ( "Destroy_2", 1);
	LandReinforcementFromMap(1, "moto", 0, Moto_Column_1);
	Cmd(ACT_MOVE, Moto_Column_1, 1, GetScriptAreaParams("move_9"));
	QCmd(ACT_SWARM, Moto_Column_1, 1, GetScriptAreaParams("move_10"));
	QCmd(ACT_SWARM, Moto_Column_1, 1, GetScriptAreaParams("move_4"));
	QCmd(ACT_SWARM, Moto_Column_1, 1, GetScriptAreaParams("move_3"));
	QCmd(ACT_SWARM, Moto_Column_1, 1, GetScriptAreaParams("move_2"));
	QCmd(ACT_SWARM, Moto_Column_1, 1, GetScriptAreaParams("move_1"));
	QCmd(ACT_SWARM, Moto_Column_1, 1, GetScriptAreaParams("Destroy_2"));
	QCmd(ACT_DISAPPEAR, Moto_Column_1);
	Wait(10);
end;

function move_from_1_to_0()
	LandReinforcementFromMap(1, "moto", 0, Moto_Column_2);
	Cmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("move_1"));
	QCmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("move_2"));
	QCmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("move_3"));
	QCmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("move_4"));
	QCmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("move_10"));
	QCmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("move_9"));
	QCmd(ACT_SWARM, Moto_Column_2, 1, GetScriptAreaParams("Destroy_3"));
	QCmd(ACT_DISAPPEAR, Moto_Column_2);
	Wait(10);
end;

function help_go()
--	Trace("HELP_GO_GO");
	while 1 do
		Wait(1);
		if((GetNScriptUnitsInArea(Alarm_moto, "help_me", 0)>0) or (GetNScriptUnitsInArea(Alarm_moto_1, "help_me", 0)>0) or (GetNScriptUnitsInArea(Alarm_moto_2, "help_me", 0)>0) or (GetNScriptUnitsInArea(First_moto, "help_me", 0)>0) or (GetNScriptUnitsInArea(Second_moto, "help_me", 0)>0))then
--			Trace("Start_Help");
			Cmd(ACT_SWARM, Alarm_moto, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Alarm_moto_1, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Alarm_moto_2, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, SecretTank_1, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, SecretTank_2, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Tank_1, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Tank_2, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Reinf_Machinery_1, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Reinf_Machinery_2, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Reinf_Machinery_3, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Reinf_Machinery_4, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Reinf_Machinery_5, 5, GetScriptAreaParams("help"));
			Cmd(ACT_SWARM, Reinf_Machinery_6, 5, GetScriptAreaParams("help"));
			
			Wait(20);
			
			StartThread(Go_to_home);
			
			break;
		end;
	end;
end;

function Go_to_home()
--	Trace("REINF_GO_HOME!!!");
	Cmd(ACT_SWARM, Alarm_moto, 25, GetScriptAreaParams("reinf_1"));
	Cmd(ACT_SWARM, SecretTank_1, 25, GetScriptAreaParams("reinf_1"));
	Cmd(ACT_SWARM, SecretTank_2, 25, GetScriptAreaParams("reinf_1"));
	Cmd(ACT_SWARM, Tank_1, 25, GetScriptAreaParams("reinf_2"));
	Cmd(ACT_SWARM, Tank_2, 25, GetScriptAreaParams("reinf_2"));
	Cmd(ACT_SWARM, Reinf_Machinery_1, 25, GetScriptAreaParams("reinf_3"));
	Cmd(ACT_SWARM, Reinf_Machinery_2, 25, GetScriptAreaParams("reinf_3"));
	Cmd(ACT_SWARM, Reinf_Machinery_3, 25, GetScriptAreaParams("reinf_4"));
	Cmd(ACT_SWARM, Reinf_Machinery_4, 25, GetScriptAreaParams("reinf_4"));
	Cmd(ACT_SWARM, Reinf_Machinery_5, 25, GetScriptAreaParams("reinf_5"));
	Cmd(ACT_SWARM, Reinf_Machinery_6, 25, GetScriptAreaParams("reinf_5"));
end;

--Win\Loose
function Player_Win()
	while 1 do
		Wait(1);
		if((GetNUnitsInScriptGroup(Gun_3, 1)==0) and (GetNUnitsInScriptGroup(Gun_4, 1)==0) and (GetNUnitsInScriptGroup(Gun_1, 1)==0) and (GetNUnitsInScriptGroup(Gun_2, 1)==0))then
			Wait(5);
			CompleteObjective(1)
			Wait (5)
			Win(0);
			
			return 0;
		end;
	end;
end;

function Player_Loose()
	while 1 do
		Wait(1);
		if((GetReinforcementCallsLeft(0)==0) and (GetNUnitsInScriptGroup(Elite, 0)==0) and (GetNUnitsInScriptGroup(Sniper, 0)==0) and (GetNUnitsInScriptGroup(Main_Marines, 0)==0) and (IsSomeUnitInParty(0)~=1))then
			Wait(5);
			
			Win(1);
			
			return 1;
		end;
	end;
end;
--MAIN_START

units = GetObjectListArray( 410 );
for u = 1, units.n do
SetAmmo( units[u], 0, 0 );
end;

units = GetObjectListArray( 415 );
for u = 1, units.n do
SetAmmo( units[u], 0, 0 );
end;

StartThread(Landing);
StartThread(ALL_ENEMY_HOLD_POS_START);
StartThread(battery_move);
StartThread(Obj_Controller_1);
StartThread(Obj_0_Complete);
StartThread(Secret_Task_Controller);
StartThread(we_are_under_fire);
StartThread(reinf_enemy);
StartThread(Party);
StartThread(Player_Win);
StartThread(Player_Loose);