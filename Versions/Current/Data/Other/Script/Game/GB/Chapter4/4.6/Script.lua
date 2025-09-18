
SetIGlobalVar("temp.nogeneral_sript",1)

---------------------------------------

function RevealObjective()
	Wait(2);
	GiveObjective( 0 );
end;
-----------------------------------------
function S1()
	Wait( 25 );
	LandReinforcementFromMap( 1, 0, 0, 501 );
	Wait( 1 ); 
	StartThread( Sw1 );
end;

function S2()
	Wait( 30 );
	LandReinforcementFromMap( 1, 0, 0, 502 );
	Wait( 1 ); 
	StartThread( Sw2 );
end;

function S3()
	Wait( 35 );
	LandReinforcementFromMap( 1, 0, 0, 503 );
	Wait( 1 ); 
	StartThread( Sw3 );
end;
-----------------------------------------
function G1()
	Wait( 55 );
	LandReinforcementFromMap( 1, 1, 0, 601 );
	Wait( 1 ); 
	StartThread( Gw1 );
end;

function G2()
	Wait( 60 );
	LandReinforcementFromMap( 1, 0, 0, 602 );
	Wait( 1 ); 
	StartThread( Gw2 );
end;

function G3()
	Wait( 65 );
	LandReinforcementFromMap( 1, 0, 0, 603 );
	Wait( 1 ); 
	StartThread( Gw3 );
end;
----------------------------------------
function D1()
	Wait( 85 );
	LandReinforcementFromMap( 1, 1, 0, 701 );
	Wait( 1 ); 
	StartThread( Dw1 );
end;

function D2()
	Wait( 90 );
	LandReinforcementFromMap( 1, 1, 0, 702 );
	Wait( 1 ); 
	StartThread( Dw2 );
end;

function D3()
	Wait( 95 );
	LandReinforcementFromMap( 1, 0, 0, 703 );
	Wait( 1 ); 
	StartThread( Dw3 );
end;
-----------------------------------------
function T1()
	Wait( 120 );
	LandReinforcementFromMap( 1, 2, 0, 801 );
	Wait( 1 ); 
	StartThread( Tw1 );
end;

function T2()
	Wait( 125 );
	LandReinforcementFromMap( 1, 2, 0, 802 );
	Wait( 2 ); 
	StartThread( Tw2 );
end;
------------------------------------------------------
------------------------------------------------------
function Sw1()
	Wait( 2 );
	Cmd( 3, 501, 0, 1734, 5119 );
	QCmd( 3, 501, 0, 2509, 4292 ); 
	QCmd( 3, 501, 0, 2582, 2739 );
	QCmd( 3, 501, 0, 3297, 1565 );
	QCmd( 3, 501, 0, 4514, 867 );
	QCmd( 3, 501, 0, 5902, 708 );
end;

function Sw2()
	Wait( 2 );
	Cmd( 3, 502, 0, 1734, 5119 );
	QCmd( 3, 502, 0, 2509, 4292 ); 
	QCmd( 3, 502, 0, 2582, 2739 );
	QCmd( 3, 502, 0, 3297, 1565 );
	QCmd( 3, 502, 0, 4514, 867 );
	QCmd( 3, 502, 0, 5902, 708 );
end;

function Sw3()
	Wait( 2 );
	Cmd( 0, 503, 0, 1734, 5119 );
	QCmd( 0, 503, 0, 2509, 4292 ); 
	QCmd( 0, 503, 0, 2582, 2739 );
	QCmd( 0, 503, 0, 3297, 1565 );
	QCmd( 0, 503, 0, 4514, 867 );
	QCmd( 0, 503, 0, 5902, 708 );
end;
--------------------------------------------

function Gw1()
	Wait( 2 );
	Cmd( 3, 601, 0, 1734, 5119 );
	QCmd( 3, 601, 0, 2509, 4292 ); 
	QCmd( 3, 601, 0, 2582, 2739 );
	QCmd( 3, 601, 0, 3297, 1565 );
	QCmd( 3, 601, 0, 4514, 867 );
	QCmd( 3, 601, 0, 5902, 708 );
end;

function Gw2()
	Wait( 2 );
	Cmd( 3, 602, 0, 1734, 5119 );
	QCmd( 3, 602, 0, 2509, 4292 ); 
	QCmd( 3, 602, 0, 2582, 2739 );
	QCmd( 3, 602, 0, 3297, 1565 );
	QCmd( 3, 602, 0, 4514, 867 );
	QCmd( 3, 602, 0, 5902, 708 );
end;

function Gw3()
	Wait( 2 );
	Cmd( 0, 603, 0, 1734, 5119 );
	QCmd( 0, 603, 0, 2509, 4292 ); 
	QCmd( 0, 603, 0, 2582, 2739 );
	QCmd( 0, 603, 0, 3297, 1565 );
	QCmd( 0, 603, 0, 4514, 867 );
	QCmd( 0, 603, 0, 5902, 708 );
end;
----------------------------------
function Dw1()
	Wait( 2 );
	Cmd( 0, 701, 0, 1734, 5119 );
	QCmd( 0, 701, 0, 2509, 4292 ); 
	QCmd( 0, 701, 0, 2582, 2739 );
	QCmd( 0, 701, 0, 3297, 1565 );
	QCmd( 0, 701, 0, 4514, 867 );
	QCmd( 0, 701, 0, 5902, 708 );
end;

function Dw2()
	Wait( 2 );
	Cmd( 0, 702, 0, 1734, 5119 );
	QCmd( 0, 702, 0, 2509, 4292 ); 
	QCmd( 0, 702, 0, 2582, 2739 );
	QCmd( 3, 702, 0, 3297, 1565 );
	QCmd( 3, 702, 0, 4514, 867 );
	QCmd( 3, 702, 0, 5902, 708 );
end;

function Dw3()
	Wait( 2 );
	Cmd( 0, 703, 0, 1734, 5119 );
	QCmd( 0, 703, 0, 2509, 4292 ); 
	QCmd( 0, 703, 0, 2582, 2739 );
	QCmd( 0, 703, 0, 3297, 1565 );
	QCmd( 0, 703, 0, 4514, 867 );
	QCmd( 0, 703, 0, 5902, 708 );
end;
-----------------------------------
function Tw1()
	Wait( 2 );
	Cmd( 0, 801, 0, 1734, 5119 );
	QCmd( 0, 801, 0, 2509, 4292 ); 
	QCmd( 0, 801, 0, 4278, 3578 );
	QCmd( 0, 801, 0, 5571, 2560 );
	QCmd( 0, 801, 0, 5902, 708 );
end;

function Tw2()
	Wait( 2 );
	Cmd( 0, 802, 0, 1734, 5119 );
	QCmd( 0, 802, 0, 2509, 4292 ); 
	QCmd( 3, 802, 0, 4278, 3578 );
	QCmd( 3, 802, 0, 5571, 2560 );
	QCmd( 3, 802, 0, 5902, 708 );
end;
------------------------------------
function Lose1() 
	while 1 do
		Wait( 2 );
			if (GetNUnitsInArea(1, "Exit", 0) > 0) then
			Wait( 1 );
			Win(1);
			break;
		end;
	end;
end;

function Lose2()
    while 1 do
        if (( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(3);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;

function Lose3() 
	while 1 do
		Wait( 2 );
			if ((GetNUnitsInArea(1, "Villadge", 0) < 1) and (GetIGlobalVar("temp.Vill", 1) ~= 2)) then
			Wait( 1 );
			Win(1);
			break;
		end;
	end;
end;

-------------------------------------
function Winner() 
	while 1 do
		Wait( 2 );
			if (( GetNUnitsInScriptGroup( 801 ) <1 ) and  ( GetNUnitsInScriptGroup( 802 ) < 1 ))  then
				Wait( 1 );
				CompleteObjective( 0 );
				SetIGlobalVar( "temp.Vill", 2 );
				Win( 0 );
			break;
		end;
	end;
end;

function Winn ()
	while 1 do
		Wait(2);
		if ( GetNScriptUnitsInArea ( 801, "Villadge" ) > 0 ) then
			Wait(2);
			StartThread( Winner );
			break
		end;		
	end;
end;

-------------------------------Main
StartThread( RevealObjective );
StartThread( S1 );
StartThread( S2 );
StartThread( S3 );
StartThread( G1 );
StartThread( G2 );
StartThread( G3 );
StartThread( D1 );
StartThread( D2 );
StartThread( D3 );
StartThread( T1 );
StartThread( T2 );
------------------------------
StartThread( Lose1 );
StartThread( Lose2 );
StartThread( Lose3 );
StartThread( Winn );




