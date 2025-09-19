@echo off
if exist ..\Difference.txt del ..\Difference.txt
if exist ..\Errors.txt del ..\Errors.txt
fsum ..\ /T:R /V /C:..\Difference.txt /E:..\Errors.txt /R
if exist ..\Difference.txt goto Error
:start
game.exe
goto end
:Error
echo "MEGAERROR!! Files are corrupted!! Call Stas!"
:end

