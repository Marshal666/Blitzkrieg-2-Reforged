cd ..
echo Getting latest tools...
xcopy /D /Y "N:\Dev\Soft\Utils\ArchCopiesToLocal\*.*" ".\arch\"

echo Checking code, step 1 of 5: arx with code synchronization tool
arch\ArxWithCodeSync.exe arch\Directories.txt NPC >> issues.tmp
arch\PrintOnlyDifference arch\IgnoreOldProblems.txt issues.tmp
del issues.tmp
echo .

echo Checking code, step 2 of 5: performing massive find in files using FinderGrep
arch\FinderGrep arch\Directories.txt arch\regexplist.txt arch\filelist >> issues.tmp

echo Checking code, step 3 of 5: testing with "fixvcproj -includes"
echo [ SECTION ] Fixvcproj -includes : searching for #include statements without project dependency >> issues.tmp
arch\fixvcproj.exe -includes >> issues.tmp

echo Checking code, step 4 of 5: testing with serialization checker
echo [ SECTION ] Serialization checker: searching for problems with Nival serialization engine and other common errors >> issues.tmp
arch\SerializationChecker arch\Directories.txt >> issues.tmp 

echo Checking code, step 5 of 5: searching duplicated code
echo [ SECTION ] Duplicated code >> issues.tmp
arch\sed "-farch\tool2out.sed" issues.tmp >> finalissues.tmp
del issues.tmp
arch\DirectoriesToExtensionsMultiplier arch\Directories.txt arch\filelist dirfilelist.txt
arch\simian.exe "-config=dirfilelist.txt" >> junk.tmp
del dirfilelist.txt
arch\sed "-farch\simian.sed" issues.tmp >> finalissues.tmp
del junk.tmp
del issues.tmp

echo If some problems listed below are not real problems, add these output lines to txt file mentioned in the next line
arch\PrintOnlyDifference arch\IgnoreOldProblems.txt finalissues.tmp
echo Checking complete.
echo .

del finalissues.tmp
