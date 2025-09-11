--Sevastopol

--Global

battery_live=0;

Spy_1=100;
Spy_2=110;
Spy_3=115;
Spy_4=120;

Tank_1=150;
Tank_2=155;
Tank_3=160;
Tank_4=165;
Tank_5=170;
Tank_6=175;
Tank_7=180;
Tank_8=185;

Inf_1=200;
Inf_2=210;
Inf_3=215;
Inf_4=220;
Inf_5=225;
Inf_6=230;
Inf_7=235;
Inf_8=240;
Inf_9=245;
Inf_10=250;

MainInf_W1=300;
MainInf_W1_2=310;
MainInf_W1_3=315;
MainInf_W1_4=320;
MainInf_W1_5=325;
MainInf_W1_6=330;

AssauldInf_W1=335;
AssauldInf_W1_2=340;
AssauldInf_W1_3=345;
AssauldInf_W1_4=350;

Battery=400;

Tank_Destroyer_1=410;
Tank_Destroyer_2=420;

WAVE_2_INF_L=450;
WAVE_2_INF_R=455;
WAVE_2_ASSAULD_L=460;
WAVE_2_ASSAULD_R=465;
WAVE_2_TANK_1=470;
WAVE_2_TANK_2=475;


--Main_Func

function Start_Game()
	Wait(5);
	GiveObjective(0);
	Wave_3_inf_R();
	Wave_3_inf_L();
	Wave_4_inf();
	Wait(30);
	Wave_1();
	Wave_2();
	Wait(65);
	Last_Wave();
	
end;

function Wave_1()
	--Spy_go
	--Spy_1
	
	Cmd(0, Spy_1, 1, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Spy_1, 1, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Spy_1, 1, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Spy_1, 1, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Spy_1, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Spy_2
	
	
	
	Cmd(0, Spy_2, 1, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Spy_2, 1, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Spy_2, 1, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Spy_2, 1, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Spy_2, 1, GetScriptAreaParams("Left_Zone_Attack"));
	
	--Tank_Attack
	--Tank_1
	
	Cmd(0, Tank_1, 1, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_1, 1, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_1, 1, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_1, 1, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Tank_1, 1, GetScriptAreaParams("Left_Zone_Attack"));
	
	--Tank_2
	
	
	
	Cmd(0, Tank_2, 1, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_2, 1, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_2, 1, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_2, 1, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Tank_2, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_3
	
	Cmd(0, Tank_3, 1, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_3, 1, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_3, 1, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_3, 1, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Tank_3, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_4
	
	Cmd(0, Tank_4, 1, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_4, 1, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_4, 1, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_4, 1, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Tank_4, 1, GetScriptAreaParams("Left_Zone_Attack"));
	
end;

function Wave_2()
	--Spy_go
	--Spy_3
	
	Cmd(0, Spy_3, 1, GetScriptAreaParams("right_move_1"));
	QCmd(0, Spy_3, 1, GetScriptAreaParams("right_move_2"));
	QCmd(3, Spy_3, 1, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Spy_3, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Spy_4
	
	
	Cmd(0, Spy_4, 1, GetScriptAreaParams("right_move_1"));
	QCmd(0, Spy_4, 1, GetScriptAreaParams("right_move_2"));
	QCmd(3, Spy_4, 1, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Spy_4, 1, GetScriptAreaParams("right_Zone_Attack"));
	
	--Tank_Attack
	--Tank_5
	
	Cmd(0, Tank_5, 1, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_5, 1, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_5, 1, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Tank_5, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_6
	
	Cmd(0, Tank_6, 1, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_6, 1, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_6, 1, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Tank_6, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_7
	
	Cmd(0, Tank_7, 1, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_7, 1, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_7, 1, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Tank_7, 1, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_8
	
	Cmd(0, Tank_8, 1, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_8, 1, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_8, 1, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Tank_8, 1, GetScriptAreaParams("right_Zone_Attack"));
	
end;

function Wave_3_inf_R()
	--inf_go
	--Inf_7
	
	Cmd(0, Inf_7, 10, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_7, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_7, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_7, 10, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Inf_7, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_8
	
	Cmd(0, Inf_8, 10, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_8, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_8, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_8, 10, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Inf_8, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_9
	
	Cmd(0, Inf_9, 10, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_9, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_9, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_9, 10, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Inf_9, 10, GetScriptAreaParams("right_Zone_Attack"));
	
	--Inf_10
	
	Cmd(0, Inf_10, 10, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_10, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_10, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_10, 10, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Inf_10, 10, GetScriptAreaParams("right_Zone_Attack"));
end;

function Wave_3_inf_L()
	--inf_go
	--Inf_1
	Cmd(0, Inf_1, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Inf_1, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Inf_1, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Inf_1, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Inf_1, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Inf_1, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_2
	
	Cmd(0, Inf_2, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Inf_2, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Inf_2, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Inf_2, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Inf_2, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Inf_2, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_3
	
	Cmd(0, Inf_3, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Inf_3, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Inf_3, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Inf_3, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Inf_3, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Inf_3, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_4
	
	Cmd(0, Inf_4, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Inf_4, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Inf_4, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Inf_4, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Inf_4, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Inf_4, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_5
	
	Cmd(0, Inf_5, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Inf_5, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Inf_5, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Inf_5, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Inf_5, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Inf_5, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_6
	
	Cmd(0, Inf_6, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Inf_6, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Inf_6, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Inf_6, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Inf_6, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Inf_6, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
end;

function Wave_4_inf()
	Get_Reinf_Inf();
	
	Wait(2);
	--Main_Go
	Cmd(0, MainInf_W1, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, MainInf_W1, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, MainInf_W1, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, MainInf_W1, 15, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, MainInf_W1, 15, GetScriptAreaParams("Center_Zone_Attack"));
	QCmd(3, MainInf_W1, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, MainInf_W1, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, MainInf_W1, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, MainInf_W1, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, MainInf_W1_3, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, MainInf_W1_3, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, MainInf_W1_3, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, MainInf_W1_3, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, MainInf_W1_3, 15, GetScriptAreaParams("Center_Zone_Attack"));
	QCmd(3, MainInf_W1_3, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, MainInf_W1_3, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, MainInf_W1_3, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, MainInf_W1_3, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, MainInf_W1_2, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, MainInf_W1_2, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, MainInf_W1_2, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, MainInf_W1_2, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, MainInf_W1_2, 15, GetScriptAreaParams("right_Zone_Attack"));
	QCmd(3, MainInf_W1_2, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, MainInf_W1_2, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, MainInf_W1_2, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, MainInf_W1_2, 15, GetScriptAreaParams("Target_Zone"));
	
	--Elite_Go
	
	Cmd(0, AssauldInf_W1, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, AssauldInf_W1, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, AssauldInf_W1, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, AssauldInf_W1, 15, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, AssauldInf_W1, 15, GetScriptAreaParams("Center_Zone_Attack"));
	QCmd(3, AssauldInf_W1, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, AssauldInf_W1, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, AssauldInf_W1, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, AssauldInf_W1, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, AssauldInf_W1_2, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, AssauldInf_W1_2, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, AssauldInf_W1_2, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, AssauldInf_W1_2, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, AssauldInf_W1_2, 15, GetScriptAreaParams("right_Zone_Attack"));
	QCmd(3, AssauldInf_W1_2, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, AssauldInf_W1_2, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, AssauldInf_W1_2, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, AssauldInf_W1_2, 15, GetScriptAreaParams("Target_Zone"));
	
	
	--Main_Go
	
	Cmd(0, MainInf_W1_4, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, MainInf_W1_4, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, MainInf_W1_4, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, MainInf_W1_4, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("road_1"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("road_2"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("road_3"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("road_3_1"));
	QCmd(3, MainInf_W1_4, 15, GetScriptAreaParams("base"));
	
	Cmd(0, MainInf_W1_5, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, MainInf_W1_5, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, MainInf_W1_5, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, MainInf_W1_5, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, MainInf_W1_5, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, MainInf_W1_5, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, MainInf_W1_5, 15, GetScriptAreaParams("road_1"));
	QCmd(3, MainInf_W1_5, 15, GetScriptAreaParams("road_2"));
	QCmd(3, MainInf_W1_5, 15, GetScriptAreaParams("road_3"));
	QCmd(3, MainInf_W1_5, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, MainInf_W1_6, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, MainInf_W1_6, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, MainInf_W1_6, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, MainInf_W1_6, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, MainInf_W1_6, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, MainInf_W1_6, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, MainInf_W1_6, 15, GetScriptAreaParams("road_1"));
	QCmd(3, MainInf_W1_6, 15, GetScriptAreaParams("road_2"));
	QCmd(3, MainInf_W1_6, 15, GetScriptAreaParams("road_3"));
	QCmd(3, MainInf_W1_6, 15, GetScriptAreaParams("Target_Zone"));
	
	--Elite_Go
	
	Cmd(0, AssauldInf_W1_3, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, AssauldInf_W1_3, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, AssauldInf_W1_3, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, AssauldInf_W1_3, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, AssauldInf_W1_3, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, AssauldInf_W1_3, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, AssauldInf_W1_3, 15, GetScriptAreaParams("road_1"));
	QCmd(3, AssauldInf_W1_3, 15, GetScriptAreaParams("road_2"));
	QCmd(3, AssauldInf_W1_3, 15, GetScriptAreaParams("road_3"));
	QCmd(3, AssauldInf_W1_3, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, AssauldInf_W1_4, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, AssauldInf_W1_4, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, AssauldInf_W1_4, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, AssauldInf_W1_4, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, AssauldInf_W1_4, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, AssauldInf_W1_4, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, AssauldInf_W1_4, 15, GetScriptAreaParams("road_1"));
	QCmd(3, AssauldInf_W1_4, 15, GetScriptAreaParams("road_2"));
	QCmd(3, AssauldInf_W1_4, 15, GetScriptAreaParams("road_3"));
	QCmd(3, AssauldInf_W1_4, 15, GetScriptAreaParams("Target_Zone"));
	
	--Tank_Go
	
	Cmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("road_1"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("road_2"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("road_3"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_Destroyer_2, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("right_Zone_Attack"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, Tank_Destroyer_2, 15, GetScriptAreaParams("Target_Zone"));
	
end;

function Last_Wave()
	Get_Reinf_Last_Wave();
	
	Cmd(0, WAVE_2_INF_R, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, WAVE_2_INF_R, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, WAVE_2_INF_R, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, WAVE_2_INF_R, 15, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, WAVE_2_INF_R, 15, GetScriptAreaParams("Center_Zone_Attack"));
	QCmd(3, WAVE_2_INF_R, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, WAVE_2_INF_R, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, WAVE_2_INF_R, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, WAVE_2_INF_R, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, WAVE_2_INF_L, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, WAVE_2_INF_L, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, WAVE_2_INF_L, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, WAVE_2_INF_L, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, WAVE_2_INF_L, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, WAVE_2_INF_L, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, WAVE_2_INF_L, 15, GetScriptAreaParams("road_1"));
	QCmd(3, WAVE_2_INF_L, 15, GetScriptAreaParams("road_2"));
	QCmd(3, WAVE_2_INF_L, 15, GetScriptAreaParams("road_3"));
	QCmd(3, WAVE_2_INF_L, 15, GetScriptAreaParams("Target_Zone"));
	
	Wait(10);
	
	Cmd(0, WAVE_2_TANK_1, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, WAVE_2_TANK_1, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, WAVE_2_TANK_1, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, WAVE_2_TANK_1, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, WAVE_2_TANK_1, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, WAVE_2_TANK_1, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, WAVE_2_TANK_1, 15, GetScriptAreaParams("road_1"));
	QCmd(3, WAVE_2_TANK_1, 15, GetScriptAreaParams("road_2"));
	QCmd(3, WAVE_2_TANK_1, 15, GetScriptAreaParams("road_3"));
	QCmd(3, WAVE_2_TANK_1, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, WAVE_2_TANK_2, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, WAVE_2_TANK_2, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, WAVE_2_TANK_2, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, WAVE_2_TANK_2, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, WAVE_2_TANK_2, 15, GetScriptAreaParams("right_Zone_Attack"));
	QCmd(3, WAVE_2_TANK_2, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, WAVE_2_TANK_2, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, WAVE_2_TANK_2, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, WAVE_2_TANK_2, 15, GetScriptAreaParams("Target_Zone"));
	
end;

--Slave_Func

function Get_Reinf_Inf()
	--MainInf
	LandReinforcementFromMap(1, "Main_inf", 0, MainInf_W1);
	Cmd(0, MainInf_W1, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(MainInf_W1, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, MainInf_W1_2);
	Cmd(0, MainInf_W1_2, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(MainInf_W1_2, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, MainInf_W1_3);
	Cmd(0, MainInf_W1_3, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(MainInf_W1_3, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, MainInf_W1_4);
	Cmd(0, MainInf_W1_4, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(MainInf_W1_4, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, MainInf_W1_5);
	Cmd(0, MainInf_W1_5, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(MainInf_W1_5, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, MainInf_W1_6);
	Cmd(0, MainInf_W1_6, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(MainInf_W1_6, 3);
	
	--EliteInf
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, AssauldInf_W1);
	Cmd(0, AssauldInf_W1, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(AssauldInf_W1, 3);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, AssauldInf_W1_2);
	Cmd(0, AssauldInf_W1_2, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(AssauldInf_W1_2, 3);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, AssauldInf_W1_3);
	Cmd(0, AssauldInf_W1_3, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(AssauldInf_W1_3, 3);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, AssauldInf_W1_4);
	Cmd(0, AssauldInf_W1_4, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(AssauldInf_W1_4, 3);
	
	Wait(15);
	
	LandReinforcementFromMap(1, "Tank_Des", 0, Tank_Destroyer_1);
	Cmd(0, Tank_Destroyer_1, 5, GetScriptAreaParams("rally_point_1"));
	
	LandReinforcementFromMap(1, "Tank_Des", 0, Tank_Destroyer_2);
	Cmd(0, Tank_Destroyer_2, 5, GetScriptAreaParams("rally_point_2"));
	
	
end;

function Get_Reinf_Last_Wave()
	
	--MainInf
	
	LandReinforcementFromMap(1, "Main_inf", 0, WAVE_2_INF_L);
	Cmd(0, WAVE_2_INF_L, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(WAVE_2_INF_L, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, WAVE_2_INF_L);
	Cmd(0, WAVE_2_INF_L, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(WAVE_2_INF_L, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, WAVE_2_INF_L);
	Cmd(0, WAVE_2_INF_L, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(WAVE_2_INF_L, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, WAVE_2_INF_R);
	Cmd(0, WAVE_2_INF_R, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(WAVE_2_INF_R, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, WAVE_2_INF_R);
	Cmd(0, WAVE_2_INF_R, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(WAVE_2_INF_R, 3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, WAVE_2_INF_R);
	Cmd(0, WAVE_2_INF_R, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(WAVE_2_INF_R, 3);
	
	--AssauldInf
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, WAVE_2_ASSAULD_L);
	Cmd(0, WAVE_2_ASSAULD_L, 5, GetScriptAreaParams("rally_point_"));
	ChangeFormation(WAVE_2_ASSAULD_L, 3);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, WAVE_2_ASSAULD_L);
	Cmd(0, WAVE_2_ASSAULD_L, 5, GetScriptAreaParams("rally_point_1"));
	ChangeFormation(WAVE_2_ASSAULD_L, 3);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, WAVE_2_ASSAULD_R);
	Cmd(0, WAVE_2_ASSAULD_R, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(WAVE_2_ASSAULD_R, 3);
	
	LandReinforcementFromMap(1, "Assauld_inf", 0, WAVE_2_ASSAULD_R);
	Cmd(0, WAVE_2_ASSAULD_R, 5, GetScriptAreaParams("rally_point_2"));
	ChangeFormation(WAVE_2_ASSAULD_R, 3);
	
	--TANK
	
	Wait(10);
	
	LandReinforcementFromMap(1, "Tank_Des", 0, WAVE_2_TANK_1);
	Cmd(0, WAVE_2_TANK_1, 5, GetScriptAreaParams("rally_point_1"));
	
	LandReinforcementFromMap(1, "Tank_Des", 0, WAVE_2_TANK_2);
	Cmd(0, WAVE_2_TANK_2, 5, GetScriptAreaParams("rally_point_2"));
	
end;

--Objective_Controls

function Battery_Defence()
	while 1 do
		Wait(3);
		if((GetNUnitsInArea(0, "Target_Zone", 0)==3) and (GetNUnitsInArea(1, "Target_Zone", 0)>0))then
			ChangePlayerForScriptGroup(Battery, 1);
			Wait(60);
			FailObjective(0);
			break;
		end;
	end;
end;

--Win\Loose

--MAIN_START
StartThread(Start_Game);
StartThread(Battery_Defence);