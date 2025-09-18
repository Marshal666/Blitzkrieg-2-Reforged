----------------------------------------------------us2.1 941
k=0;
----------------------------------------------------EntrenchAAC
function aaircraft()
	while 1 do
		if ( GetNUnitsInParty (0)==1 ) then
		Wait ( 120 );
		Cmd (ACT_ENTRENCH, 77, 0, 0);
		return 1;
		end;
	Wait ( 2 );
	end;
end
-----------------------------------------------------Find_Auto

function FindAuto()
	while 1 do
		if (GetNUnitsInArea ( 0, "auto", 1) == 1 ) then
		k = k + 1;
		Wait (2);
		return 1
		end;
	Wait (2);
	end;
end;
-----------------------------------------------------Find_Auto1
function FindAuto2()
	while 1 do	
		if (GetNUnitsInArea ( 0, "auto1", 1) == 1 ) then
		k = k + 1;
		Wait (2);
		return 1
		end;
	Wait(2)
	end;	
end;
-------------------------------------------------------CheckJObjective0
function CheckJObjective0()
	while 1 do	
		if ( k==2 ) then
		CompleteObjective (0);
		Wait (2);
		GiveObjective (1);
		return 1
		end;
	Wait(2)
	end;	
end;
-------------------------------------------------------JS
function JS()
	while 1 do	
		if ( k==2 ) then
		Cmd ( ACT_MOVE, 100, 20, 507, 7690 );
		Wait (2);
		return 1
		end;
	Wait(2)
	end;	
end;
-------------------------------------------------------
function counting_planes()
	Wait(1)
	recon()
	while 1 do
		if find_tanks() then gap() end
		Wait(1);
		return 1;
	end
end
-------------------------------------------------------WinC
function WinCheck()
		while 1 do
			if ( GetNUnitsInScriptGroup ( 100 ) == 0 ) then 
				CompleteObjective( 0 );
				Win(0);
			return 1;
		end;
	Wait(5);
	end;
end;
----------------------------------------------------------LooseC
function LooseCheck()
    while 1 do
		Wait (25);
        if (IsReinforcementAvailable ( 0 ) == 0 ) and (IsSomeUnitInParty ( 0 ) == 0 ) then
            Wait ( 5 );
			Win ( 1 );
		return 1;
		end;
	Wait(5);
	end;
end;


------------------------------------------------------------main
GiveObjective( 0 );

StartThread( LooseCheck );
StartThread( WinCheck );
StartThread( aaircraft );
StartThread( find_auto);
StartThread( find_auto1);
StartThread( JS);
--StartThread( counting_planes );