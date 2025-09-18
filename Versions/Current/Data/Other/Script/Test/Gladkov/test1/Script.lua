
-------------------------------------------Выдаём обжектив

function RevealObjective()
	GiveObjective( 0 );
end;
--------------------------------------------Условие поражения
function Caput()
    while 1 do
        if ( GetNUnitsInParty(0) < 1) then
		Wait(2);
		Win(1);
		return 1;
		end;
	Wait(5);
	end;
end;
-----------------------------------------------Условие на присутствие игрока в зоне
function Village()
	while 1 do
		Wait( 10 );
		if ( GetNUnitsInArea ( 0, "zone1" ) > 0 )then
			Wait( 2 );
			Cmd( 0, 200, 0, 5351, 5233 );
			QCmd( 3, 200, 0, 5172, 1517 );
			break;
		end;	
	end;
end;
---------------------------------------------------------Условие победы и комплит обжектива
function Winn() 
	while 1 do
		Wait( 2 );
			if ( GetNUnitsInScriptGroup( 200 ) < 1 ) then
				Wait( 2 );
				CompleteObjective( 0 );
				Wait( 2 );
				Win (0);
			break;
		end;
	end;
end;





--------------------------------------------------Запускаем функции
StartThread( RevealObjective );
StartThread( Caput );
StartThread( Village );
StartThread( Winn );