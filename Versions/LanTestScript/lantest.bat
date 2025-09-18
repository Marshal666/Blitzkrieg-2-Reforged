cd /d c:\your_game_path
rd /q /s bin
rd /q /s data
rd /q /s profiles
xcopy YOUR_SOURCE_PATH\versions\multiplayer\*.* .\*.* /D /E /Y /R /C 

del profiles\game.cfg
copy game.lantest profiles\game.cfg
del profiles\default_profile\user.cfg
copy user.lantest profiles\default_profile\user.cfg

echo Game started >> games.info
date /T >> games.info
time /T >> games.info

cd bin
game.exe
