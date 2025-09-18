@echo off
cd /D YOUR_VERSIONS_PATH\current
call cf_internal_main.bat
if exist YOUR_GAME_PATH\copyfiles_main.bat del YOUR_GAME_PATH\copyfiles_main.bat
rundll32.exe user32.dll MessageBeep 0
pause
