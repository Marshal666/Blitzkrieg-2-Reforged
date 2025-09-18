
----------------------//MPObjective//---------------------------
function RevealObjective0()
	DisplayTrace("Ready !")
	Wait(10)
	DisplayTrace("Fight !!!");
    Wait(3);
	ObjectiveChanged(0, 1);
	ObjectiveChanged(1, 1);
end;




--------------------------//TriggerParameters//--------------------------

function Condition() 
		if ((GetNUnitsInParty(1) >= 1) and (tmpold == { 1, 1 }) and (tmpold1 == { 1, 1 })) then
			return 1;
		end;
end;

function Condition1()
        if ((GetNUnitsInParty(0, 0) <= 0) and (GetNUnitsInParty(1) > 1) and (GetReinforcementCallsLeft(0) < 1)) then
            Wait ( 5 )            
			Loose(0);
		end;
end;

------------------------

function Condition2()
		if ((GetNUnitsInParty(1) <= 0) and (tmpold == { 0, 0 }) and (tmpold1 == { 0, 0 })) then
			return 1;
		end;
end;

function Condition3()
        if ((GetNUnitsInParty(0) > 1) and (GetNUnitsInParty(1, 0) <= 0) and (GetReinforcementCallsLeft(1) < 1)) then
            Wait ( 5 )
			Win(0);
		end;
end;

-------------------//Key Building//--------------

function KeyBuilding_Flag()
local tmpold = { 0, 0 };
local tmp;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 1 do
		if ( GetNUnitsInScriptGroup( i + 500, 0 ) == 1 ) then
			tmp = 0;
		elseif ( ( GetNUnitsInScriptGroup( i + 500, 1 ) + GetNUnitsInScriptGroup( i + 500, 2 ) ) == 1 ) then
			tmp = 1;
		end;
		if ( tmp ~= tmpold[i] ) then
			if ( tmp == 0 ) then
				DamageScriptObject( 700 + i, 50 );
			else
				DamageScriptObject( 700 + i, -50 );
			end;
			tmpold[i] = tmp;
		end;
	end;
	end;
end;

-------------------------

function KeyBuilding_Flag1()
local tmpold1 = { 0, 0 };
local tmp1;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, 1 do
		if ( GetNUnitsInScriptGroup( i + 501, 0 ) == 1 ) then
			tmp1 = 0;
		elseif ( ( GetNUnitsInScriptGroup( i + 501, 1 ) + GetNUnitsInScriptGroup( i + 501, 2 ) ) == 1 ) then
			tmp1 = 1;
		end;
		if ( tmp1 ~= tmpold1[i] ) then
			if ( tmp1 == 0 ) then
				DamageScriptObject( 701 + i, 50 );
			else
				DamageScriptObject( 701 + i, -50 );
			end;
			tmpold1[i] = tmp1;
		end;
	end;
	end;
end;

---------------------//ST//---------------------------

StartThread( RevealObjective0 );
Trigger(Condition, Condition1, 1 )
Trigger(Condition2, Condition3, 1 )
StartThread ( KeyBuilding_Flag )
StartThread ( KeyBuilding_Flag1 )
