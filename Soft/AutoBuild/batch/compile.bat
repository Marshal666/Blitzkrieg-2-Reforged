if exist c:\home\b2\me_log.txt del c:\home\b2\me_log.txt
if exist c:\home\b2\dbc_log.txt del c:\home\b2\dbc_log.txt
if exist c:\home\b2\game_log.txt del c:\home\b2\game_log.txt
"C:\Program Files\Microsoft Visual Studio .NET 2003\Common7\IDE\devenv" /out "c:\home\b2\me_log.txt" /build "B2_MapEditor BetaRelease" "c:\home\b2\npc.sln"
"C:\Program Files\Microsoft Visual Studio .NET 2003\Common7\IDE\devenv" /out "c:\home\b2\dbc_log.txt" /build "DBConvertor BetaRelease" "c:\home\b2\npc.sln"
"C:\Program Files\Microsoft Visual Studio .NET 2003\Common7\IDE\devenv" /out "c:\home\b2\game_log.txt" /build "Game BetaRelease" "c:\home\b2\npc.sln"
