@echo off
cd /D YOUR_VERSIONS_PATH\Current
call cf_internal.bat
rundll32.exe user32.dll MessageBeep 0
pause
