@echo off
if exist ..\Difference.txt del ..\Difference.txt
if exist ..\Errors.txt del ..\Errors.txt
if exist ..\.md5 del ..\.md5
fsum ..\ /R /T:R