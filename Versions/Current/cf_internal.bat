@echo off
echo Updating...
cd /D YOUR_VERSIONS_PATH\Current
call delete_old.bat
xcopy .\*.* YOUR_GAME_PATH\*.* /D /E /Y /R /C /EXCLUDE:copyfiles-exclude.txt
rem echo Updating version from SVN...
rem svn update YOUR_GAME_PATH/Data
cd /D YOUR_GAME_PATH