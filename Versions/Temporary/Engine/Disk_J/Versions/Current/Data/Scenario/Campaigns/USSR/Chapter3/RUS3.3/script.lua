-- Diversants
-- design by DJekman
-- Live ----------------------------------------------------
auto = {};
auto [1] = "Auto1"; auto [2] = "Auto2"; auto [3] = "Auto3"; auto [4] = "Auto4";

function RndDiversant()
ii = 9+Random(2);
	for i = 1, ii do
		del = Random(16);
		RemoveScriptGroup(del);
--		Trace ( 'del= %g', del );
		LandReinforcementFromMap ( 3, "Diversant", del, 99 );			
	end;
Wait(1);
Cmd(ACT_ENTER,16,26);
Wait(Random(20));
Cmd(ACT_ENTER,13,23);
--Cmd(ACT_ENTER,14,24);
Wait(10+Random(30))
Cmd(ACT_ENTER,11,21);
end;
function Diversant()
	while 1 do
		Wait(1);
		for d = 1, 16 do
			if GetNScriptUnitsInArea(200, "Zona" .. d, 0) > 0 then
			Wait(1);
			ChangePlayerForScriptGroup(d,1);
			end;
		end;
	end;
end;
function Kolonna()
		Wait(2)
		c = Random(3);
		Wait(1);
		if c == 1 then
			StartThread( Kolonna1);
			Wait(1);
			StartThread( Kolonna0);
			return 1
		end;
		if c == 2 then
			StartThread( Kolonna2);
			Wait(1);
			StartThread( Kolonna0);
			return 1
		end;
		if c == 3 then
			StartThread( Kolonna3);
			Wait(1);
			StartThread( Kolonna0);
			return 1
		end;
end;
function Kolonna0()
	while 1 do
		Wait(5);
		if ( GetNUnitsInScriptGroup( 101, 3 ) < 1 ) then 
		Wait(60); -- time kolonna next go
		StartThread( Kolonna);
		return 1		
		end;
	end;
end;
function Kolonna1()
kol = Random(4);
	for a = 1 , kol do
		b = Random(4);
		Wait(3);
		LandReinforcementFromMap ( 3, auto[b], 0, 100+a );
		Wait(1);
		Cmd ( 0, 100+a , 0 , GetScriptAreaParams ( "C1" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "C2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "C3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "C4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "C5" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "C6" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D8" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D7" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D6" ) );	
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D5" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D1" ) );		
		QCmd ( 1007 , 100+a );
	end;

end;
function Kolonna2()
kol = Random(4);
	for a = 1 , kol do
		b = Random(4);
		Wait(3);
		LandReinforcementFromMap ( 3, auto[b], 20, 100+a );
		Wait(1);
		Cmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A1" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A5" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A6" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "E4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "E3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "E2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "E1" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D8" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D7" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D6" ) );	
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D5" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "D1" ) );	
		QCmd ( 1007 , 100+a );
	end;

end;
function Kolonna3()
kol = Random(4);
	for a = 1 , kol do
		b = Random(4);
		Wait(3);
		LandReinforcementFromMap ( 3, auto[b], 20, 100+a );
		Wait(1);
		Cmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A1" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A5" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "A6" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "B6" ) );	
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "B5" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "B4" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "B3" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "B2" ) );
		QCmd ( 0, 100+a , 0 , GetScriptAreaParams ( "B1" ) );		
		QCmd ( 1007 , 100+a );
	end;

end;
function Patrol ()
	while 1 do
		Wait( 2 );
		if ( GetNScriptUnitsInArea(111, "G2", 0) > 0 ) then
		Wait(20+Random(30));
		Cmd(0, 111, 0, GetScriptAreaParams("G1"));
		QCmd(0, 111, 0, GetScriptAreaParams("A6"));
		QCmd(0, 111, 0, GetScriptAreaParams("G8"));
		QCmd(0, 111, 0, GetScriptAreaParams("G3"));		
		QCmd(0, 111, 0, GetScriptAreaParams("G7"));
		QCmd(0, 111, 0, GetScriptAreaParams("G4"));
		QCmd(0, 111, 0, GetScriptAreaParams("G5"));
		QCmd(0, 111, 0, GetScriptAreaParams("G6"));
		QCmd(ACT_ROTATE, 111, 0, GetScriptAreaParams("G5"));
		StartThread( Patrol1);		
		return 1
		end;
	end;

end;
function Patrol1()
	while 1 do	
		Wait(2);
		if ( GetNScriptUnitsInArea(111, "G6", 0) > 0 ) then
		Wait(20+Random(30));
		Cmd(0, 111, 0, GetScriptAreaParams("G5"));
		QCmd(0, 111, 0, GetScriptAreaParams("G4"));
		QCmd(0, 111, 0, GetScriptAreaParams("G7"));
		QCmd(0, 111, 0, GetScriptAreaParams("G3"));		
		QCmd(0, 111, 0, GetScriptAreaParams("G8"));
		QCmd(0, 111, 0, GetScriptAreaParams("A6"));
		QCmd(0, 111, 0, GetScriptAreaParams("G1"));
		QCmd(0, 111, 0, GetScriptAreaParams("G2"));
		QCmd(ACT_ROTATE, 111, 0, GetScriptAreaParams("G1"));
		StartThread( Patrol);		
		return 1
		end;
	end;
end;	
function Gofficer()
	while 1 do	
		Wait(1);
		Cmd(0, 200, 50,GetScriptObjCoord(201));
	end;
end;
function Loose()
	while 1 do	
		Wait(2);
		if GetNUnitsInParty(0) < 1 or GetNUnitsInScriptGroup( 200 ) < 1 then
			Win(1);
			return 1
		end;
	end;
end;
function Winner()
	while 1 do	
		Wait(3);
		div = 0;
		for w = 1, 16 do
			div = GetNUnitsInScriptGroup( w ) + div;
		end;
		if div < 1 then
			Win(0);
			return 1
		end;
	end;
end;
----------------------------------------------

StartThread (RndDiversant);
StartThread (Gofficer);
Wait( 1 );
GiveObjective( 0 );
----------------------------------------------
StartThread (Diversant);
Wait(5);
StartThread( Patrol);
StartThread( Kolonna);
StartThread( Winner);
StartThread( Loose);