@echo off
echo Copying All Updated Files...
cd /D j:\versions\current\data
xcopy .\*.* c:\b2\data\*.* /D /E /Y /R /C
echo Updating database...
cd /D c:\b2\bin
DBConvertor.exe -bin
xcopy c:\b2\profiles\game.cfg c:\b2\editor\game.cfg.backup /I /Y /C
xcopy c:\b2\editor\game.cfg.new c:\b2\profiles\game.cfg /I /Y /C 
game.exe
xcopy c:\b2\editor\game.cfg.backup c:\b2\profiles\game.cfg /I /Y /C
