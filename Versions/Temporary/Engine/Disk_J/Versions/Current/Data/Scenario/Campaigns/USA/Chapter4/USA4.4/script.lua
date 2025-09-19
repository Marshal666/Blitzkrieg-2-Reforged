a = 0;
obj0 = 0;
tochka = 6;
tip = 1;
marchrut = 1;
mar = {};
mar [1] = "go2041";
mar [2] = "go2030";
mar [3] = "go2031";
mar [4] = "go2000";
mar [5] = "go2050";
mar [6] = "Para3";
tips = {};
tips [1] = "1";
tips [2] = "2";
tips [3] = "3";
tips [4] = "4";

-----------------------Trevoga

function Trevoga()
	Wait ( 1 );
	for a = 0 , 5 do
		Wait ( 1 );
		LandReinforcementFromMap ( 1 , "0" , a , 300+a );
		Wait ( 1 );
		Cmd( 0 , 300+a , 500 , GetScriptAreaParams ( "town" ) );
		QCmd( 4 , 300+a , 200+a );
	end;
	StartThread( Go300 );
	StartThread( Go301 );
	StartThread( Go302 );
	StartThread( Go303 );
	StartThread( Go304 );
	StartThread( Go305 );
end;

-----------------------Go

function Go300()
	while 1 do
		Wait ( 1 );
		if IsAlive(GetObjectList ( 300 ))== 0 then
			Trace("Unit with ScriptID = %g is dead :(",300);
			break;
		end;
		US300 = GetUnitState ( GetObjectList ( 300 ) );
		if 	US300 == 3 then
			Wait ( 3 );
			Cmd( 0 , 200 , 0 , GetScriptAreaParams ( "go2000" ) );
			QCmd( 5 , 200 , 0 , GetScriptAreaParams ( "go2001" ) );
			while 1 do
				Wait ( 1 );
				US300 = GetUnitState ( GetObjectList ( 300 ) );
				if 	US300 == 1 then
					Wait ( 3 );
					Cmd( 0 , 200 , 0 , GetScriptAreaParams ( "go2000" ) );
					Cmd( 3 , 300 , 300 , GetScriptAreaParams ( "para10" ) );
					QCmd( 3 , 300 , 300 , GetScriptAreaParams ( "town" ) );
				break;
				end;
			end;
		end;
	end;
end;

function Go301()
	while 1 do
		Wait ( 1 );
		if IsAlive(GetObjectList ( 301 )) == 0 then
			Trace("Unit with ScriptID = %g is dead :(",301);
			break;
		end;
		US301 = GetUnitState ( GetObjectList ( 301 ) );
		if 	US301 == 3 then
			Wait ( 3 );
			Cmd( 0 , 201 , 0 , GetScriptAreaParams ( "go2010" ) );
			QCmd( 5 , 201 , 0 , GetScriptAreaParams ( "go2011" ) );
			while 1 do
				Wait ( 1 );
				US301 = GetUnitState ( GetObjectList ( 301 ) );
				if 	US301 == 1 then
					Wait ( 3 );
					Cmd( 0 , 201 , 0 , GetScriptAreaParams ( "go2010" ) );
					Cmd( 3 , 301 , 300 , GetScriptAreaParams ( "para10" ) );
					QCmd( 3 , 301 , 300 , GetScriptAreaParams ( "town" ) );
				break;
				end;
			end;
		end;
	end;
end;

function Go302()
	while 1 do
		Wait ( 1 );
		if IsAlive(GetObjectList ( 302 )) == 0 then
			Trace("Unit with ScriptID = %g is dead :(",302);
			break;
		end;
		US302 = GetUnitState ( GetObjectList ( 302 ) );
		if 	US302 == 3 then
			Wait ( 3 );
			Cmd( 0 , 202 , 0 , GetScriptAreaParams ( "go2010" ) );
			QCmd( 5 , 202 , 0 , GetScriptAreaParams ( "go2021" ) );
			while 1 do
				Wait ( 1 );
				US302 = GetUnitState ( GetObjectList ( 302 ) );
				if 	US302 == 1 then
					Wait ( 3 );
					Cmd( 0 , 202 , 0 , GetScriptAreaParams ( "go2010" ) );
					Cmd( 3 , 302 , 300 , GetScriptAreaParams ( "para20" ) );
					QCmd( 3 , 302 , 300 , GetScriptAreaParams ( "town" ) );
				break;
				end;
			end;
		end;
	end;
end;

function Go303()
	while 1 do
		Wait ( 1 );
		if IsAlive(GetObjectList ( 303 )) == 0 then
			Trace("Unit with ScriptID = %g is dead :(",303);
			break;
		end;
		US303 = GetUnitState ( GetObjectList ( 303 ) );
		if 	US303 == 3 then
			Wait ( 3 );
			Cmd( 0 , 203 , 0 , GetScriptAreaParams ( "go2030" ) );
			QCmd( 5 , 203 , 0 , GetScriptAreaParams ( "go2031" ) );
			while 1 do
				Wait ( 1 );
				US303 = GetUnitState ( GetObjectList ( 303 ) );
				if 	US303 == 1 then
					Wait ( 3 );
					Cmd( 0 , 203 , 0 , GetScriptAreaParams ( "go2030" ) );
					Cmd( 3 , 303 , 300 , GetScriptAreaParams ( "para20" ) );
					QCmd( 3 , 303 , 300 , GetScriptAreaParams ( "town" ) );
				break;
				end;
			end;
		end;
	end;
end;

function Go304()
	while 1 do
		Wait ( 1 );
		if IsAlive(GetObjectList ( 304 )) == 0 then
			Trace("Unit with ScriptID = %g is dead :(",304);
			break;
		end;
		US304 = GetUnitState ( GetObjectList ( 304 ) );
		if 	US304 == 3 then
			Wait ( 3 );
			Cmd( 0 , 204 , 0 , GetScriptAreaParams ( "go2030" ) );
			QCmd( 5 , 204 , 0 , GetScriptAreaParams ( "go2041" ) );
			while 1 do
				Wait ( 1 );
				US304 = GetUnitState ( GetObjectList ( 304 ) );
				if 	US304 == 1 then
					Wait ( 3 );
					Cmd( 0 , 204 , 0 , GetScriptAreaParams ( "go2030" ) );
					Cmd( 3 , 304 , 300 , GetScriptAreaParams ( "para30" ) );
					QCmd( 3 , 304 , 300 , GetScriptAreaParams ( "town" ) );
				break;
				end;
			end;
		end;
	end;
end;

function Go305()
	while 1 do
		Wait ( 1 );
		if IsAlive(GetObjectList ( 305 ))== 0 then
			Trace("Unit with ScriptID = %g is dead :(",305);
			break;
		end;
		US305 = GetUnitState ( GetObjectList ( 305 ) );
		if 	US305 == 3 then
			Wait ( 3 );
			Cmd( 0 , 205 , 0 , GetScriptAreaParams ( "go2050" ) );
			QCmd( 5 , 205 , 0 , GetScriptAreaParams ( "go2051" ) );
			while 1 do
				Wait ( 1 );
				US305 = GetUnitState ( GetObjectList ( 305 ) );
				if 	US305 == 1 then
					Wait ( 3 );
					Cmd( 0 , 205 , 0 , GetScriptAreaParams ( "go2050" ) );
					Cmd( 3 , 305 , 300 , GetScriptAreaParams ( "para30" ) );
					QCmd( 3 , 305 , 300 , GetScriptAreaParams ( "town" ) );
				break;
				end;
			end;
		end;
	end;
end;

-----------------------Reinf

function Reinf()
	LandReinforcementFromMap ( 2 , "0" , 0 , 101 );
	Wait ( 1 );
	Cmd( 5 , 101 , 0 , GetScriptAreaParams ( "Para2" ) );
	Wait ( 3 );
	LandReinforcementFromMap ( 2 , "0" , 0 , 102 );
	Wait ( 1 );
	Cmd( 5 , 102 , 0 , GetScriptAreaParams ( "Para1" ) );
	Wait ( 3 );
	LandReinforcementFromMap ( 2 , "0" , 0 , 103 );
	Wait ( 1 );
	Cmd( 5 , 103 , 0 , GetScriptAreaParams ( "Para3" ) );
	StartThread( Perehod1 );
	StartThread( Perehod2 );
	StartThread( Perehod3 );
	StartThread( Recon );
	StartThread( Trevoga );
end;

-----------------------Air

function Recon()
	while GetIGlobalVar( "temp.objective0" , 0 ) == 1 do
		Wait ( 1 );
		LandReinforcementFromMap ( 2 , "1" , 0 , 104 );
		Cmd( 0 , 104 , 0 , GetScriptAreaParams ( "town" ) );
--		StartThread( GA );
		Wait ( 400 );	
	end;
end;

function GA()
	Wait ( 50 );
	LandReinforcementFromMap ( 2 , "2" , 0 , 105 );
	Cmd( 3 , 105 , 0 , GetScriptAreaParams ( "town" ) );
end;

-----------------------Perehod

function Perehod1()
	while 1 do
		Wait( 3 );
		if  IsSomeUnitInArea ( 2 , "Para1" , 0 ) > 0 then
			ChangePlayerForScriptGroup( 102 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function Perehod2()
	while 1 do
		Wait( 3 );
		if  IsSomeUnitInArea ( 2 , "Para2" , 0 ) > 0 then
			ChangePlayerForScriptGroup( 101 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;

function Perehod3()
	while 1 do
		Wait( 3 );
		if  IsSomeUnitInArea ( 2 , "Para3" , 0 ) > 0 then
			ChangePlayerForScriptGroup( 103 , 0 );
			Wait( 1 );
			break;
		end;	
	end;
end;

-----------------------Ataka

function Ataka()
	Numatt = 1;
	StartThread( Ataka1 );
end;

function Ataka1()
	if Numatt < 10 then
		Wait( 3 );
		nomer = 200;
		tochka = RandomInt ( 2 ) + 6;
		tip = RandomInt ( 4 ) + 1;
		marchrut = RandomInt ( 3 ) + 1;
		if tochka == 6 then
			Wait ( 1 );
			LandReinforcementFromMap ( 1 , tips [tip] , tochka , nomer );
			Wait ( 3 );
			Cmd( 3 , nomer , 0 , GetScriptAreaParams ( mar [marchrut] ));
			QCmd( 3 , nomer , 0 , GetScriptAreaParams ( 'town' ));
			nomer = nomer + 1;
		else
			Wait ( 1 );
			LandReinforcementFromMap ( 1 , tips [tip] , tochka , nomer );
			Wait ( 3 );
			Cmd( 3 , nomer , 0 , GetScriptAreaParams ( mar [marchrut+3] ));
			QCmd( 3 , nomer , 0 , GetScriptAreaParams ( 'town' ));
			nomer = nomer + 1;
		end;
	else
		Wait ( 90 );
		StartThread( CompleteObjective1 );
	end;
	Wait ( 45 );
	Numatt = Numatt + 1;
	StartThread( Ataka1 );
end;

-----------------------Objective

function Objective()
	ObjectiveChanged(0, 1); 
	SetIGlobalVar( "temp.objective0" , 1 );
	StartThread( CompleteObjective0 );
	Wait( 3 );
end;

function CompleteObjective0()
	while 1 do
		Wait( 3 );
		if  IsSomeBodyAlive ( 1 , 100 ) < 1 then
			ObjectiveChanged(0, 2);
			LandReinforcementFromMap(0,"sluggers",0,8001);
			Cmd(ACT_SWARM,8001,0,GetScriptAreaParams("reinf"));
			obj0 = 1;
			SetIGlobalVar( "temp.objective0" , 2 );
			Wait( 3 );
			StartThread( Objective1 );
			StartThread( Looser1 );
			StartThread( Ataka );
			break;
		end;	
	end;
end;

function Objective1()
	ObjectiveChanged(1, 1); 
	SetIGlobalVar( "temp.objective1" , 1 );
	Wait( 3 );
end;

function CompleteObjective1()
	while 1 do
		Wait( 3 );
		ObjectiveChanged(1, 2);
		SetIGlobalVar( "temp.objective1" , 2 );
		Wait( 3 );
		Win ( 0 );
	end;
end;

function SecretObjective()
	while 1 do
		Wait( 3 );
		if  IsSomeUnitInArea ( 1 , 'Sklad', 0 ) < 1 and IsSomeUnitInArea ( 0 , 'Sklad', 0 ) > 0 then
			ChangePlayerForScriptGroup( 450 , 0 );
			Wait ( 1 );
			CompleteObjective ( 2 );
			break;
		end;	
	end;
end;

------------------------WIn_Loose

function Looser()
	while 1 do
		Wait( 3 );
        if (( IsSomeUnitInParty(0) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
			Wait( 3 );
			Win(1);
			break;
		end;	
	end;
end;

function Looser1()
	while 1 do
		Wait( 3 );
		if  GetNUnitsInArea ( 0 , 'town', 0 ) < 1 and GetNUnitsInArea ( 1 , 'town', 0 ) > 0 then
			Wait( 3 );
			Win (1);
			break;
		end;	
	end;
end;

function Looser2()
	while 1 do
		Wait( 30 );
		if obj0 == 0 then
			if  GetNUnitsInArea(0,"all",0)==0 then
				Wait( 3 );
				Win (1);
				break;
			end;
		else
			break;
		end;
	end;
end;

-------------------------------------------  MAIN

StartThread( Objective );
StartThread( Looser );
StartThread( Looser2 );
--StartThread( Reinf );
StartThread( Recon );
StartThread( Trevoga );
StartThread( SecretObjective );

Cmd ( 5 , 101 , 0 , "Para1" );
Cmd ( 5 , 102 , 0 , "Para2" );
Cmd ( 5 , 103 , 0 , "Para3" );