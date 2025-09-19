@echo off
echo Copying All Updated Files...
cd /D J:\Versions\Temporary\ManualBuild
xcopy .\*.* c:\b2\*.* /D /E /Y /R /C
