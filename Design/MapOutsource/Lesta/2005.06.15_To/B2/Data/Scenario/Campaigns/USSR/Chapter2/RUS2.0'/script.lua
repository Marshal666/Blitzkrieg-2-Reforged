--Sevastopol

--Global

battery_live=0;
Last_Wave_at=0;
Test_Obj=0;
Obj_3_Fail=0;
BOAT_1_HP=1;
BOAT_2_HP=1;
Train=1000;

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

Spy_Air_1=500;
Spy_Air_2=510;
Spy_Air_3=515;

AA_GUN_1=550;
AA_GUN_2=555;
AA_GUN_3=560;

GUN_1=600;
GUN_2=610;

BOAT_1=650;
BOAT_2=655;

GAP_1=660;
GAP_2=665;

BOMBER_1=670;
BOMBER_2=675;

CAR_EV_1=700;
CAR_EV_2=710;
CAR_EV_3=715;
CAR_EV_4=720;
CAR_EV_5=725;

MAIN_EV_1=730;
MAIN_EV_2=735;
MAIN_EV_3=740;
MAIN_EV_4=745;
MAIN_EV_5=750;

Car_Col=0;
Main_Col=0;

Spy_5=800;
Spy_6=810;

Tank_9=815;
Tank_10=820;
Tank_11=825;

SPY_ATTACK_1=830;
SPY_ATTACK_2=835;

ATTACK_INF_1=840;
ATTACK_INF_2=845;
ATTACK_INF_3=850;
ATTACK_INF_4=855;
ATTACK_INF_5=860;
ATTACK_INF_6=865;
ATTACK_INF_7=870;

SPY_ATTACK_3=875;
SPY_ATTACK_4=880;
SPY_ATTACK_5=885;
SPY_ATTACK_6=890;

GER_BAT_1=900;
GER_BAT_2=910;

Para_1=1100;
Para_2=1110;
Para_3=1115;
Para_4=1120;

GAP_3=1125;
GAP_4=1130;

AT_BOAT_1=1135;
AT_BOAT_2=1140;

AL_SHIP_1=1145;

--Main_Func

function Start_Game()
	Wait(5);
	GiveObjective(0);
	SetGlobalVar(temp.general_reinforcement,0);
	Wait(3);
	Wave_3_inf_R();
	Wait(3);
	Wave_3_inf_L();
	Wait(3);
	Wave_4_inf();
	Wait(35);
	Wave_1();
	Wave_2();
	Wait(75);
	Last_Wave();
	
end;

function Wave_1()
	--Spy_go
	--Spy_1
	
	Cmd(0, Spy_1, 10, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Spy_1, 10, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Spy_1, 10, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Spy_1, 10, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Spy_1, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Spy_2
	
	Cmd(0, Spy_2, 10, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Spy_2, 10, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Spy_2, 10, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Spy_2, 10, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Spy_2, 10, GetScriptAreaParams("Left_Zone_Attack"));
	
	--Tank_Attack
	--Tank_1
	
	Cmd(0, Tank_1, 10, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_1, 10, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_1, 10, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_1, 10, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Tank_1, 10, GetScriptAreaParams("Left_Zone_Attack"));
	
	--Tank_2
	
	Cmd(0, Tank_2, 10, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_2, 10, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_2, 10, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_2, 10, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Tank_2, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_3
	
	Cmd(0, Tank_3, 10, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_3, 10, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_3, 10, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_3, 10, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Tank_3, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_4
	
	Cmd(0, Tank_4, 10, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_4, 10, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_4, 10, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_4, 10, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, Tank_4, 10, GetScriptAreaParams("Left_Zone_Attack"));
	
end;

function Wave_2()
	--Spy_go
	--Spy_3
	
	Cmd(0, Spy_3, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Spy_3, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Spy_3, 10, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Spy_3, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Spy_4
	
	
	Cmd(0, Spy_4, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Spy_4, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Spy_4, 10, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Spy_4, 10, GetScriptAreaParams("right_Zone_Attack"));
	
	--Tank_Attack
	--Tank_5
	
	Cmd(0, Tank_5, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_5, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_5, 10, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Tank_5, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_6
	
	Cmd(0, Tank_6, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_6, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_6, 10, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Tank_6, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_7
	
	Cmd(0, Tank_7, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_7, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_7, 10, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Tank_7, 10, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Tank_8
	
	Cmd(0, Tank_8, 10, GetScriptAreaParams("right_move_1"));
	QCmd(0, Tank_8, 10, GetScriptAreaParams("right_move_2"));
	QCmd(3, Tank_8, 10, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Tank_8, 10, GetScriptAreaParams("right_Zone_Attack"));
	
end;

function Wave_3_inf_R()
	--inf_go
	--Inf_7
	
	Cmd(0, Inf_7, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_7, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_7, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_7, 15, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, Inf_7, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_8
	
	Cmd(0, Inf_8, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_8, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_8, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_8, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Inf_8, 15, GetScriptAreaParams("Center_Zone_Attack"));
	
	--Inf_9
	
	Cmd(0, Inf_9, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_9, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_9, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_9, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Inf_9, 15, GetScriptAreaParams("right_Zone_Attack"));
	
	--Inf_10
	
	Cmd(0, Inf_10, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, Inf_10, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, Inf_10, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, Inf_10, 15, GetScriptAreaParams("right_move_3_2"));
	QCmd(3, Inf_10, 15, GetScriptAreaParams("right_Zone_Attack"));
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
	
	Cmd(0, Tank_Destroyer_1, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, Tank_Destroyer_1, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, Tank_Destroyer_1, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, Tank_Destroyer_1, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, Tank_Destroyer_1, 15, GetScriptAreaParams("Left_move_4_1"));
	QCmd(3, Tank_Destroyer_1, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, Tank_Destroyer_1, 15, GetScriptAreaParams("road_1"));
	QCmd(3, Tank_Destroyer_1, 15, GetScriptAreaParams("road_2"));
	QCmd(3, Tank_Destroyer_1, 15, GetScriptAreaParams("road_3"));
	QCmd(3, Tank_Destroyer_1, 15, GetScriptAreaParams("Target_Zone"));
	
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
	Last_Wave_at=1;
	
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
	
	Cmd(0, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("slave_move_1"));
	QCmd(0, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("right_move_1"));
	QCmd(0, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("right_move_2"));
	QCmd(3, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("right_move_3_1"));
	QCmd(3, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("Center_Zone_Attack"));
	QCmd(3, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("rail_road_1"));
	QCmd(3, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("rail_road_2"));
	QCmd(3, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("right_attack_zone"));
	QCmd(3, WAVE_2_ASSAULD_L, 15, GetScriptAreaParams("Target_Zone"));
	
	Cmd(0, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Slave_Left_move_1"));
	QCmd(0, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Left_move_1"));
	QCmd(0, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Left_move_2"));
	QCmd(0, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Left_move_3"));
	QCmd(3, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Left_move_4_2"));
	QCmd(3, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Left_Zone_Attack"));
	QCmd(3, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("road_1"));
	QCmd(3, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("road_2"));
	QCmd(3, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("road_3"));
	QCmd(3, WAVE_2_ASSAULD_R, 15, GetScriptAreaParams("Target_Zone"));
	
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
	
	
	
	--TANK
	
	Wait(10);
	
	LandReinforcementFromMap(1, "Tank_Des", 0, WAVE_2_TANK_1);
	Cmd(0, WAVE_2_TANK_1, 5, GetScriptAreaParams("rally_point_1"));
	
	LandReinforcementFromMap(1, "Tank_Des", 0, WAVE_2_TANK_2);
	Cmd(0, WAVE_2_TANK_2, 5, GetScriptAreaParams("rally_point_2"));
	
	
	
end;

function Attack_EV_PL()

    --SQUADS
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_1);
	ChangeFormation(ATTACK_INF_1, 3);
	Cmd(0, ATTACK_INF_1, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_1, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_1, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_2);
	ChangeFormation(ATTACK_INF_2, 3);
	Cmd(0, ATTACK_INF_2, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_2, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_2, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(3);
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_3);
	ChangeFormation(ATTACK_INF_3, 3);
	Cmd(0, ATTACK_INF_3, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_3, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_3, 10, GetScriptAreaParams("Attack_4"));
	

	--Spy_go
	--Spy_5
	LandReinforcementFromMap(1, "SPY_CAR", 0, Spy_5);
	Cmd(0, Spy_5, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, Spy_5, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, Spy_5, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, Spy_5, 10, GetScriptAreaParams("Attack_4"));
	
	--Spy_6
	Wait(1);
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, Spy_6);
	Cmd(0, Spy_6, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, Spy_6, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, Spy_6, 10, GetScriptAreaParams("Attack_3"));
	QCmd(3, Spy_6, 10, GetScriptAreaParams("Attack_4"));
	
	--Tanks
	
	Wait(3);
	
	LandReinforcementFromMap(1, "Tank_Des", 0, Tank_9);
	Cmd(0, Tank_9, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, Tank_9, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, Tank_9, 10, GetScriptAreaParams("Attack_3"));
	QCmd(3, Tank_9, 10, GetScriptAreaParams("Attack_4"));
	
	LandReinforcementFromMap(1, "Tank_Des", 0, Tank_10);
	Cmd(0, Tank_10, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, Tank_10, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, Tank_10, 10, GetScriptAreaParams("Attack_3"));
	QCmd(3, Tank_10, 10, GetScriptAreaParams("Attack_4"));
	
	LandReinforcementFromMap(1, "Tank_Des", 0, Tank_11);
	Cmd(0, Tank_11, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, Tank_11, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, Tank_11, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, Tank_11, 10, GetScriptAreaParams("Attack_4"));
	
	--MACHINERI
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, SPY_ATTACK_1);
	Cmd(0, SPY_ATTACK_1, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, SPY_ATTACK_1, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, SPY_ATTACK_1, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, SPY_ATTACK_1, 10, GetScriptAreaParams("Attack_4"));
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, SPY_ATTACK_2);
	Cmd(0, SPY_ATTACK_2, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, SPY_ATTACK_2, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, SPY_ATTACK_2, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, SPY_ATTACK_2, 10, GetScriptAreaParams("Attack_4"));
	

	Wait(35);
	
	Attack_EV_PL_2();
	
end;

function Attack_EV_PL_2()
	--SQUADS
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_4);
	ChangeFormation(ATTACK_INF_4, 3);
	Cmd(0, ATTACK_INF_4, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_4, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_4, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(2);
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_5);
	ChangeFormation(ATTACK_INF_5, 3);
	Cmd(0, ATTACK_INF_5, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_5, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_5, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(2);
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_6);
	ChangeFormation(ATTACK_INF_1, 6);
	Cmd(0, ATTACK_INF_6, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_6, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_6, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(2);
	
	LandReinforcementFromMap(1, "Main_inf", 0, ATTACK_INF_7);
	ChangeFormation(ATTACK_INF_1, 7);
	Cmd(0, ATTACK_INF_7, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, ATTACK_INF_7, 10, GetScriptAreaParams("Attack_1"));
	QCmd(3, ATTACK_INF_7, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(5);
	
	--MACHINERI
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, SPY_ATTACK_3);
	Cmd(0, SPY_ATTACK_3, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, SPY_ATTACK_3, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, SPY_ATTACK_3, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, SPY_ATTACK_3, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(1);
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, SPY_ATTACK_4);
	Cmd(0, SPY_ATTACK_4, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, SPY_ATTACK_4, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, SPY_ATTACK_4, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, SPY_ATTACK_4, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(1);
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, SPY_ATTACK_5);
	Cmd(0, SPY_ATTACK_5, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, SPY_ATTACK_5, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, SPY_ATTACK_5, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, SPY_ATTACK_5, 10, GetScriptAreaParams("Attack_4"));
	
	Wait(1);
	
	LandReinforcementFromMap(1, "SPY_CAR", 0, SPY_ATTACK_6);
	Cmd(0, SPY_ATTACK_6, 10, GetScriptAreaParams("rally_point_1"));
	QCmd(0, SPY_ATTACK_6, 10, GetScriptAreaParams("Attack_1"));
	QCmd(0, SPY_ATTACK_6, 10, GetScriptAreaParams("Attack_2"));
	QCmd(3, SPY_ATTACK_6, 10, GetScriptAreaParams("Attack_4"));
	
end;

function GUN_GO()
	Trace("AA_GUN_GO");
	
	LandReinforcementFromMap(2, "AA_REINF", 1, AA_GUN_1);
	Cmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, AA_GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, AA_GUN_1, 25, GetScriptAreaParams("AA_GUN_OBJ_1"));
	
	Trace("GUN-1");
	
	Wait(5);
	
	LandReinforcementFromMap(2, "AA_REINF", 1, AA_GUN_2);
	Cmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, AA_GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, AA_GUN_2, 25, GetScriptAreaParams("AA_GUN_OBJ_1"));
	
	Trace("GUN-2");
	
	Wait(4);
	
	LandReinforcementFromMap(2, "AA_REINF", 1, AA_GUN_3);
	Cmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, AA_GUN_3, 5, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, AA_GUN_3, 25, GetScriptAreaParams("AA_GUN_OBJ_1"));
	
	Trace("GUN-3");
	
	Wait(4);
	
	LandReinforcementFromMap(2, "GUN", 1, GUN_1);
	Cmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, GUN_1, 5, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, GUN_1, 25, GetScriptAreaParams("AA_GUN_OBJ_2"));
	
	Trace("GUN-7");
	
	Wait(4);
	
	LandReinforcementFromMap(2, "GUN", 1, GUN_2);
	Cmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, GUN_2, 5, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, GUN_2, 25, GetScriptAreaParams("AA_GUN_OBJ_2"));
	
	Trace("GUN-8");
	
	Wait(5);
	
	StartThread(Cannon_assigned_to_player);
end;

function Spy_go()
	LandReinforcementFromMap(1, "Spy", 0, Spy_Air_1);
	Cmd(0, Spy_Air_1, 15, GetScriptAreaParams("Art_Fire"));
	Wait(2);
	LandReinforcementFromMap(1, "Spy", 0, Spy_Air_2);
	Cmd(0, Spy_Air_2, 15, GetScriptAreaParams("Art_Fire"));
	Wait(2);
	LandReinforcementFromMap(1, "Spy", 0, Spy_Air_3);
	Cmd(0, Spy_Air_3, 15, GetScriptAreaParams("Art_Fire"));
end;

function Art_go()
	Wait(15);
	Cmd(ACT_SUPPRESS, Battery, 20, GetScriptAreaParams("Art_Fire"));
end;

function Cannon_assigned_to_player()
	while 1 do
		Wait(3);
		if(GetNScriptUnitsInArea(GUN_2, "AA_GUN_OBJ_2", 0)>0)then
			
			Trace("Cannon_assigned_to_player");
			
			ChangePlayerForScriptGroup(AA_GUN_1, 0);
			ChangePlayerForScriptGroup(AA_GUN_2, 0);
			ChangePlayerForScriptGroup(AA_GUN_3, 0);
			ChangePlayerForScriptGroup(AA_GUN_4, 0);
			ChangePlayerForScriptGroup(AA_GUN_5, 0);
			ChangePlayerForScriptGroup(AA_GUN_6, 0);
			ChangePlayerForScriptGroup(GUN_1, 0);
			ChangePlayerForScriptGroup(GUN_2, 0);
			ChangePlayerForScriptGroup(GUN_3, 0);
			ChangePlayerForScriptGroup(GUN_4, 0);
			ChangePlayerForScriptGroup(GUN_5, 0);
			ChangePlayerForScriptGroup(GUN_6, 0);
			START_BOAT_MOVING();
			Wait(65);
			BOAT_MOVING_TO_PORT();
			GET_ENEMY_AIR();
			break;
		end;
	end;
end;

function BOAT_MOVING_TO_PORT()
	LandReinforcementFromMap(2, "BOAT", 0, BOAT_2);
	Cmd(0, BOAT_2, 10, GetScriptAreaParams("ship_move_2"));
	QCmd(0, BOAT_2, 10, GetScriptAreaParams("ship_move_1"));
	QCmd(0, BOAT_2, 10, GetScriptAreaParams("ship_stop"));
	
end;

function GET_ENEMY_AIR()
	--GAP
	
	LandReinforcementFromMap(1, "GAP", 1, GAP_1);
	Cmd(0, GAP_1, 25, GetScriptAreaParams("GAP_MOVE"));
	Wait(3);
	LandReinforcementFromMap(1, "GAP", 1, GAP_2);
	Cmd(0, GAP_2, 25, GetScriptAreaParams("GAP_MOVE"));
	
	--BOMBER
	
	Wait(2);
	LandReinforcementFromMap(1, "BOMBER", 1, BOMBER_1);
	Cmd(0, BOMBER_1, 15, GetScriptAreaParams("Evacuate_zone_2"));
	Wait(3);
	LandReinforcementFromMap(1, "BOMBER", 1, BOMBER_2);
	Cmd(0, BOMBER_2, 15, GetScriptAreaParams("Evacuate_zone_2"));
	
end;

function START_BOAT_MOVING()
	Cmd(0, BOAT_1, 10, GetScriptAreaParams("ship_move_1"));
	QCmd(0, BOAT_1, 10, GetScriptAreaParams("ship_move_2"));
	QCmd(0, BOAT_1, 10, GetScriptAreaParams("destroy_zone"));
	QCmd(ACT_DISAPPEAR, BOAT_1);	
end;

function Evacuation_1()
	Trace("Evacuation_Start");
	
	LandReinforcementFromMap(2, "CAR_EV", 1, CAR_EV_1);
	Cmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, CAR_EV_1, 25, GetScriptAreaParams("Evacuate_zone_2"));
	QCmd(ACT_DISAPPEAR, CAR_EV_1);
	Car_Col=Car_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "CAR_EV", 1, CAR_EV_2);
	Cmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, CAR_EV_2, 25, GetScriptAreaParams("Evacuate_zone_2"));
	QCmd(ACT_DISAPPEAR, CAR_EV_2);
	Car_Col=Car_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "CAR_EV", 1, CAR_EV_3);
	Cmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, CAR_EV_3, 25, GetScriptAreaParams("Evacuate_zone_2"));
	QCmd(ACT_DISAPPEAR, CAR_EV_3);
	Car_Col=Car_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "CAR_EV", 1, CAR_EV_4);
	Cmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, CAR_EV_4, 25, GetScriptAreaParams("Evacuate_zone_2"));
	QCmd(ACT_DISAPPEAR, CAR_EV_4);
	Car_Col=Car_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "CAR_EV", 1, CAR_EV_5);
	Cmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_6"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_7"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_8"));
	QCmd(0, CAR_EV_5, 25, GetScriptAreaParams("Evacuate_zone_2"));
	QCmd(ACT_DISAPPEAR, CAR_EV_5);
	Car_Col=Car_Col+1;
	
	Wait(4);
	
	LandReinforcementFromMap(2, "MAIN_EV", 1, MAIN_EV_1);
	ChangeFormation(MAIN_EV_1, 3);
	Cmd(0, MAIN_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("ev_road_1"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("ev_road_2"));
	QCmd(0, MAIN_EV_1, 25, GetScriptAreaParams("Evacuate_zone_1"));
	QCmd(ACT_DISAPPEAR, MAIN_EV_1);
	Main_Col=Main_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "MAIN_EV", 1, MAIN_EV_2);
	ChangeFormation(MAIN_EV_2, 3);
	Cmd(0, MAIN_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("ev_road_1"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("ev_road_2"));
	QCmd(0, MAIN_EV_2, 25, GetScriptAreaParams("Evacuate_zone_1"));
	QCmd(ACT_DISAPPEAR, MAIN_EV_2);
	Main_Col=Main_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "MAIN_EV", 1, MAIN_EV_3);
	ChangeFormation(MAIN_EV_3, 3);
	Cmd(0, MAIN_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("ev_road_1"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("ev_road_2"));
	QCmd(0, MAIN_EV_3, 25, GetScriptAreaParams("Evacuate_zone_1"));
	QCmd(ACT_DISAPPEAR, MAIN_EV_3);
	Main_Col=Main_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "MAIN_EV", 1, MAIN_EV_4);
	ChangeFormation(MAIN_EV_4, 3);
	Cmd(0, MAIN_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("ev_road_1"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("ev_road_2"));
	QCmd(0, MAIN_EV_4, 25, GetScriptAreaParams("Evacuate_zone_1"));
	QCmd(ACT_DISAPPEAR, MAIN_EV_4);
	Main_Col=Main_Col+1;
	
	Wait(3);
	
	LandReinforcementFromMap(2, "MAIN_EV", 1, MAIN_EV_5);
	ChangeFormation(MAIN_EV_5, 3);
	Cmd(0, MAIN_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_1"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_2"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_3"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_4"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("LIFE_ROAD_5"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("ev_road_1"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("ev_road_2"));
	QCmd(0, MAIN_EV_5, 25, GetScriptAreaParams("Evacuate_zone_1"));
	QCmd(ACT_DISAPPEAR, MAIN_EV_5);
	Main_Col=Main_Col+1;
	
	Attack_EV_PL();
	StartThread(Paratrooper);
	
end;

function BOAT_2_EV()
	while 1 do
		Wait(2);
		if((Car_Col==5) and (Main_Col==5) and (GetNScriptUnitsInArea(MAIN_EV_5, "Evacuate_zone_1", 0)>0))then
			Wait(10);
			
			Cmd(0, BOAT_2, 10, GetScriptAreaParams("ship_move_1"));
			QCmd(0, BOAT_2, 10, GetScriptAreaParams("ship_move_2"));
			QCmd(0, BOAT_2, 10, GetScriptAreaParams("destroy_zone"));
			QCmd(ACT_DISAPPEAR, BOAT_2);
			break;
		end;
	end;
end;

function BOAT_ATTACKING_1()
	while 1 do
		Wait(3);
		if(GetNScriptUnitsInArea(MAIN_EV_5, "Evacuate_zone_1", 0)>0)then
			Trace("GO_BOAT_ATTACK");
			BOAT_2_KILL();
			LandReinforcementFromMap(1, "AT_BOAT", 1, AT_BOAT_1);
			Cmd(3, AT_BOAT_1, 25, GetScriptAreaParams("ship_move_1"));
			
			LandReinforcementFromMap(1, "AT_BOAT", 1, AT_BOAT_2);
			Cmd(3, AT_BOAT_2, 25, GetScriptAreaParams("ship_move_1"));
			
			--GAP
			LandReinforcementFromMap(1, "GAP", 1, GAP_1);
			Cmd(0, GAP_3, 10, GetScriptAreaParams("GAP_MOVE"));
			Wait(2);
			LandReinforcementFromMap(1, "GAP", 1, GAP_2);
			Cmd(0, GAP_4, 10, GetScriptAreaParams("GAP_MOVE"));
			
			break;
		end;
	end;
end;

function Alli_Helper()
	while 1 do
		Wait(5);
		if(GetNScriptUnitsInArea(MAIN_EV_5, "Evacuate_zone_1", 0)>0)then
			Wait(5);
			LandReinforcementFromMap(2, "AL_SHIP", 0, AL_SHIP_1);
			Cmd(3, AL_SHIP_1, 25, GetScriptAreaParams("ship_move_1"));
		end;
	end;
end;

--Objective_Controls

function Battery_Defence()
	while 1 do
		Wait(3);
		if((GetNUnitsInArea(0, "Target_Zone", 0)==3) and (GetNUnitsInArea(1, "Target_Zone", 0)>0))then
			ChangePlayerForScriptGroup(Battery, 1);
			BOAT_1_KILL();
			battery_live=2;
			StartThread(Player_attack_Battery);
			Wait(60);
			Spy_and_Fire();
			break;
		end;
	end;
end;

function Spy_and_Fire()
	while 1 do
		Wait(3);
		if((GetNUnitsInArea(0, "Target_Zone", 0)==0) and (GetNUnitsInArea(1, "Target_Zone", 0)>0))then
			FailObjective(0);
			Spy_go();
			Art_go();
			break;
		end;
	end;
end;

function Player_attack_Battery()
	while 1 do
		Wait(3);
		if((GetNUnitsInArea(0, "Target_Zone", 0)>0) and (GetNUnitsInArea(1, "Target_Zone", 0)==3))then
			ChangePlayerForScriptGroup(Battery, 0);
			CompleteObjective(0);
			Wait(2);
			battery_live=1;
			break;
		end;
	end;
end;

function OBJ_1_COM()
	while 1 do
		Wait(2);
		if(Test_Obj==1)then
			Wait(65);
			CompleteObjective(0);
			break;
		end;
	end;
end;

function Obj_2()
	while 1 do
		Wait(3);
		if((battery_live==1) or (Test_Obj==1))then
			Wait(20);
			GUN_GO();
			Wait(65);
			GiveObjective(1);
			Trace("Break");
			break;
		end;
	end;
end;

function Obj_3()
	while 1 do
		Wait(3);
		if(GetNScriptUnitsInArea(BOAT_2, "ship_stop", 0)>0)then
			GiveObjective(2);
			
			Evacuation_1();
			BOAT_2_EV();
			break;
		end;
	end;
end;

function Obj_Test()
	while 1 do
		Wait(3);
		if((GetNUnitsInArea(0, "Target_Zone", 0)>0) and (GetNUnitsInArea(1, "Target_Zone", 0)==0) and (battery_live<2) and (Last_Wave_at==1))then
			Wait(65);
			Test_Obj=1;
			break;
		end;
	end;
end;

function Obj_3_Failed()
	while 1 do
		Wait(3);
		if(GetNUnitsInArea(1, "Attack_4", 0)>0)then
			Trace("FAIL")
			Wait(60);
			FailObjective(2);
			Obj_3_Fail=1;
			break;
		end;
	end;
end;

function BOAT_1_KILL()
	while 1 do
		Wait(3);
		if(GetScriptObjectHPs(BOAT_1)<0)then
			BOAT_1_HP=0;
			break;
		end;
		Wait(2);
		if(GetNScriptUnitsInArea(BOAT_1, "destroy_zone", 0)>0)then
			break;
		end;
	end;
end;

function BOAT_2_KILL()
	while 1 do
		Wait(3);
		if(GetScriptObjectHPs(BOAT_2)<0)then
			BOAT_2_HP=0;
			break;
		end;
		if(GetNScriptUnitsInArea(BOAT_2, "destroy_zone", 0)>0)then
			break;
		end;
	end;
end;

function Paratrooper()
			Trace("PARA_GO!!!");
			ViewZone ( "rally_point_2", 1);
			ViewZone ( "rally_point_1", 1);
			LandReinforcementFromMap(1, "Paratrooper", 0, Para_1);
			Cmd(ACT_UNLOAD, Para_1, 20, 1368, 9596);
			QCmd(3, Para_1, 25, GetScriptAreaParams("Attack_4"));
			
			Wait(2);
			
			LandReinforcementFromMap(1, "Paratrooper", 0, Para_2);
			Cmd(ACT_UNLOAD, Para_2, 20, 1368, 9596);
			QCmd(3, Para_2, 25, GetScriptAreaParams("Attack_4"));
end;

function Obj_4()
	while 1 do
		Wait(3);
		if(GetNScriptUnitsInArea(ATTACK_INF_7, "Attack_1", 0)>0)then
			Wait(25);
			GiveObjective(5);
			SetGlobalVar(temp.general_reinforcement,1);				
			break;
		end;
	end;
end;

--Secret_Task

function Task_1()
	while 1 do
		Wait(3);
		if((GetScriptObjectHPs(GER_BAT_1)<1) or (GetScriptObjectHPs(GER_BAT_2)<1))then
			GiveObjective(3);
			Task_1_Compl();
			break;
		end;
	end;
end;

function Task_1_Compl()
	while 1 do
		Wait(3);
		if((GetScriptObjectHPs(GER_BAT_1)<0) or (GetScriptObjectHPs(GER_BAT_2)<0))then
			CompleteObjective(3);
			break;
		end;
	end;
end;

function Task_2()
	while 1 do
	Wait(3);
		if(GetNUnitsInArea(0, "Train", 0)>0)then
			GiveObjective(4);
			ChangePlayerForScriptGroup(Train, 0);
			Wait(3);
			CompleteObjective(4);
			break;
		end;
	end;
end;

--Win\Loose
function LOOSE_PLAYER()
	while 1 do
		Wait(5);
		if((BOAT_1_HP==0) or (Obj_3_Fail==1) or (BOAT_2_HP==0))then
			Wait(3);
			Win(1);
			return 1;
		end;
	end;
end;

--MAIN_START
StartThread(Start_Game);

StartThread(Task_1);
StartThread(Task_2);
StartThread(Battery_Defence);
StartThread(Obj_2);
StartThread(Obj_3);
StartThread(Obj_3_Failed);
StartThread(Obj_4);
StartThread(OBJ_1_COM);
StartThread(Obj_Test);
StartThread(BOAT_ATTACKING_1);
StartThread(Alli_Helper);
StartThread(LOOSE_PLAYER);