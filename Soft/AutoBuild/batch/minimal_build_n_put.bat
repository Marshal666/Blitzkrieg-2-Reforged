echo off

call minimal_build.bat

checkbuilderror me_log.txt
GOTO a%ERRORLEVEL%
:a0
checkbuilderror dbc_log.txt
GOTO b%ERRORLEVEL%
:b0
checkbuilderror game_log.txt
GOTO c%ERRORLEVEL%

:c0
echo OK
call put_manual.bat
call J:\Soft\AutoBuild\ManualBuildOK.bat
goto end

:a1
:b1
:c1
echo Compilation error.
call J:\Soft\AutoBuild\ManualBuildFailed.bat 
goto end

:end
