@echo off
echo Copying All Updated Files...
cd /D YOUR_VERSIONS_PATH\current
xcopy .\*.* YOUR_GAME_PATH\*.* /D /E /Y /R /C /EXCLUDE:copyfiles-exclude.txt
echo Updating database...
cd /D YOUR_GAME_PATH\bin
rem DBConvertor.exe -bin-main
