@echo off
cd /D [BUILD_PATH]\Versions\Current
rem xcopy .\*.* c:\b2\*.* /D /E /Y /R /C /EXCLUDE:copyfiles-exclude.txt
rem svn co [INTERNAL_SVN_SERVER]/b2data/trunk [LOCAL_PATH]/Data
cd /D [LOCAL_PATH]