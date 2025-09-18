

function Player() 
	while 1 do
		Wait( 2 );
        if ((GetNUnitsInArea(0, "WH",0) < 1) and (GetNUnitsInArea(1, "WH",0) < 1) and (GetNUnitsInArea(2) > 0)) then
			Wait( 1 );
			Win(1);
			break;
		end;
	end;
end;

----------------------------------------------------------Attacks

function Attack_1()
	Wait( 3 );
	ObjectiveChanged(0, 1);
	Wait( 20 );
	LandReinforcement( 2, 884, 0, 1000 );
	Wait( 3 );
	Cmd( ACT_SWARM, 1000, 100, 6221, 5637 );
end;

function Attack_2()
	Wait( 5 );
	LandReinforcement( 2, 883, 2, 2000 ); 
	Wait( 3 );
	ChangeFormation( 2000, 3 );
	Wait( 1 );
	Cmd( ACT_SWARM, 2000, 200, 6221, 5637 );
end;
-----------------------
function Attack_3()
	Wait( 135 );
	LandReinforcement( 2, 884, 1, 1100 ); 
	Wait( 3 );
	Cmd( ACT_SWARM, 1100, 200, 6221, 5637 );
end;

function Attack_4()
	Wait( 105 );
	LandReinforcement( 2, 883, 0, 2100 ); 
	Wait( 3 );
	ChangeFormation( 2100, 3 );
	Wait( 1 );
	Cmd( ACT_SWARM, 2100, 200, 6221, 5637 );
end;
-----------------------

function Attack_5()
	Wait( 235 );
	LandReinforcement( 2, 884, 0, 1200 ); 
	Wait( 3 );
	Cmd( ACT_SWARM, 1200, 200, 6221, 5637 );
end;

function Attack_6()
	Wait( 155 );
	LandReinforcement( 2, 883, 2, 2200 ); 
	Wait( 3 );
	ChangeFormation( 2200, 3 );
	Wait( 1 );
	Cmd( ACT_SWARM, 2200, 200, 6221, 5637 );
	QCmd( ACT_SWARM, 2200, 200, 6094, 5433 );
end;
---------------------------------------------Italo
function Attack_7()
	Wait( 245 );
	LandReinforcement( 2, 886, 1, 1700 ); 
	Wait( 2 );
	DisplayTrace("Last attack!");
	Cmd( ACT_SWARM, 1700, 100, 6221, 5637 );
	Wait( 5 );
	StartThread( Winner );
end;

--------------------------------------------------------Air

function Air_Attack()
	Wait( 120 + RandomInt( 100 ) );
	LandReinforcement( 2, 885, 1, 3000 ); 
	Wait( 2 );
	Cmd( 5, 3000, 0, 5488, 5099 );	
end;

-------------------------------------------------------Winn

function Winner()
    while 1 do
        if ( GetNUnitsInScriptGroup( 1700 ) < 1 ) then
			ObjectiveChanged(0, 2);
            Win(0);
            SetIGlobalVar( "temp.Won", 2 );
			return 1;
		end;
	Wait(5);
    end;
end;

---------------------MAIN
StartThread( Air_Attack );

StartThread( Player );

StartThread( Attack_1 );
StartThread( Attack_2 );
StartThread( Attack_3 );
StartThread( Attack_4 );
StartThread( Attack_5 );
StartThread( Attack_6 );
StartThread( Attack_7 );






