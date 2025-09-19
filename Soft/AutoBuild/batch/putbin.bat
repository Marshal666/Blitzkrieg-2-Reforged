rem call J:\Soft\copydll_manual_c.bat betarelease
cd /D %1
if not exist %2 mkdir %2
copy *.dll %2\*.*
copy *.pdb %2\*.*
copy *.exe %2\*.*
cd /D c:\home\b2