echo off

call rebuild.bat

checkbuilderror me_log.txt
GOTO a%ERRORLEVEL%
:a0
checkbuilderror dbc_log.txt
GOTO b%ERRORLEVEL%
:b0
checkbuilderror game_log.txt
GOTO c%ERRORLEVEL%

:c0
echo OK, put all files on j:\versions\dailybuild\bin
call put_daily.bat
call J:\Soft\AutoBuild\DailyBuildOK.bat 

goto end

:a1
:b1
:c1
echo Compilation error. will not put these files.
call J:\Soft\AutoBuild\DailyBuildFailed.bat 
goto end

:end
