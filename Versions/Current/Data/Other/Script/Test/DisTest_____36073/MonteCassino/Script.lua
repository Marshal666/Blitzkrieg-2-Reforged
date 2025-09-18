------------------------
-- deploy templates id consts
Deploy_Tanks = 9;
Deploy_MainInf = 11;
Deploy_TD = 10;
Deploy_GA = 12;
Deploy_Fighters = 13;
Deploy_Artillery = 14;
Deploy_HeavyArtillery = 15;
Deploy_AssaultSPG = 17;
Deploy_LightTanks = 19;
Deploy_AssaultInf = 18;
Deploy_SingleShip = 20;

-- player reinf id consts
Reinf_Player_Tanks = 59;
Reinf_Player_Artillery = 48;
Reinf_Player_MainInf = 57;
Reinf_Player_HeavyArtillery = 55;
Reinf_Player_Fighters = 53;
Reinf_Player_GA = 54;
Reinf_Player_TD = 58;
Reinf_Player_AssaultInf = 49;
Reinf_Player_AssaultSPG = 50;
Reinf_Player_LightTanks = 56;
Reinf_Player_TransportShip = 109;

Tanks, TD, MainInf, Artillery, HeavyArtillery, Fighters, GA = 1, 2, 3, 4, 5, 6, 7;

ReinfIDs = { Reinf_Player_Tanks, Reinf_Player_TD, Reinf_Player_MainInf, Reinf_Player_Artillery, Reinf_Player_HeavyArtillery, Reinf_Player_Fighters, Reinf_Player_GA };
DeployIDs = { Deploy_Tanks, Deploy_TD, Deploy_MainInf, Deploy_Artillery, Deploy_HeavyArtillery, Deploy_Fighters, Deploy_GA };

-- enemy reinf id consts
Reinf_Enemy_Tanks = 67;
Reinf_Enemy_TD = 69;
Reinf_Enemy_MainInf = 72;
Reinf_Enemy_GA = 75;
Reinf_Enemy_Fighters = 76;
Reinf_Enemy_AssaultInf = 68;
Reinf_Enemy_Artillery = 66;
Reinf_Enemy_HeavyArtillery = 71;
Reinf_Enemy_LightTanks = 70;
Reinf_Enemy_AssaultSPG = 77;

-- other
MINRADIUS = 50;
SIGHTRANGE = 37 * 32;
RADIUS = 512;
DISPERSION = 1024;
delay_attacks = 0;
stop_attacks = 0;

DeployTable = {};
DeployTable[ Reinf_Player_Tanks ] = Deploy_Tanks;
DeployTable[ Reinf_Player_Artillery ] = Deploy_Artillery;
DeployTable[ Reinf_Player_MainInf ] = Deploy_MainInf;
DeployTable[ Reinf_Player_HeavyArtillery ] = Deploy_HeavyArtillery;
DeployTable[ Reinf_Player_Fighters ] = Deploy_Fighters;
DeployTable[ Reinf_Player_GA ] = Deploy_GA;
DeployTable[ Reinf_Player_TD ] = Deploy_TD;
DeployTable[ Reinf_Player_AssaultInf ] = Deploy_AssaultInf;
DeployTable[ Reinf_Player_AssaultSPG ] = Deploy_AssaultSPG;
DeployTable[ Reinf_Player_LightTanks ] = Deploy_LightTanks;

PointsTable = {};
PointsTable[ Reinf_Player_Tanks ] = 5;
PointsTable[ Reinf_Player_Artillery ] = 9;
PointsTable[ Reinf_Player_MainInf ] = 11;
PointsTable[ Reinf_Player_HeavyArtillery ] = 10;
PointsTable[ Reinf_Player_Fighters ] = 2;
PointsTable[ Reinf_Player_GA ] = 1;
PointsTable[ Reinf_Player_TD ] = 8;
PointsTable[ Reinf_Player_AssaultInf ] = 12;
PointsTable[ Reinf_Player_AssaultSPG ] = 7;
PointsTable[ Reinf_Player_LightTanks ] = 6;
------------------------

--areas
UK_area1 = "UK_reinf1";
UK_area2 = "UK_reinf2";
Ger_area1 = "Ger_reinf1";
Ger_area2 = "Ger_reinf2";
Italian_area = "Italian_reinf";
Attack_5_area="Attack_5";
Attack_3_area="Attack_3";
Attack_5_1_area="Attack_5_1";
Attack_5_2_area="Attack_5_2";
Attack_3_1_area="Attack_3_1";
Attack_3_2_area="Attack_3_2";

--Global array
Attack_3_array={};
Attack_3_array=GetUnitListInAreaArray( 1, Ger_area1 );
Attack_5_array={};
Attack_5_array=GetUnitListInAreaArray( 1, Ger_area2 );

--var and const
DISPERSION=400;
EnemyReinf_3_5_Placed=0;
Combat_5=0;
Combat_3=0;
Func_start=0;
Attack_3_Placed=0;
Attack_5_Placed=0;
a=0;
b=0;
HoleEnemy=0; 		-- HoleEnemy=0 - position is our
Pos1=0; 		        -- Pos1=0 - position 1 is enemy
Pos4=0; 		        -- Pos4=0 - position 4 is enemy

--script groups
PzV = 500;
PzV_units = {};
PzV_units = GetObjectListArray ( PzV );

Wespe = 300;
Wespe_units = {};
Wespe_units = GetObjectListArray ( Wespe );

headquarters={};
headquarters=GetObjectListArray ( 200 );
depot={};
depot=GetObjectListArray ( 100 );

--functions

--Hill hold 3
function PzV_action()
	for i=1, PzV_units.n do
		UnitCmd ( ACT_SWARM, PzV_units[i],  9333, 13961);
		UnitQCmd ( ACT_ROTATE, PzV_units[i], GetScriptAreaParams ( Attack_3_area ) );
	end;
end;

--Hill hold 3
function Wespe_action()
	for i=1, Wespe_units.n do
		UnitCmd ( ACT_SWARM, Wespe_units[i],  9185, 13464);
		UnitQCmd ( ACT_ROTATE, Wespe_units[i], GetScriptAreaParams ( Attack_5_2_area ) );
	end;
end;

function RevealObjective0()
   if ( GetIGlobalVar( "MonteCassino.objective.0", 0 ) ~= 1 ) then
	ObjectiveChanged(0, 1);
      Trace("Objective0 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.0", 1 );
    end;
end;

function RevealObjective1()
while 1 do
   if HoleEnemy==0 then
      local k=0;

      while k<3 do
         if GetNUnitsInCircle ( 1,  9185, 13464, 500 )>0 then
            k=k+1;
         else
            k=0
         end;
         Wait(10);
      end;
      HoleEnemy=1;
      Trace("HoleEnemy");
   end;
   if ( GetIGlobalVar( "MonteCassino.objective.1", 0 ) ~= 1 ) then
   ObjectiveChanged(1, 1);
      Trace("Objective1 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.1", 1 );
      return 1;
   end;
Wait(3);
end;
end;

function RevealObjective2()
   ObjectiveChanged(2, 1);
   if ( GetIGlobalVar( "MonteCassino.objective.2", 0 ) ~= 1 ) then
      Trace("Objective2 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.2", 1 );
   end;
end;

function RevealObjective3()
   ObjectiveChanged(3, 1);
   if ( GetIGlobalVar( "MonteCassino.objective.3", 0 ) ~= 1 ) then
      Trace("Objective3 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.3", 1 );
   end;
end;

function RevealObjective4()
   ObjectiveChanged(4, 1);
   if ( GetIGlobalVar( "MonteCassino.objective.4", 0 ) ~= 1 ) then
      Trace("Objective4 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.4", 1 );
   end;
end;

function RevealObjective5()
   ObjectiveChanged(5, 1);
   if ( GetIGlobalVar( "MonteCassino.objective.5", 0 ) ~= 1 ) then
      Trace("Objective5 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.5", 1 );
   end;
end;

function RevealObjective6()
   ObjectiveChanged(2, 1);
   if ( GetIGlobalVar( "MonteCassino.objective.6", 0 ) ~= 1 ) then
      Trace("Objective6 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.6", 1 );
   end;
end;

function RevealObjective7()
   ObjectiveChanged(7, 1);
   if ( GetIGlobalVar( "MonteCassino.objective.7", 0 ) ~= 1 ) then
      Trace("Objective7 is reveal");
      SetIGlobalVar ( "MonteCassino.objective.7", 1 );
   end;
end;

function CompleteObjective0()
   if ( GetIGlobalVar( "MonteCassino.objective.0", 0 ) ~= 2 ) then
   	ObjectiveChanged(0, 2);
      Trace("Objective0 is complete");
      SetIGlobalVar ( "MonteCassino.objective.0", 2 );
   end;
end;

function CompleteObjective1()
   if ( GetIGlobalVar( "MonteCassino.objective.1", 0 ) ~= 2 ) then
   	ObjectiveChanged(1, 2);
      Trace("Objective1 is complete");
      SetIGlobalVar ( "MonteCassino.objective.1", 2 );
   end;
end;

function CompleteObjective2()
   if ( GetIGlobalVar( "MonteCassino.objective.2", 0 ) ~= 2 ) then
   	ObjectiveChanged(2, 2);
      Trace("Objective2 is complete");
      SetIGlobalVar ( "MonteCassino.objective.2", 2 );
   end;
end;

function CompleteObjective3()
   if ( GetIGlobalVar( "MonteCassino.objective.3", 0 ) ~= 2 ) then
   	ObjectiveChanged(3, 2);
      Trace("Objective3 is complete");
      SetIGlobalVar ( "MonteCassino.objective.3", 2 );
   end;
end;

function CompleteObjective4()
   if ( GetIGlobalVar( "MonteCassino.objective.4", 0 ) ~= 2 ) then
   	ObjectiveChanged(4, 2);
      Trace("Objective4 is complete");
      SetIGlobalVar ( "MonteCassino.objective.4", 2 );
   end;
end;

function CompleteObjective5()
   if ( GetIGlobalVar( "MonteCassino.objective.5", 0 ) ~= 2 ) then
   	ObjectiveChanged(5, 2);
      Trace("Objective5 is complete");
      SetIGlobalVar ( "MonteCassino.objective.5", 2 );
   end;
end;

function CompleteObjective6()
   if ( GetIGlobalVar( "MonteCassino.objective.6", 0 ) ~= 2 ) then
   	ObjectiveChanged(6, 2);
      Trace("Objective6 is complete");
      SetIGlobalVar ( "MonteCassino.objective.6", 2 );
   end;
end;

function CompleteObjective7()
   if ( GetIGlobalVar( "MonteCassino.objective.7", 0 ) ~= 2 ) then
   	ObjectiveChanged(7, 2);
      Trace("Objective7 is complete");
      SetIGlobalVar ( "MonteCassino.objective.7", 2 );
   end;
end;

-- repell enemy attack
function Objective0()
--Trace( "MonteCassino.objective.0=%g ", GetIGlobalVar( "MonteCassino.objective.0", 0 ));
--Trace( "EnemyReinf_3_5_Placed=%g ", EnemyReinf_3_5_Placed );
if ( GetIGlobalVar( "MonteCassino.objective.0", 0 ) == 1) and ( EnemyReinf_3_5_Placed==1 ) then
		a=NumUnitsAliveInArray( Attack_3_array );
		b=NumUnitsAliveInArray( Attack_5_array );
		if (  a<=0  ) and (  b<=0) then
			Trace("Quantity alive units in Attack_3_array=%g",a);
	      		Trace("Quantity alive units in Attack_5_array=%g",b);
		       	CompleteObjective0();
			return 1;
		end;
      if GetNUnitsInArea ( 1, Attack_5_area ) >0 and Combat_5==0 then
        Combat_5=1;
      end;
      if GetNUnitsInArea ( 1, Attack_3_area ) >0 and Combat_3==0 then
         Combat_3=1;
      end;
--      if ( Combat_3==1) and ( Combat_5==1 ) and ( Func_start==0 ) then
--         Func_start=1;
--         StartThread( Obj0ExtraCheck );
--      end;
end;
end;

function Obj0ExtraCheck()
   Wait(300);
   local GerUnitsInArea3={}; GerUnitsInArea3=GetUnitListInArea ( 1, Attack_3_area );
   local GerUnitsInArea5={}; GerUnitsInArea5=GetUnitListInArea ( 1, Attack_5_area );
   local UKUnitsInArea3={}; UKUnitsInArea3=GetUnitListInArea ( 0, Attack_3_area );
   local UKUnitsInArea5={}; UKUnitsInArea5=GetUnitListInArea ( 0, Attack_5_area );
   local c=NumUnitsAliveInArray( GerUnitsInArea3 );
   local d=NumUnitsAliveInArray( GerUnitsInArea5 );
   local e=NumUnitsAliveInArray( UKUnitsInArea3);
   local f=NumUnitsAliveInArray( UKUnitsInArea5 );
   if (a>Attack_3_array.n/2) and (b>Attack_5_array.n/2)and (c<e) and (d<f) then
      CompleteObjective0();
      Func_start=0;
      return 1;
   end;
end;

--return hill
function Objective1()
   if ( GetIGlobalVar( "MonteCassino.objective.1", 0 ) == 1) and ( HoleEnemy==1 ) then
      local k=0;

      while k<3 do
         if GetNUnitsInCircle ( 1,  9185, 13464, 500 )<=0 and GetNUnitsInCircle ( 0,  9185, 13464, 1000 )>0 then
            k=k+1;
         else
            k=0
         end;
         Wait(10);
      end;
      Trace("function Objective1 return 1");
      return 1;
    end;
end;

function Objective5()
        if Pos1==1 then
--         CompleteObjective5();
	    return 1;
      end;
   Wait(3);
end;

function Objective7()
      if Pos4==1 and Pos1==1 then
         return 1;
      end;
   Wait(3);
end;

function Reinf_Attack_3_array( k )
local Templates = { Deploy_Tanks, Deploy_TD, Deploy_MainInf, Deploy_GA };
local Reinfs = { Reinf_Enemy_Tanks, Reinf_Enemy_TD, Reinf_Enemy_Inf, Reinf_Enemy_GA };

	if ( k == nil ) then
		Trace("Reinf_Attack called without parameters");
		return 0;
	end;

	LandReinforcement( 1, Reinfs[k], Templates[k], 5 );
  	Trace ( "Attack_3_array called" );
	Wait ( 1 );
	Attack_3_array = GetUnitListInAreaArray( 1, Ger_area1 );
	Trace("Attack_3_array.n=%g",Attack_3_array.n);
	Wait( Random(20) );
	CmdArrayDisp( ACT_SWARM, Attack_3_array, DISPERSION, GetScriptAreaParams( Attack_3_area ) );
        QCmdArrayDisp( ACT_ROTATE, Attack_3_array, 0, GetScriptAreaParams( Attack_3_2_area ) );
        Attack_3_Placed=1;
	Trace("Attack_3_area.x=%g Attack_3_area.y=%g",GetScriptAreaParams( Attack_3_area ));
end;

function Reinf_Attack_5_array( k )
local Templates = { Deploy_Tanks, Deploy_TD, Deploy_MainInf, Deploy_GA };
local Reinfs = { Reinf_Enemy_Tanks, Reinf_Enemy_TD, Reinf_Enemy_Inf, Reinf_Enemy_GA };

	if ( k == nil ) then
		Trace("Reinf_Attack called without parameters");
		return 0;
	end;
	LandReinforcement( 1, Reinfs[k], Templates[k], 17 );
   Trace("Attack_5_array called");
	Wait( 1 );
	Attack_5_array = GetUnitListInAreaArray( 1, Ger_area2 );
	Trace("Attack_5_array.n=%g",Attack_5_array.n);
	Wait( Random(20) );
	CmdArrayDisp( ACT_SWARM, Attack_5_array, DISPERSION, GetScriptAreaParams( Attack_5_area ) );
	QCmdArrayDisp( ACT_ROTATE, Attack_5_array, 0, GetScriptAreaParams( Attack_5_2_area ) );
        Attack_5_Placed=1;
	Trace("Attack_5_area.x=%g Attack_5_area.y=%g",GetScriptAreaParams( Attack_5_area ));
end;

function Enemy_AI_Action()
 	Trace("Enemy_AI_Action Run");
local x, y;
while 1 do
if ( GetIGlobalVar( "MonteCassino.objective.0", 0 ) == 1) then
		StartThread( Reinf_Attack_3_array, 1 );
		StartThread( Reinf_Attack_5_array, 1 );
      Wait(1);
      while 1 do
         if Attack_3_Placed==1 and Attack_5_Placed==1 then
            EnemyReinf_3_5_Placed=1;
            Trace("EnemyReinf_3_5_Placed=1");

            Wait(2);

            if Random(2)==1 then
               CmdArrayDisp( ACT_SWARM, Attack_5_array, DISPERSION, GetScriptAreaParams( Attack_5_1_area ) );
               Trace("Group 5 Attack to Attack_5_1_area");
		x, y = GetScriptAreaParams( Attack_5_2_area );
               QCmdArrayDisp( ACT_SWARM, Attack_5_array, DISPERSION, GetScriptAreaParams( Attack_5_2_area ) );
--               QCmdArray(  ACT_ATTACKOBJECT, Attack_5_array, 200 );
		WaitForArrayAtPosition( Attack_5_array, x, y, 600 ); -- 256 * sqrt( 2 )
		StartThread( ArrayAttackScriptObject2, Attack_5_array, 200, 0 ); -- !!!!
            else
               CmdArrayDisp( ACT_SWARM, Attack_5_array, DISPERSION, GetScriptAreaParams( Attack_5_2_area ) );
               Trace("Group 5 Attack to Attack_5_2_area");
		x, y = GetScriptAreaParams( Attack_5_2_area );
--               QCmdArray(  ACT_ATTACKOBJECT, Attack_5_array, 200 );
		WaitForArrayAtPosition( Attack_5_array, x, y, 600 ); -- 256 * sqrt( 2 )
		StartThread( ArrayAttackScriptObject2, Attack_5_array, 200, 0 ); -- !!!!
            end;
            if Random(2)==1 then
               CmdArrayDisp( ACT_SWARM, Attack_3_array, DISPERSION, GetScriptAreaParams( Attack_3_1_area ) );
               Trace("Group 3 Attack to Attack_3_1_area");
		x, y = GetScriptAreaParams( Attack_3_2_area );
               QCmdArrayDisp( ACT_SWARM, Attack_3_array, DISPERSION, GetScriptAreaParams( Attack_3_2_area ) );
--               QCmdArray(  ACT_ATTACKOBJECT, Attack_3_array, 100 );
		WaitForArrayAtPosition( Attack_3_array, x, y, 600 ); -- 256 * sqrt( 2 )
		StartThread( ArrayAttackScriptObject2, Attack_3_array, 100, 0 ); -- !!!!
            else
               CmdArrayDisp( ACT_SWARM, Attack_3_array, DISPERSION, GetScriptAreaParams( Attack_3_2_area ) );
               Trace("Group 3 Attack to Attack_3_2_area");
		x, y = GetScriptAreaParams( Attack_3_2_area );
--               QCmdArray(  ACT_ATTACKOBJECT, Attack_3_array, 100 );
		WaitForArrayAtPosition( Attack_3_array, x, y, 600 ); -- 256 * sqrt( 2 )
		StartThread( ArrayAttackScriptObject2, Attack_3_array, 100, 0 ); -- !!!!
            end;
            Wait(100+Random(50));
            PzV_action();
            Wespe_action();
            return 1;
         end;
      Wait(3);
      end;
end;
Wait(5);
end;
end;

function _AttackObject (array, objarray, objScriptID)
	CmdArray( ACT_SWARM, array, ObjectGetCoord( objarray ) );
	Wait( 1 );
	while ( GetUnitState( array ) ~= STATE_REST ) do
		Wait( 1 );
	end;
	Trace("Rest");
	Cmd( ACT_ATTACKOBJECT, array, objScriptID );
	while ( GetScriptObjectHPs( objScriptID ) > 0 ) do
		if ( GetNUnitsNearScriptObj( 0, array, 500 ) > 0) then
		Cmd( ACT_STOP, array );
			while ( GetNUnitsNearScriptObj( 0, array, 500 ) > 0 ) do
				Wait( 2 );
			end;
		Cmd( ACT_ATTACKOBJECT, array, objScriptID );
		end;
		Wait( 1 );
	end;
end;

function ArrayAttackScriptObject2( group, scriptid, defendingplayer )
local x, y = GetScriptObjCoord( scriptid );
--	CmdArrayDisp( ACT_SWARM, group, 256, x, y );
--	WaitForArrayAtPosition( group, x, y, 400 ); -- 256 * sqrt( 2 )
	if ( NumUnitsAliveInArray( group ) > 0 ) then
	CmdArray( ACT_ATTACKOBJECT, group, GetObjectList( scriptid ) );
	while ( ( GetScriptObjectHPs( scriptid ) > 0 ) and ( NumUnitsAliveInArray( group ) > 0 ) ) do
		if ( GetNUnitsNearArray( defendingplayer, group, SIGHTRANGE ) > 0 ) then
		CmdArray( ACT_STOP, group );
			while ( ( GetNUnitsNearArray( defendingplayer, group, SIGHTRANGE ) > 0 ) and ( NumUnitsAliveInArray( group ) > 0 ) ) do
				Wait( 2 );
			end;
		CmdArray( ACT_ATTACKOBJECT, group, GetObjectList( scriptid ) );
		end;
		Wait( 1 );
	end;
	end;
end;



function LoseCheck()
	while 1 do
--      headquarters=GetObjectListArray ( 200 );
--      depot=GetObjectListArray ( 100 );
                if NumUnitsAliveInArray( headquarters )<=0 or NumUnitsAliveInArray( depot )<=0 then
         Trace("Lose:(((((((((((((((((((((((((((((((((((((((((((((((((((((((");
			Win(1);
         return 1;
		end;
	Wait(5);
	end;
end;

function WinCheck()
	while 1 do
      if ( Pos1 == 1) and  ( Pos4 == 1) then
         Trace("Win!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			Win (0);
         return 1;
      end;
   Wait(5);
	end;
end;

function CheckPos1()
   while 1 do
      local k=0;

      while k<3 do
         if GetNUnitsInCircle ( 1,  6648, 8660, 1000 )<=0 and GetNUnitsInCircle ( 0,  6648, 8660, 1000 )>0 then   -- check position (1) for 1-2 player's
            k=k+1;
         else
            k=0;
            Pos1=0;
         end;
         Wait(10);
      end;
      Pos1=1;
      if Pos1==1 then
         Trace("Position 1 is our");
      else
         Trace("Position 1 is enemy");
   	end;
   Wait(5);
	end;
end;

function CheckPos4()
   while 1 do
      local k=0;

      while k<3 do
         if GetNUnitsInCircle ( 1,  2035, 14866, 1000 )<=0 and GetNUnitsInCircle ( 0,  2035, 14866, 1000 )>0 then   -- check position (1) for 1-2 player's
            k=k+1;
         else
            k=0;
            Pos4=0;
         end;
         Wait(10);
      end;
      Pos4=1;
      if Pos4==1 then
         Trace("Position 4 is our");
      else
         Trace("Position 4 is enemy");
   	end;
   Wait(5);
   end;
end;

function StartMission()
	Trace("StartMission Run");
	RevealObjective0();
	return 1;
end;



function TraceUnits()
--	Trace( "Ger_units %g", GetNUnitsInParty ( 1 ) );
--	Trace( "UK_units %g", GetNUnitsInParty ( 0 ) );
--	Trace("GerUnits in Attack_5_area%g", GetUnitListInArea ( 1, Attack_5_area ));
--	Trace("GerUnits in Attack_3_area%g", GetUnitListInArea ( 1, Attack_3_area ));
--	Trace("Quantity alive units in Attack_3_array=%g",a);
--	Trace("Quantity alive units in Attack_5_array=%g",b);
	Trace("Quantity alive obj in depot=%g", NumUnitsAliveInArray1( depot ));
	Trace("depot.n=%g", depot.n );
	Trace("HP obj in depot=%g", GetObjectHPs (GetObjectList(100)));
end;

function TraceUnits1()
--	Trace( "Ger_units %g", GetNUnitsInParty ( 1 ) );
--	Trace( "UK_units %g", GetNUnitsInParty ( 0 ) );
--	Trace("GerUnits in Attack_5_area%g", GetUnitListInArea ( 1, Attack_5_area ));
--	Trace("GerUnits in Attack_3_area%g", GetUnitListInArea ( 1, Attack_3_area ));
--	Trace("Quantity alive units in Attack_3_array=%g",a);
--	Trace("Quantity alive units in Attack_5_array=%g",b);
	Trace("Quantity alive obj in headquarters=%g", NumUnitsAliveInArray1( headquarters ));
	Trace("headquarters.n=%g", headquarters.n );
	Trace("HP obj in headquarters=%g", GetObjectHPs (headquarters[1] ));
end;

function NumUnitsAliveInArray1( array )
	local tmp_array={};
	local n=0;
		tmp_array.n=array.n;Trace("tmp_array.n=%g",tmp_array.n);
		tmp_array=array;
	for i=1, tmp_array.n do
		if (GetObjectHPs ( tmp_array[i] )>=0 ) then
			n=n+1;Trace("n=%g",n);
			Trace("HP tmp_array[%g]=%g",i,GetObjectHPs ( tmp_array[i] ));
		end;
	end;

	if ( n>tmp_array.n ) then
		Trace("Error in NumUnitsAliveInArray n>tmp_array.n");
	end;

	Trace("result_n%g",n);
	return n;
end;

------------------------
function EnableNextReinf()
	Wait( 150 );
	SetIGlobalVar( "temp.reinfcalled", 0 );
end;

function NotifyReinforcementCalled( nPlayer, nReinf )
	if ( ( nPlayer == 0 ) and ( GetIGlobalVar( "temp.reinfcalled", 0 ) == 0 ) ) then
		SetIGlobalVar( "temp.reinfcalled", 1 );
		StartThread( EnableNextReinf );
		LandReinforcement( 0, nReinf, DeployTable[nReinf], PointsTable[nReinf] );
	end;
end;
------------------------

--Main
StartThread( WinCheck );
StartThread( LoseCheck );
StartThread( Enemy_AI_Action );
StartThread( CheckPos1 );
StartThread( CheckPos4 );
StartThread( StartMission );
StartThread( RevealObjective1 );
StartThread( RevealObjective5 );
StartThread( RevealObjective7 );
Trigger( Objective0, CompleteObjective0 );
Trigger( Objective1, CompleteObjective1 );
Trigger( Objective5, CompleteObjective5 );
Trigger( Objective7, CompleteObjective7 );

