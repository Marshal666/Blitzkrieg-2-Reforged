@echo off
cd /D YOUR_VERSIONS_PATH\Current
rem xcopy .\*.* YOUR_GAME_PATH\*.* /D /E /Y /R /C /EXCLUDE:copyfiles-exclude.txt
rem svn co YOUR_SVN_SERVER/svn/gamedata/trunk C:/YOUR_GAME_PATH/Data
cd /D YOUR_GAME_PATH