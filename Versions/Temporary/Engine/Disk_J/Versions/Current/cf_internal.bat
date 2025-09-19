@echo off
echo Updating...
cd /D J:\Versions\Current
call delete_old.bat
xcopy .\*.* C:\B2\*.* /D /E /Y /R /C /EXCLUDE:copyfiles-exclude.txt
rem echo Updating version from SVN...
rem svn update C:/B2/Data
cd /D C:\B2