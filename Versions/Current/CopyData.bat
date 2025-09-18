@echo off
echo Copying All Updated Files...
cd /D YOUR_VERSIONS_PATH\current\data
xcopy .\*.* YOUR_GAME_PATH\data\*.* /D /E /Y /R /C
echo Updating database...
cd /D YOUR_GAME_PATH\bin
rem DBConvertor.exe -bin

