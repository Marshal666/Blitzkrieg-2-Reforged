--objective1 = 0;
-------------------------------------------Условия поражения 
function Caput()
    while 1 do
        if ( GetNUnitsInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 ) then
		Wait(2);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;
---------------------------------------Тревога
function Warning () 
while 1 do
		Wait( 3 );
		if ( GetNUnitsInArea ( 0, "Start" ) > 0 )then
			Wait( 2 );
			Cmd( 3, 400, 100, 2092, 1220 );
			break;
		end;	
	end;
end;
--------------------------------------- Уничтожение артиллерии
function Artillery ()
	while 1 do
		Wait( 2 );
		if ( GetNUnitsInScriptGroup( 1500, 1 ) < 1 ) then
			Wait( 2 );
			CompleteObjective( 0 );
			--objective1 = 1;
			Wait( 2 );
			GiveObjective ( 1 );
			break;	
		end;
	end;
end;

function Check()
	Trace("Units in script group = %g",GetNUnitsInCircle( 2, 3868, 539, 500 )); 
end;
-----------------------------------------Захват командного центра и победа.  
function Command_Center()
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInArea ( 1, "JHQ" ) < 1 ) then --and ( objective1 == 1) then 
				Wait( 5 );
				CompleteObjective( 1 );
				Wait( 3 );
				Win (0);
			break;
		end;
	end;
end;
-----------------------------------------Морской транспорт
function Ship ()
    Wait ( 1 );
    Cmd  ( 0, 500, 300, 3868, 539 );
    Wait ( 3 )
    QCmd  ( 0, 500, 300, 7316, 450 );
    QCmd  ( ACT_DISAPPEAR, 500 );
    while 1 do
    Wait ( 2 );
	    if GetNUnitsInCircle( 2, 3868, 539, 500 ) > 0 then
			LandReinforcementFromMap( 2, "Squad", 0, 600 );
			Wait(1);
			LandReinforcementFromMap (2, "Tanks", 0, 600);
			Wait(1);
            ChangePlayerForScriptGroup ( 600, 0 );
			return 1;
		end;
    end;
end;
----------------------------------------Тревога 2
function Warning2 ()
while 1 do
		Wait( 1 );
		if ( GetNUnitsInArea ( 0, "ALZ" ) > 0 )then
			Wait( 3 );
			--Cmd (0 , 1100, 100, 3321, 6476 );
            --QCmd (3, 1100, 100, 4260, 6124);
			Cmd ( 3, 1100, 200, 4631, 4527 );
			break;
		end;	
	end;
end;

-----------------------------------------Запускаем функции
GiveObjective( 0 );
StartThread( Caput );
StartThread( Warning )
StartThread( Artillery );
StartThread( Command_Center );
StartThread( Ship );
StartThread( Warning2 );



