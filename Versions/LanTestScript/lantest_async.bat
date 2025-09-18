cd /d c:\your_game_path
xcopy profiles\Player\Saves\*.* YOUR_TEMP_PATH\LanTest\*.* /D /E /Y /R /C 
lantest_async.vbs
echo Async! >> games.info
date /T >> games.info
time /T >> games.info

