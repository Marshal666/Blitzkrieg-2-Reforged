---------------------------------Flight
function Flight()
	Wait (5);
	while 1 do	
			LandReinforcementFromMap ( 0, 0, 0, 111 );
			QCmd (ACT_MOVE, 111, 0, 2487, 3023 );
			Wait (25);
			Trace("Flight");
	Wait (60);
	end;
end;

----------------------------------Movement
function Drive()
	Wait (10);
	QCmd (ACT_MOVE, 99, 0, 2404, 6806 );
	Wait (5);
	QCmd (ACT_MOVE, 1000, 10, 2800, 10130 );
	Wait (45);
	RemoveScriptGroup( 1000 );
	QCmd (ACT_MOVE, 99, 10, 3124, 5613 );
--	Trace ( "Drive" );
	StartThread (Einzatz)
end;
----------------------------------Einzatz
function Einzatz()
Wait ( 5 );
	while 1 do
		QCmd (ACT_MOVE, 99, 0, 2404, 6806 );
		Wait ( 5 );
		QCmd (ACT_MOVE, 99, 10, 8550, 5198 );
		Wait ( 5 );
		QCmd (ACT_MOVE, 99, 10, 3124, 5613 );
		Wait ( 5 );
		QCmd (ACT_MOVE, 99, 10, 2800, 10130 );
		Wait ( 15 );
	end;
	
end;	

----------------------------------Tank Test
function Tank_Test()
Wait ( 25 );
	while 1 do
		QCmd (ACT_MOVE, 900, 0, 3212, 5064 );
		Wait ( 5 );
		QCmd (ACT_MOVE, 900, 0, 4009, 5292 );
		Wait ( 5 );
		QCmd (ACT_MOVE, 900, 0, 3610, 4688 );
		Wait ( 5 );
		Cmd ( ACT_ROTATE, 900, 0, 3769, 4857);
		Wait ( 12 );
	end;
	
end;	
----------------------------------Land Movement1	
function Drive1()	
	while 1 do
			Wait (35);
			LandReinforcementFromMap ( 0,1,1,1001);
				Wait ( 5 );
			QCmd (ACT_MOVE, 1001, 0, 2862, 7193 );
				Wait ( 5 );
			QCmd (ACT_MOVE, 1001, 0, 5885, 6182);
				Wait ( 5 );
			QCmd (ACT_MOVE, 1001, 0, 5436, 4855 );
				Wait ( 60 );
			QCmd (ACT_MOVE, 1001, 0, 8467, 5187 );
				Wait ( 60 );			
			RemoveScriptGroup( 1001 );
--			Trace ( "Drive1" );
		Wait ( 30 );
	end;
end;
---------------------------------Infantry
function Infantry()
	Wait(65);
	Cmd ( ACT_LEAVE, 200, 0, 5431, 4200 );
	Wait (10);
	Cmd ( ACT_LEAVE, 201, 0, 5543, 4504);
	Wait (10);
	Cmd ( ACT_LEAVE, 202, 0, 5643, 4835 );
	Wait( 12 );
	Cmd ( ACT_LEAVE, 203, 0, 5755, 5103 );
	Wait( 12 );
	Cmd ( ACT_ROTATE, 200, 0, 5233, 4276 );
	Wait (12);
	Cmd ( ACT_ROTATE, 201, 0, 5352, 4589 );
	Wait (12);
	Cmd ( ACT_ROTATE, 202, 0, 5471, 4900 );
	Wait (12);
	Cmd ( ACT_ROTATE, 203, 0, 5513, 5152 );
end;
---------------------------------Patrol
function Patrol()
	while 1 do
		Wait ( 5 );
			QCmd (ACT_MOVE, 100, 4, 2678, 6036 );
			Wait (3);
			QCmd (ACT_MOVE, 100, 4, 2073, 5145 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 1895, 4536 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 2419, 3703 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 2005, 3036 );
			Wait (60);
			QCmd (ACT_MOVE, 100, 4, 1833, 3140 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 3020, 3467 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 7002, 1852 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 7100, 1590 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 7827, 3040 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 8514, 2963 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 8500, 5090 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 3980, 6763 );
			Wait (5);
			QCmd (ACT_MOVE, 100, 4, 2953, 6990 );
			Wait (5);
--			Trace ("Patrol_Complete");
		Wait ( 5 );
	end;
end;
---------------------------------Patrol2
function Patrol2()
	while 1 do
		Wait ( 36 );
			QCmd (ACT_MOVE, 300, 4, 3689, 4646 );
			Wait (3);
			QCmd (ACT_MOVE, 300, 4, 3088, 5317 );
			Wait (5);
			QCmd (ACT_MOVE, 300, 4, 5532, 5564 );
			Wait (5);
			QCmd (ACT_MOVE, 300, 4, 7566, 4768 );
			Wait (5);
			QCmd (ACT_MOVE, 300, 4, 7282, 3405 );
			Wait (15);
--			Trace ("Patrol2_Complete");
		Wait ( 5 );
	end;
end;
---------------------------------Patrol3
function Patrol3()
	while 1 do
		Wait ( 15 );
			QCmd (ACT_MOVE, 250, 0, 8308, 2750 );
			Wait (3);
--			Trace ( "Patrol3" );
			QCmd (ACT_MOVE, 250, 0, 8907, 2568 );
			Wait (5);
			QCmd (ACT_MOVE, 250, 0, 8965, 3186 );
			Wait (5);
			QCmd (ACT_MOVE, 250, 0, 8802, 4313 );
			Wait (5);
			QCmd (ACT_MOVE, 250, 0, 8337, 3850 );
			Wait (5);
			QCmd (ACT_MOVE, 250, 0, 8422, 2997 );
			Wait (5);
			QCmd (ACT_MOVE, 250, 5, 3120, 5610 );
			Wait (5);
			QCmd (ACT_MOVE, 250, 0, 7876, 2792 );
			Wait (5);
--			Trace ("Patrol3_Complete");
		Wait ( 15 );
	end;
end;
---------------------------------Patrol4
function Patrol4()
	while 1 do
		Wait ( 36 );
			QCmd (ACT_MOVE, 260, 4, 3086, 4246 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 3715, 3871 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 4490, 3704 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 4873, 3200 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 5330, 3012 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 5683, 2564 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 6692, 2841 );
			Wait (5);
			QCmd (ACT_MOVE, 260, 4, 2770, 4734 );
			Wait (5);
--			Trace ("Patrol4_Complete");
		Wait ( 5 );
	end;
end;
---------------------------------Camera
function Camera()
	while 1 do
		Wait( 1 );
		SCRunTime ( "Base1", "Base2", 5 );
		Wait( 5 );
		SCRunTime ( "Base2", "Base3", 5 );
		Wait( 5 );
		SCRunTime ( "Base3", "Base4", 5 );
		Wait( 5 );
		SCRunTime ( "Base4", "Base5", 5 );
		Wait( 5 );
		SCRunTime ( "Base5", "Base6", 5 );
		Wait( 5 );
		SCRunTime ( "Base6", "Base7", 8 );
		Wait( 8 );
		SCRunTime ( "Base7", "Base8", 5 );
		Wait( 5 );
		SCRunTime ( "Base8", "Base9", 7 );
		Wait( 8 );
		SCRunTime ( "Base9", "Base10", 5 );
		Wait( 8 );
		SCRunTime ( "Base10", "Base11", 5 );
		Wait( 8 );
		SCRunTime ( "Base11", "Base12", 5 );
		Wait( 5 );
		SCRunTime ( "Base12", "Base14", 7 );
		Wait( 8 );
		SCRunTime ( "Base14", "Base15", 5 );
		Wait( 5 );
		SCRunTime ( "Base15", "Base1", 5 );
		Wait( 5 );
	end;
end;
---------------------------------Infantry2
function Infantry2()
Wait( 100 );
Cmd (ACT_MOVE, 500, 0, 6064, 5081);
Cmd (ACT_MOVE, 500, 0, 5103, 5646);
Wait ( 10 );
Cmd (ACT_LOAD, 500, 510);
Wait ( 12 );
StartThread (Raid);
end;
---------------------------------Raid
function Raid()
		Cmd ( ACT_MOVE, 510, 0, 5675, 6285 );
			Wait ( 1 );
		Cmd ( ACT_MOVE, 510, 0, 2590, 7622 );
			Wait (60);
		Cmd ( ACT_LEAVE, 500, 0, 6064,5081 );
			Wait ( 1 );
		Cmd ( ACT_MOVE, 510, 0, 5885, 6182 );
			Wait ( 60 );
		Cmd ( ACT_MOVE, 510, 0, 6060,5080 );
			Wait ( 5 );
		Cmd ( ACT_MOVE, 500, 0, 150, 7622 );
			Wait ( 5 );
	RemoveScriptGroup( 500 );
end;
---------------------------------Infantryraid
function Raid2()
	while 1 do
		if GetNScriptUnitsInArea( 510, "Trans", 0 )>=1 then 
			Cmd (ACT_LOAD, 501, 510);
			Wait (15);
			Cmd (ACT_MOVE, 510, 0, 5885, 6182);
			return 1
		end;
		Wait(3);
--		Trace ("Raid2");
	end;
end;
-----------------------------------------------PreBombing
function PreBombing()
	while 1 do
		if ( GetGameTime() >= 25 ) then
			Wait (3)
			LandReinforcementFromMap (1, 1, 0, 610 );
			Wait (2);
			QCmd (ACT_SWARM, 610, 0, 6908, 2645 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike
function Bomb_Strike()
	while 1 do
		if ( GetGameTime() >= 30 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 620 );
			Wait (2);
			QCmd (ACT_MOVE, 620, 0, 5553, 4726 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike2
function Bomb_Strike2()
	while 1 do
		if ( GetGameTime() >= 35 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 621 );
			Wait (2);
			QCmd (ACT_MOVE, 621, 0, 5753, 4326 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike3
function Bomb_Strike3()
	while 1 do
		if ( GetGameTime() >= 40 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 622 );
			Wait (2);
			QCmd (ACT_MOVE, 622, 0, 2681, 5010 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike4
function Bomb_Strike4()
	while 1 do
		if ( GetGameTime() >= 45 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 623 );
			Wait (2);
			QCmd (ACT_MOVE, 623, 0, 4209, 5265 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike5
function Bomb_Strike5()
	while 1 do
		if ( GetGameTime() >= 50 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 624 );
			Wait (2);
			QCmd (ACT_MOVE, 624, 0, 5149, 4721 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike6
function Bomb_Strike6()
	while 1 do
		if ( GetGameTime() >= 55 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 625 );
			Wait (2);
			QCmd (ACT_MOVE, 625, 0, 5270, 5139 );
			return 1;
		end;
		Wait (2);
	end;
end;
-----------------------------------------------Bomb_Strike7
function Bomb_Strike7()
	while 1 do
		if ( GetGameTime() >= 60 ) then
			Wait (3)
			LandReinforcementFromMap (1, 0, 0, 626 );
			Wait (2);
			QCmd (ACT_MOVE, 626, 0, 5482, 5840 );
			return 1;
		end;
		Wait (2);
	end;
end;
---------------------------------Main
StartThread(Flight);
StartThread(Drive);
StartThread(Drive1);
StartThread(Camera);
--StartThread(Patrol);
StartThread(Patrol2);
StartThread(Patrol3);
StartThread(Patrol4);
StartThread(Infantry);
StartThread(Infantry2);
StartThread(Tank_Test);
StartThread(Raid2);
StartThread(Bomb_Strike);
StartThread(Bomb_Strike2);
StartThread(Bomb_Strike3);
StartThread(Bomb_Strike4);
StartThread(Bomb_Strike5);
StartThread(Bomb_Strike6);
StartThread(Bomb_Strike7);