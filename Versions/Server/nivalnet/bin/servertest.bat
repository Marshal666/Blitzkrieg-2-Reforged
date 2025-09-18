cd /D c:\nivalnet\bin
if exist server_is_down goto restart
cd /D c:\nivalnet2\bin
if exist server_is_down goto restart

pskill.exe testclient.exe
cd /D c:\nivalnet\bin
start testclient.exe
cd /D c:\nivalnet2\bin
start testclient.exe
goto end

:restart
del c:\nivalnet\bin\server_is_down
del c:\nivalnet2\bin\server_is_down
start c:\nivalnet\bin\start.bat
goto end

:end
exit
