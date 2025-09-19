@echo off
copy %1\AILogic\%2\*.dll	c:\b2\%2\*.*
copy %1\GameX\%2\*.dll		c:\b2\%2\*.*
copy %1\Main\%2\*.dll		c:\b2\%2\*.*
copy %1\Image\%2\*.dll		c:\b2\%2\*.*
copy %1\Input\%2\*.dll		c:\b2\%2\*.*
copy %1\3Dmotor\%2\*.dll	c:\b2\%2\*.*
copy %1\Memory\%2\*.dll		c:\b2\%2\*.*
copy %1\SceneB2\%2\*.dll	c:\b2\%2\*.*
copy %1\Script\%2\*.dll		c:\b2\%2\*.*
copy %1\Sound\%2\*.dll		c:\b2\%2\*.*
copy %1\System\%2\*.dll		c:\b2\%2\*.*
copy %1\UI\%2\*.dll			c:\b2\%2\*.*

copy %1\Game\%2\*.exe			c:\b2\%2\*.*
copy %1\MapEditor\%2\*.exe		c:\b2\%2\*.*
copy %1\DBConvertor\%2\*.exe	c:\b2\%2\*.*
echo Done.
