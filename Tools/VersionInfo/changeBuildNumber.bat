copy j:\tools\VersionInfo\incversion.exe incversion.exe

"C:\Program Files\VSS\win32\SS.EXE" checkout $/B2/Game/VersionInfo.h -R -I-
pause
incversion.exe VersionInfo.h 
"C:\Program Files\VSS\win32\SS.EXE" checkin $/B2/Game/VersionInfo.h -R -I-

attrib -r VersionInfo.h
attrib -r vssver.scc
del VersionInfo.h
del vssver.scc