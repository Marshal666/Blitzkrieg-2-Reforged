y1 = 0
--------------------------------------Loose conditions
function Caput ()
 
   while 1 do
        Wait( 3 );
        if (( GetNUnitsInScriptGroup ( 10, 1 ) > 0 ) and ( GetNUnitsInScriptGroup ( 10, 0 ) < 1 )) or (( GetNUnitsInPlayerUF ( 0 ) < 1) and ( GetReinforcementCallsLeft( 0 ) == 0 )) then
		Wait(2);
		Win(1);
		return 1;
		end;
	end;
end;
---------------------------------------Victory
function Victory ()

    while 1 do
    Wait (2)
      if y1 == 1 and ( GetNUnitsInScriptGroup ( 10, 1 ) < 1 ) and  ( GetNUnitsInPlayerUF ( 1 ) < 2) then
      Wait (1);
      CompleteObjective (0);
      DamageScriptObject (123, 100);
      Wait (5)
      Win (0);
      return 1; 
      end;
    end;
end;
---------------------------------------Repair 
function Repair ()

    while 1 do
      Wait (5); 
      DamageScriptObject (9, -200);
    end;
end;
--------------------------------------Difficuilty
function DifficuiltyEasy ()
    
    while 1 do
      Wait (1)
        if (GetDifficultyLevel () == 0) then 
          StartThread ( Attack1Ae );
          StartThread ( Attack1Be );
          StartThread ( Attack1Ce );
          StartThread ( Attack1De );
          StartThread ( Attack1Fe );
          StartThread ( Attack1Ge );
          StartThread ( Attack2Ae );
          StartThread ( Attack2Be );
          StartThread ( Attack2Ce );
          StartThread ( Attack2De );
          StartThread ( Attack2Fe );
          StartThread ( Attack2Ge );
          StartThread ( Attack3Ae );
          StartThread ( Attack3Be );
          StartThread ( Attack3Ce );
          StartThread ( Attack3De );
          StartThread ( Attack3Fe );
          StartThread ( Attack3Ge );
          StartThread ( Attack4Ae );
          StartThread ( Attack4Be );
          StartThread ( Attack4Ce );
          StartThread ( Attack4De );
          StartThread ( Attack4Fe );
          StartThread ( Attack4Ge );
          StartThread ( Attack5Ae );
          StartThread ( Attack5Be );
          StartThread ( Attack5Ce );
          StartThread ( Attack5De );
          StartThread ( Attack5Fe );
          StartThread ( Attack5Ge );
          break;
        end;
    end;
end;
 
function DifficuiltyNormal ()
    
    while 1 do
        Wait (1)  
        if (GetDifficultyLevel () == 1) then 
          StartThread ( Attack1A );
          StartThread ( Attack1B );
          StartThread ( Attack1C );
          StartThread ( Attack1D );
          StartThread ( Attack1F );
          StartThread ( Attack1G );
          StartThread ( Attack2A );
          StartThread ( Attack2B );
          StartThread ( Attack2C );
          StartThread ( Attack2D );
          StartThread ( Attack2F );
          StartThread ( Attack2G );
          StartThread ( Attack3A );
          StartThread ( Attack3B );
          StartThread ( Attack3C );
          StartThread ( Attack3D );
          StartThread ( Attack3F );
          StartThread ( Attack3G );
          StartThread ( Attack4A );
          StartThread ( Attack4B );
          StartThread ( Attack4C );
          StartThread ( Attack4D );
          StartThread ( Attack4F );
          StartThread ( Attack4G );
          StartThread ( Attack5A );
          StartThread ( Attack5B );
          StartThread ( Attack5C );
          StartThread ( Attack5D );
          StartThread ( Attack5F );
          StartThread ( Attack5G );
          break;
        end;
    end;
end;

function DifficuiltyHard ()
    
    while 1 do
        Wait (1)  
        if (GetDifficultyLevel () == 2) then 
          StartThread ( Attack1Ah );
          StartThread ( Attack1Bh );
          StartThread ( Attack1Ch );
          StartThread ( Attack1Dh );
          StartThread ( Attack1Fh );
          StartThread ( Attack1Gh );
          StartThread ( Attack2Ah );
          StartThread ( Attack2Bh );
          StartThread ( Attack2Ch );
          StartThread ( Attack2Dh );
          StartThread ( Attack2Fh );
          StartThread ( Attack2Gh );
          StartThread ( Attack3Ah );
          StartThread ( Attack3Bh );
          StartThread ( Attack3Ch );
          StartThread ( Attack3Dh );
          StartThread ( Attack3Fh );
          StartThread ( Attack3Gh );
          StartThread ( Attack4Ah );
          StartThread ( Attack4Bh );
          StartThread ( Attack4Ch );
          StartThread ( Attack4Dh );
          StartThread ( Attack4Fh );
          StartThread ( Attack4Gh );
          StartThread ( Attack5Ah );
          StartThread ( Attack5Bh );
          StartThread ( Attack5Ch );
          StartThread ( Attack5Dh );
          StartThread ( Attack5Fh );
          StartThread ( Attack5Gh );
          break;
        end;
    end;
end;


--------------------------------------Front attacks EASY
--------------------------------------First Wave
function Attack1Ae ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1e", 0, 100 );
        Wait ( 1 );
        ChangeFormation ( 100, 3 );
        Cmd (3, 100, 300, 3662, 5235 );
        QCmd (3, 100, 300, 3521, 3477 );
        QCmd (3, 100, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Be ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1e", 1, 101 );
        Wait ( 1 );
        ChangeFormation ( 101, 3 );
        Cmd (3, 101, 300, 4152, 5234 );
        QCmd (3, 101, 300, 4284, 3675 );
        QCmd (3, 101, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Ce ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1e", 2, 102 );
        Wait ( 1 );
        ChangeFormation ( 102, 3 );
        Cmd (3, 102, 300, 4706, 5329 );
        QCmd (3, 102, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1De ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1e", 3, 103 );
        Wait ( 1 );
        ChangeFormation ( 103, 3 );
        Cmd (3, 103, 300, 4947, 4863 );
        QCmd (3, 103, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Fe ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1e", 4, 104 );
        Wait ( 1 );
        ChangeFormation ( 104, 3 );
        Cmd (3, 104, 100, 6714, 5156 );
        QCmd (3, 104, 100, 5814, 2452 );
        QCmd (3, 104, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Ge ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1e", 5, 105 );
        Wait ( 1 );
        ChangeFormation ( 105, 3 );
        Cmd (3, 105, 100, 6991, 5177 );
        QCmd (3, 105, 100, 6168, 2139 );
        QCmd (3, 105, 300, 4772, 3002 );
        break;
    end;
end;
--------------------------------------Second Wave
function Attack2Ae ()

    while 1 do
        Wait ( 90 ) ;
        LandReinforcementFromMap( 1, "JT2e", 0, 200 );
        Wait ( 1 );
        ChangeFormation ( 200, 3 );
        Cmd (3, 200, 300, 3662, 5235 );
        QCmd (3, 200, 300, 3521, 3477 );
        QCmd (3, 200, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Be ()

    while 1 do
        Wait ( 90 ) ;
        LandReinforcementFromMap( 1, "JT2e", 1, 201 );
        Wait ( 1 );
        ChangeFormation ( 201, 3 );
        Cmd (3, 201, 300, 4152, 5234 );
        QCmd (3, 201, 300, 4284, 3675 );
        QCmd (3, 201, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Ce ()

    while 1 do
        Wait ( 210 ) ;
        LandReinforcementFromMap( 1, "JT2e", 2, 202 );
        Wait ( 1 );
        ChangeFormation ( 202, 3 );
        Cmd (3, 202, 300, 4706, 5329 );
        QCmd (3, 202, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2De ()

    while 1 do
        Wait ( 210 ) ;
        LandReinforcementFromMap( 1, "JT2e", 3, 203 );
        Wait ( 1 );
        ChangeFormation ( 203, 3 );
        Cmd (3, 203, 300, 4947, 4863 );
        QCmd (3, 203, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Fe ()

    while 1 do
        Wait ( 150 ) ;
        LandReinforcementFromMap( 1, "JT2e", 4, 204 );
        Wait ( 1 );
        ChangeFormation ( 204, 3 );
        Cmd (3, 204, 100, 6714, 5156 );
        QCmd (3, 204, 100, 5814, 2452 );
        QCmd (3, 204, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Ge ()

    while 1 do
        Wait ( 150 ) ;
        LandReinforcementFromMap( 1, "JT2e", 5, 205 );
        Wait ( 1 );
        ChangeFormation ( 205, 3 );
        Cmd (3, 205, 100, 6991, 5177 );
        QCmd (3, 205, 100, 6168, 2139 );
        QCmd (3, 205, 300, 4772, 3002 );
        break;
    end;
end;
--------------------------FirdWave
function Attack3Ae ()

    while 1 do
        Wait ( 320 ) ;
        LandReinforcementFromMap( 1, "JT3e", 0, 300 );
        Wait ( 1 );
        ChangeFormation ( 300, 3 );
        Cmd (3, 300, 300, 3662, 5235 );
        QCmd (3, 300, 300, 3521, 3477 );
        QCmd (3, 300, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Be ()

    while 1 do
        Wait ( 320 ) ;
        LandReinforcementFromMap( 1, "JT3e", 1, 301 );
        Wait ( 1 );
        ChangeFormation ( 301, 3 );
        Cmd (3, 301, 300, 4152, 5234 );
        QCmd (3, 301, 300, 4284, 3675 );
        QCmd (3, 301, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Ce ()

    while 1 do
        Wait ( 270 ) ;
        LandReinforcementFromMap( 1, "JT3e", 2, 302 );
        Wait ( 1 );
        ChangeFormation ( 302, 3 );
        Cmd (3, 302, 300, 4706, 5329 );
        QCmd (3, 302, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3De ()

    while 1 do
        Wait ( 270 ) ;
        LandReinforcementFromMap( 1, "JT3e", 3, 303 );
        Wait ( 1 );
        ChangeFormation ( 303, 3 );
        Cmd (3, 303, 300, 4947, 4863 );
        QCmd (3, 303, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Fe ()

    while 1 do
        Wait ( 350 ) ;
        LandReinforcementFromMap( 1, "JT3e", 4, 304 );
        Wait ( 1 );
        ChangeFormation ( 304, 3 );
        Cmd (3, 304, 100, 6714, 5156 );
        QCmd (3, 304, 100, 5814, 2452 );
        QCmd (3, 304, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Ge ()

    while 1 do
        Wait ( 350 ) ;
        LandReinforcementFromMap( 1, "JT3e", 5, 305 );
        Wait ( 1 );
        ChangeFormation ( 305, 3 );
        Cmd (3, 305, 100, 6991, 5177 );
        QCmd (3, 305, 100, 6168, 2139 );
        QCmd (3, 305, 300, 4772, 3002 );
        break;
    end;
end;

--------------------------FourthWave
function Attack4Ae ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4e", 0, 400 );
        Wait ( 1 );
        ChangeFormation ( 400, 3 );
        Cmd (3, 400, 300, 3662, 5235 );
        QCmd (3, 400, 300, 3521, 3477 );
        QCmd (3, 400, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Be ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4e", 1, 401 );
        Wait ( 1 );
        ChangeFormation ( 401, 3 );
        Cmd (3, 401, 300, 4152, 5234 );
        QCmd (3, 401, 300, 4284, 3675 );
        QCmd (3, 401, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Ce ()

    while 1 do
        Wait ( 400 ) ;
        LandReinforcementFromMap( 1, "JT4e", 2, 402 );
        Wait ( 1 );
        ChangeFormation ( 402, 3 );
        Cmd (3, 402, 300, 4706, 5329 );
        QCmd (3, 402, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4De ()

    while 1 do
        Wait ( 400 ) ;
        LandReinforcementFromMap( 1, "JT4e", 3, 403 );
        Wait ( 1 );
        ChangeFormation ( 403, 3 );
        Cmd (3, 403, 300, 4947, 4863 );
        QCmd (3, 403, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Fe ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4e", 4, 404 );
        Wait ( 1 );
        ChangeFormation ( 404, 3 );
        Cmd (3, 404, 100, 6714, 5156 );
        QCmd (3, 404, 100, 5814, 2452 );
        QCmd (3, 404, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Ge ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4e", 5, 405 );
        Wait ( 1 );
        ChangeFormation ( 405, 3 );
        Cmd (3, 405, 100, 6991, 5177 );
        QCmd (3, 405, 100, 6168, 2139 );
        QCmd (3, 405, 300, 4772, 3002 );
        break;
    end;
end;
------------------------------------5 Wave
function Attack5Ae ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4e", 0, 500 );
        Wait ( 1 );
        ChangeFormation ( 500, 3 );
        Cmd (3, 500, 300, 3662, 5235 );
        QCmd (3, 500, 300, 3521, 3477 );
        QCmd (3, 500, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Be ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4e", 1, 501 );
        Wait ( 1 );
        ChangeFormation ( 501, 3 );
        Cmd (3, 501, 300, 4152, 5234 );
        QCmd (3, 501, 300, 4284, 3675 );
        QCmd (3, 501, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Ce ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4e", 2, 502 );
        Wait ( 1 );
        ChangeFormation ( 502, 3 );
        Cmd (3, 502, 300, 4706, 5329 );
        QCmd (3, 502, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5De ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4e", 3, 503 );
        Wait ( 1 );
        ChangeFormation ( 503, 3 );
        Cmd (3, 503, 300, 4947, 4863 );
        QCmd (3, 503, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Fe ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4e", 4, 504 );
        Wait ( 1 );
        ChangeFormation ( 504, 3 );
        Cmd (3, 504, 100, 6714, 5156 );
        QCmd (3, 504, 100, 5814, 2452 );
        QCmd (3, 504, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Ge ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4e", 5, 505 );
        Wait ( 1 );
        ChangeFormation ( 505, 3 );
        Cmd (3, 505, 100, 6991, 5177 );
        QCmd (3, 505, 100, 6168, 2139 );
        QCmd (3, 505, 300, 4772, 3002 );
        break;
    end;
end;

--------------------------------------Front attacks NORMAL
--------------------------------------First Wave
function Attack1A ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1", 0, 100 );
        Wait ( 1 );
        ChangeFormation ( 100, 3 );
        Cmd (3, 100, 300, 3662, 5235 );
        QCmd (3, 100, 300, 3521, 3477 );
        QCmd (3, 100, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1B ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1", 1, 101 );
        Wait ( 1 );
        ChangeFormation ( 101, 3 );
        Cmd (3, 101, 300, 4152, 5234 );
        QCmd (3, 101, 300, 4284, 3675 );
        QCmd (3, 101, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1C ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1", 2, 102 );
        Wait ( 1 );
        ChangeFormation ( 102, 3 );
        Cmd (3, 102, 300, 4706, 5329 );
        QCmd (3, 102, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1D ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1", 3, 103 );
        Wait ( 1 );
        ChangeFormation ( 103, 3 );
        Cmd (3, 103, 300, 4947, 4863 );
        QCmd (3, 103, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1F ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1", 4, 104 );
        Wait ( 1 );
        ChangeFormation ( 104, 3 );
        Cmd (3, 104, 100, 6714, 5156 );
        QCmd (3, 104, 100, 5814, 2452 );
        QCmd (3, 104, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1G ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1", 5, 105 );
        Wait ( 1 );
        ChangeFormation ( 105, 3 );
        Cmd (3, 105, 100, 6991, 5177 );
        QCmd (3, 105, 100, 6168, 2139 );
        QCmd (3, 105, 300, 4772, 3002 );
        break;
    end;
end;
--------------------------------------Second Wave
function Attack2A ()

    while 1 do
        Wait ( 90 ) ;
        LandReinforcementFromMap( 1, "JT2", 0, 200 );
        Wait ( 1 );
        ChangeFormation ( 200, 3 );
        Cmd (3, 200, 300, 3662, 5235 );
        QCmd (3, 200, 300, 3521, 3477 );
        QCmd (3, 200, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2B ()

    while 1 do
        Wait ( 90 ) ;
        LandReinforcementFromMap( 1, "JT2", 1, 201 );
        Wait ( 1 );
        ChangeFormation ( 201, 3 );
        Cmd (3, 201, 300, 4152, 5234 );
        QCmd (3, 201, 300, 4284, 3675 );
        QCmd (3, 201, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2C ()

    while 1 do
        Wait ( 210 ) ;
        LandReinforcementFromMap( 1, "JT2", 2, 202 );
        Wait ( 1 );
        ChangeFormation ( 202, 3 );
        Cmd (3, 202, 300, 4706, 5329 );
        QCmd (3, 202, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2D ()

    while 1 do
        Wait ( 210 ) ;
        LandReinforcementFromMap( 1, "JT2", 3, 203 );
        Wait ( 1 );
        ChangeFormation ( 203, 3 );
        Cmd (3, 203, 300, 4947, 4863 );
        QCmd (3, 203, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2F ()

    while 1 do
        Wait ( 150 ) ;
        LandReinforcementFromMap( 1, "JT2", 4, 204 );
        Wait ( 1 );
        ChangeFormation ( 204, 3 );
        Cmd (3, 204, 100, 6714, 5156 );
        QCmd (3, 204, 100, 5814, 2452 );
        QCmd (3, 204, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2G ()

    while 1 do
        Wait ( 150 ) ;
        LandReinforcementFromMap( 1, "JT2", 5, 205 );
        Wait ( 1 );
        ChangeFormation ( 205, 3 );
        Cmd (3, 205, 100, 6991, 5177 );
        QCmd (3, 205, 100, 6168, 2139 );
        QCmd (3, 205, 300, 4772, 3002 );
        break;
    end;
end;
--------------------------FirdWave
function Attack3A ()

    while 1 do
        Wait ( 320 ) ;
        LandReinforcementFromMap( 1, "JT3", 0, 300 );
        Wait ( 1 );
        ChangeFormation ( 300, 3 );
        Cmd (3, 300, 300, 3662, 5235 );
        QCmd (3, 300, 300, 3521, 3477 );
        QCmd (3, 300, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3B ()

    while 1 do
        Wait ( 320 ) ;
        LandReinforcementFromMap( 1, "JT3", 1, 301 );
        Wait ( 1 );
        ChangeFormation ( 301, 3 );
        Cmd (3, 301, 300, 4152, 5234 );
        QCmd (3, 301, 300, 4284, 3675 );
        QCmd (3, 301, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3C ()

    while 1 do
        Wait ( 270 ) ;
        LandReinforcementFromMap( 1, "JT3", 2, 302 );
        Wait ( 1 );
        ChangeFormation ( 302, 3 );
        Cmd (3, 302, 300, 4706, 5329 );
        QCmd (3, 302, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3D ()

    while 1 do
        Wait ( 270 ) ;
        LandReinforcementFromMap( 1, "JT3", 3, 303 );
        Wait ( 1 );
        ChangeFormation ( 303, 3 );
        Cmd (3, 303, 300, 4947, 4863 );
        QCmd (3, 303, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3F ()

    while 1 do
        Wait ( 350 ) ;
        LandReinforcementFromMap( 1, "JT3", 4, 304 );
        Wait ( 1 );
        ChangeFormation ( 304, 3 );
        Cmd (3, 304, 100, 6714, 5156 );
        QCmd (3, 304, 100, 5814, 2452 );
        QCmd (3, 304, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3G ()

    while 1 do
        Wait ( 350 ) ;
        LandReinforcementFromMap( 1, "JT3", 5, 305 );
        Wait ( 1 );
        ChangeFormation ( 305, 3 );
        Cmd (3, 305, 100, 6991, 5177 );
        QCmd (3, 305, 100, 6168, 2139 );
        QCmd (3, 305, 300, 4772, 3002 );
        break;
    end;
end;

--------------------------FourthWave
function Attack4A ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4", 0, 400 );
        Wait ( 1 );
        ChangeFormation ( 400, 3 );
        Cmd (3, 400, 300, 3662, 5235 );
        QCmd (3, 400, 300, 3521, 3477 );
        QCmd (3, 400, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4B ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4", 1, 401 );
        Wait ( 1 );
        ChangeFormation ( 401, 3 );
        Cmd (3, 401, 300, 4152, 5234 );
        QCmd (3, 401, 300, 4284, 3675 );
        QCmd (3, 401, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4C ()

    while 1 do
        Wait ( 400 ) ;
        LandReinforcementFromMap( 1, "JT4", 2, 402 );
        Wait ( 1 );
        ChangeFormation ( 402, 3 );
        Cmd (3, 402, 300, 4706, 5329 );
        QCmd (3, 402, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4D ()

    while 1 do
        Wait ( 400 ) ;
        LandReinforcementFromMap( 1, "JT4", 3, 403 );
        Wait ( 1 );
        ChangeFormation ( 403, 3 );
        Cmd (3, 403, 300, 4947, 4863 );
        QCmd (3, 403, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4F ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4", 4, 404 );
        Wait ( 1 );
        ChangeFormation ( 404, 3 );
        Cmd (3, 404, 100, 6714, 5156 );
        QCmd (3, 404, 100, 5814, 2452 );
        QCmd (3, 404, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4G ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4", 5, 405 );
        Wait ( 1 );
        ChangeFormation ( 405, 3 );
        Cmd (3, 405, 100, 6991, 5177 );
        QCmd (3, 405, 100, 6168, 2139 );
        QCmd (3, 405, 300, 4772, 3002 );
        break;
    end;
end;
------------------------------------5 Wave
function Attack5A ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4", 0, 500 );
        Wait ( 1 );
        ChangeFormation ( 500, 3 );
        Cmd (3, 500, 300, 3662, 5235 );
        QCmd (3, 500, 300, 3521, 3477 );
        QCmd (3, 500, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5B ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4", 1, 501 );
        Wait ( 1 );
        ChangeFormation ( 501, 3 );
        Cmd (3, 501, 300, 4152, 5234 );
        QCmd (3, 501, 300, 4284, 3675 );
        QCmd (3, 501, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5C ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4", 2, 502 );
        Wait ( 1 );
        ChangeFormation ( 502, 3 );
        Cmd (3, 502, 300, 4706, 5329 );
        QCmd (3, 502, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5D ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4", 3, 503 );
        Wait ( 1 );
        ChangeFormation ( 503, 3 );
        Cmd (3, 503, 300, 4947, 4863 );
        QCmd (3, 503, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5F ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4", 4, 504 );
        Wait ( 1 );
        ChangeFormation ( 504, 3 );
        Cmd (3, 504, 100, 6714, 5156 );
        QCmd (3, 504, 100, 5814, 2452 );
        QCmd (3, 504, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5G ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4", 5, 505 );
        Wait ( 1 );
        ChangeFormation ( 505, 3 );
        Cmd (3, 505, 100, 6991, 5177 );
        QCmd (3, 505, 100, 6168, 2139 );
        QCmd (3, 505, 300, 4772, 3002 );
        break;
    end;
end;
-------------------------------------Front attacks HARD
--------------------------------------First Wave
function Attack1Ah ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1h", 0, 100 );
        Wait ( 1 );
        ChangeFormation ( 100, 3 );
        Cmd (3, 100, 300, 3662, 5235 );
        QCmd (3, 100, 300, 3521, 3477 );
        QCmd (3, 100, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Bh ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1h", 1, 101 );
        Wait ( 1 );
        ChangeFormation ( 101, 3 );
        Cmd (3, 101, 300, 4152, 5234 );
        QCmd (3, 101, 300, 4284, 3675 );
        QCmd (3, 101, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Ch ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1h", 2, 102 );
        Wait ( 1 );
        ChangeFormation ( 102, 3 );
        Cmd (3, 102, 300, 4706, 5329 );
        QCmd (3, 102, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Dh ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1h", 3, 103 );
        Wait ( 1 );
        ChangeFormation ( 103, 3 );
        Cmd (3, 103, 300, 4947, 4863 );
        QCmd (3, 103, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Fh ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1h", 4, 104 );
        Wait ( 1 );
        ChangeFormation ( 104, 3 );
        Cmd (3, 104, 100, 6714, 5156 );
        QCmd (3, 104, 100, 5814, 2452 );
        QCmd (3, 104, 300, 4772, 3002 );
        break;
    end;
end;

function Attack1Gh ()

    while 1 do
        Wait ( 5 ) ;
        LandReinforcementFromMap( 1, "JT1h", 5, 105 );
        Wait ( 1 );
        ChangeFormation ( 105, 3 );
        Cmd (3, 105, 100, 6991, 5177 );
        QCmd (3, 105, 100, 6168, 2139 );
        QCmd (3, 105, 300, 4772, 3002 );
        break;
    end;
end;
--------------------------------------Second Wave
function Attack2Ah ()

    while 1 do
        Wait ( 90 ) ;
        LandReinforcementFromMap( 1, "JT2h", 0, 200 );
        Wait ( 1 );
        ChangeFormation ( 200, 3 );
        Cmd (3, 200, 300, 3662, 5235 );
        QCmd (3, 200, 300, 3521, 3477 );
        QCmd (3, 200, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Bh ()

    while 1 do
        Wait ( 90 ) ;
        LandReinforcementFromMap( 1, "JT2h", 1, 201 );
        Wait ( 1 );
        ChangeFormation ( 201, 3 );
        Cmd (3, 201, 300, 4152, 5234 );
        QCmd (3, 201, 300, 4284, 3675 );
        QCmd (3, 201, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Ch ()

    while 1 do
        Wait ( 210 ) ;
        LandReinforcementFromMap( 1, "JT2h", 2, 202 );
        Wait ( 1 );
        ChangeFormation ( 202, 3 );
        Cmd (3, 202, 300, 4706, 5329 );
        QCmd (3, 202, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Dh ()

    while 1 do
        Wait ( 210 ) ;
        LandReinforcementFromMap( 1, "JT2h", 3, 203 );
        Wait ( 1 );
        ChangeFormation ( 203, 3 );
        Cmd (3, 203, 300, 4947, 4863 );
        QCmd (3, 203, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Fh ()

    while 1 do
        Wait ( 150 ) ;
        LandReinforcementFromMap( 1, "JT2h", 4, 204 );
        Wait ( 1 );
        ChangeFormation ( 204, 3 );
        Cmd (3, 204, 100, 6714, 5156 );
        QCmd (3, 204, 100, 5814, 2452 );
        QCmd (3, 204, 300, 4772, 3002 );
        break;
    end;
end;

function Attack2Gh ()

    while 1 do
        Wait ( 150 ) ;
        LandReinforcementFromMap( 1, "JT2h", 5, 205 );
        Wait ( 1 );
        ChangeFormation ( 205, 3 );
        Cmd (3, 205, 100, 6991, 5177 );
        QCmd (3, 205, 100, 6168, 2139 );
        QCmd (3, 205, 300, 4772, 3002 );
        break;
    end;
end;
--------------------------FirdWave
function Attack3Ah ()

    while 1 do
        Wait ( 320 ) ;
        LandReinforcementFromMap( 1, "JT3h", 0, 300 );
        Wait ( 1 );
        ChangeFormation ( 300, 3 );
        Cmd (3, 300, 300, 3662, 5235 );
        QCmd (3, 300, 300, 3521, 3477 );
        QCmd (3, 300, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Bh ()

    while 1 do
        Wait ( 320 ) ;
        LandReinforcementFromMap( 1, "JT3h", 1, 301 );
        Wait ( 1 );
        ChangeFormation ( 301, 3 );
        Cmd (3, 301, 300, 4152, 5234 );
        QCmd (3, 301, 300, 4284, 3675 );
        QCmd (3, 301, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Ch ()

    while 1 do
        Wait ( 270 ) ;
        LandReinforcementFromMap( 1, "JT3h", 2, 302 );
        Wait ( 1 );
        ChangeFormation ( 302, 3 );
        Cmd (3, 302, 300, 4706, 5329 );
        QCmd (3, 302, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Dh ()

    while 1 do
        Wait ( 270 ) ;
        LandReinforcementFromMap( 1, "JT3h", 3, 303 );
        Wait ( 1 );
        ChangeFormation ( 303, 3 );
        Cmd (3, 303, 300, 4947, 4863 );
        QCmd (3, 303, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Fh ()

    while 1 do
        Wait ( 350 ) ;
        LandReinforcementFromMap( 1, "JT3h", 4, 304 );
        Wait ( 1 );
        ChangeFormation ( 304, 3 );
        Cmd (3, 304, 100, 6714, 5156 );
        QCmd (3, 304, 100, 5814, 2452 );
        QCmd (3, 304, 300, 4772, 3002 );
        break;
    end;
end;

function Attack3Gh ()

    while 1 do
        Wait ( 350 ) ;
        LandReinforcementFromMap( 1, "JT3h", 5, 305 );
        Wait ( 1 );
        ChangeFormation ( 305, 3 );
        Cmd (3, 305, 100, 6991, 5177 );
        QCmd (3, 305, 100, 6168, 2139 );
        QCmd (3, 305, 300, 4772, 3002 );
        break;
    end;
end;

--------------------------FourthWave
function Attack4Ah ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4h", 0, 400 );
        Wait ( 1 );
        ChangeFormation ( 400, 3 );
        Cmd (3, 400, 300, 3662, 5235 );
        QCmd (3, 400, 300, 3521, 3477 );
        QCmd (3, 400, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Bh ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4h", 1, 401 );
        Wait ( 1 );
        ChangeFormation ( 401, 3 );
        Cmd (3, 401, 300, 4152, 5234 );
        QCmd (3, 401, 300, 4284, 3675 );
        QCmd (3, 401, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Ch ()

    while 1 do
        Wait ( 400 ) ;
        LandReinforcementFromMap( 1, "JT4h", 2, 402 );
        Wait ( 1 );
        ChangeFormation ( 402, 3 );
        Cmd (3, 402, 300, 4706, 5329 );
        QCmd (3, 402, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Dh ()

    while 1 do
        Wait ( 400 ) ;
        LandReinforcementFromMap( 1, "JT4h", 3, 403 );
        Wait ( 1 );
        ChangeFormation ( 403, 3 );
        Cmd (3, 403, 300, 4947, 4863 );
        QCmd (3, 403, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Fh ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4h", 4, 404 );
        Wait ( 1 );
        ChangeFormation ( 404, 3 );
        Cmd (3, 404, 100, 6714, 5156 );
        QCmd (3, 404, 100, 5814, 2452 );
        QCmd (3, 404, 300, 4772, 3002 );
        break;
    end;
end;

function Attack4Gh ()

    while 1 do
        Wait ( 450 ) ;
        LandReinforcementFromMap( 1, "JT4h", 5, 405 );
        Wait ( 1 );
        ChangeFormation ( 405, 3 );
        Cmd (3, 405, 100, 6991, 5177 );
        QCmd (3, 405, 100, 6168, 2139 );
        QCmd (3, 405, 300, 4772, 3002 );
        break;
    end;
end;
------------------------------------5 Wave
function Attack5Ah ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4h", 0, 500 );
        Wait ( 1 );
        ChangeFormation ( 500, 3 );
        Cmd (3, 500, 300, 3662, 5235 );
        QCmd (3, 500, 300, 3521, 3477 );
        QCmd (3, 500, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Bh ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4h", 1, 501 );
        Wait ( 1 );
        ChangeFormation ( 501, 3 );
        Cmd (3, 501, 300, 4152, 5234 );
        QCmd (3, 501, 300, 4284, 3675 );
        QCmd (3, 501, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Ch ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4h", 2, 502 );
        Wait ( 1 );
        ChangeFormation ( 502, 3 );
        Cmd (3, 502, 300, 4706, 5329 );
        QCmd (3, 502, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Dh ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4h", 3, 503 );
        Wait ( 1 );
        ChangeFormation ( 503, 3 );
        Cmd (3, 503, 300, 4947, 4863 );
        QCmd (3, 503, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Fh ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4h", 4, 504 );
        Wait ( 1 );
        ChangeFormation ( 504, 3 );
        Cmd (3, 504, 100, 6714, 5156 );
        QCmd (3, 504, 100, 5814, 2452 );
        QCmd (3, 504, 300, 4772, 3002 );
        break;
    end;
end;

function Attack5Gh ()

    while 1 do
        Wait ( 500 ) ;
        LandReinforcementFromMap( 1, "JT4h", 5, 505 );
        Wait ( 1 );
        ChangeFormation ( 505, 3 );
        Cmd (3, 505, 100, 6991, 5177 );
        QCmd (3, 505, 100, 6168, 2139 );
        QCmd (3, 505, 300, 4772, 3002 );
        break;
    end;
end
----------------------------------------Flang attack
function AttackA ()

    while 1 do
        Wait ( 1 ) ;
        LandReinforcementFromMap( 1, "J2A", 6, 111 );
        Wait ( 1 );
        ChangeFormation ( 111, 3 );
        Cmd (3, 111, 100, 1123, 5605);
        QCmd (3, 111, 100, 4418, 4218);
        QCmd (3, 111, 300, 4772, 3002);
        break;
    end;
end;

function AttackB ()

    while 1 do
        Wait ( 125 ) ;
        LandReinforcementFromMap( 1, "J2A", 6, 222 );
        Wait ( 1 );
        ChangeFormation ( 222, 3 );
        Cmd (3, 222, 100, 1123, 5605);
        QCmd (3, 222, 100, 4418, 4218);
        QCmd (3, 222, 300, 4772, 3002);
        break;
    end;
end;

function AttackC ()

    while 1 do
        Wait ( 250 ) ;
        LandReinforcementFromMap( 1, "J2A", 6, 333 );
        Wait ( 1 );
        ChangeFormation ( 333, 3 );
        Cmd (3, 333, 100, 1123, 5605);
        QCmd (3, 333, 100, 4418, 4218);
        QCmd (3, 333, 300, 4772, 3002);
        break;
    end;
end;
------------------------------Ship
function Boat1 ()
 
   while 1 do
       Wait (5)
       LandReinforcementFromMap( 1, "J3", 7, 900);
       Wait (1);
       Cmd ( 0, 900, 50, 3893, 1850 );
       QCmd ( 0, 900, 50, 158, 174 );
       QCmd (ACT_DISAPPEAR, 900);
       break;
    end;
end;

function Boat2 ()
 
   while 1 do
       Wait (90)
       LandReinforcementFromMap( 1, "J3", 7, 901);
       Wait (1);
       Cmd ( 0, 901, 50, 3893, 1850 );
       QCmd ( 0, 901, 50, 158, 174 );
       QCmd (ACT_DISAPPEAR, 901);
       break;
    end;
end;

function Boat3 ()
 
   while 1 do
       Wait (500)
       LandReinforcementFromMap( 1, "J3", 7, 902);
       y1 = y1+1
       Wait (1);
       Cmd ( 0, 902, 50, 3893, 1850 );
       QCmd ( 0, 902, 50, 158, 174 );
       QCmd (ACT_DISAPPEAR, 902);
       break;
    end;
end;

function Unload1 ()

   while 1 do
       Wait (1)
       if GetNScriptUnitsInArea ( 900, "Boat", 0 ) > 0 then
       Wait (6);
         LandReinforcementFromMap ( 1,"J4", 8, 910 );
         ChangeFormation ( 910, 3 );
         Cmd (3, 910, 500, 4772, 3002 );
         break;
        end;
    end;
end; 

function Unload2 ()

   while 1 do
       Wait (1)
       if GetNScriptUnitsInArea ( 901, "Boat", 0 ) > 0 then
       Wait (6);
         LandReinforcementFromMap ( 1," J4", 8, 911 );
         ChangeFormation ( 911, 3 );
         Cmd (3, 911, 500, 4772, 3002 );
         break;
        end;
    end;
end;

function Unload3 ()

   while 1 do
       Wait (1)
       if GetNScriptUnitsInArea ( 902, "Boat", 0 ) > 0 then
       Wait (6);
         LandReinforcementFromMap ( 1, "J4", 8, 912 );
         ChangeFormation ( 912, 3 );
         Cmd (3, 912, 500, 4772, 3002 );
         break;
        end;
    end;
end;  

-------------------------------Officer
function Officer ()
   
while 1 do
      Wait (1)
        if (GetNUnitsInArea ( 1, "Village", 0 ) > 0) then
         Cmd (ACT_LOAD, 777, 888);
         Wait (3)
         Cmd (0, 888, 50, 4767, 4743);
         QCmd (0, 888, 50, 5938, 4184);
         QCmd (0, 888, 50, 7529, 2941);
         QCmd (0, 888, 50, 6812, 47);
         QCmd (ACT_DISAPPEAR, 888);
         break;
        end;
    end;
end;
------------------------------Recon
function Recon ()

while 1 do
      Wait (1)
      LandReinforcementFromMap (2, "Recon", 0, 977 )
      Cmd (0, 977, 100, 5458, 6528)
      QCmd (0, 977, 100, 1829, 7171)
      QCmd (0, 977, 100, 5458, 6528)
      QCmd (0, 977, 100, 1829, 7171)
      QCmd (0, 977, 100, 5458, 6528)
      QCmd (0, 977, 100, 1829, 7171)
      QCmd (0, 977, 100, 5458, 6528)
      QCmd (0, 977, 100, 1829, 7171)
      QCmd (0, 977, 100, 8014, 196)
      QCmd (ACT_DISAPPEAR, 977);
      break;
    end;
end;


function TheEnd ()

while 1 do 
      Wait (1)
       if y1 == 1 then
          Cmd (3, 100, 300, 7321, 3314);
          Cmd (3, 101, 300, 7321, 3314);
          Cmd (3, 102, 300, 7321, 3314);
          Cmd (3, 103, 300, 7321, 3314);
          Cmd (3, 104, 300, 7321, 3314);
          Cmd (3, 105, 300, 7321, 3314);
          Cmd (3, 200, 300, 7321, 3314);
          Cmd (3, 201, 300, 7321, 3314);
          Cmd (3, 202, 300, 7321, 3314);
          Cmd (3, 203, 300, 7321, 3314);
          Cmd (3, 204, 300, 7321, 3314);
          Cmd (3, 205, 300, 7321, 3314);
          Cmd (3, 300, 300, 7321, 3314);
          Cmd (3, 301, 300, 7321, 3314);
          Cmd (3, 302, 300, 7321, 3314);
          Cmd (3, 303, 300, 7321, 3314);
          Cmd (3, 304, 300, 7321, 3314);
          Cmd (3, 305, 300, 7321, 3314);
          Cmd (3, 111, 300, 7321, 3314);
          Cmd (3, 222, 300, 7321, 3314);
          Cmd (3, 333, 300, 7321, 3314);
          Cmd (3, 400, 300, 7321, 3314);
          break;
        end;
    end;
end;
 
-------------------------------Run functions
GiveObjective (0); 
StartThread( Caput );
StartThread( Victory );
StartThread ( Repair );
StartThread( Boat1 );
--StartThread( Boat2 );
StartThread( Boat3 );
StartThread( Unload1 );
--StartThread( Unload2 );
StartThread( Unload3 );
StartThread( Officer );
StartThread( TheEnd );
StartThread( DifficuiltyEasy );
StartThread( DifficuiltyNormal );
StartThread( DifficuiltyHard );
StartThread( AttackA );
StartThread( AttackB );
StartThread( AttackC );
StartThread( Recon );