-- returns array of arguments
function GetArray( ... )
	return arg;
end;

function StartCycled( func, p1, p2, p3 )
	proto = function( )
	while 1 do
		Wait( 1 );
		if ( %func( %p1, %p2, %p3 ) ~= nil ) then 
			break;
		end;
	end;
	end;
	StartThread( proto );
end;

-- returns array1 + array2
function ConcatArray( array1, array2 )
local cnt;
local num = array1.n;
local arr = {};

	if ( num == nil ) then 
		num = 0;
	end;
	
	if ( num > 0 ) then
		for cnt = 1, num do
			arr[cnt] = array1[cnt];
		end;
		--arr.n = array1.n;
	end;
	arr.n = num;
	
	if ( array2 == nil ) or ( array2.n == 0 ) then
		return arr;
	end;

	for cnt = 1, array2.n do
		arr[cnt + num] = array2[cnt];
	end;
	
	arr.n = num + array2.n;
	return arr;
end;

-- delete all array elements that equals <element>
function DeleteElement( array, element )
local newarray = { n = 0 };
local j = 0;
	for i = 1, array.n do
		if ( array[i] ~= element ) then
			j = j + 1;
			newarray[j] = array[i];
		end;
	end;
	newarray.n = j;
	return newarray;
end;

-- Returns array of unit list in area
function GetUnitListInAreaArray( Player, ... )
local array = {};
local Area, bPlanes, x, y, r;
local use_area = 1;
	if ( arg.n >= 1 ) and ( arg.n <= 2 ) then
		Area = arg[ 1 ];
	end;
	if ( arg.n == 2 ) then
		bPlanes = arg[ 2 ];
	end;
	if ( arg.n >= 3 ) then
		x = arg[ 1 ];
		y = arg[ 2 ];
		r = arg[ 3 ];
		use_area = 0;
	end;
	if ( arg.n == 4 ) then
		bPlanes = arg[ 4 ];
	end;
	if ( bPlanes == nil ) then
		bPlanes = 1;
	end;
	if ( use_area == 1 ) then
		array = GetArray( GetUnitListInArea( Player, Area, bPlanes ) );
	else
		array = GetArray( GetUnitListInArea( Player, x, y, r, bPlanes ) );
	end;
	return array;
end;

-- Returns array of unit list in area
function GetUnitListOfPlayerArray( Player )
local array = {};
	array = GetArray( GetUnitListOfPlayer( Player ) );
	return array;
end;

-- Returns array of object list
function GetObjectListArray( ScriptID )
local array = {};
	array = GetArray( GetObjectList( ScriptID ) );
	return array;
end;

-- Returns array of passangers list
function GetPassangersArray( UniqueID, Player )
local array = {};
	array = GetArray( GetPassangers( UniqueID, Player ) );
	return array;
end;

-- Random [1, N ]
function Random( N )
local rnd = RandomInt( N ) + 1;
	return rnd;
end;

-- Wait for N seconds
function Wait( N )
	Sleep( N * 20 );
end;

function GetUnitListFromGroups( startId, endId )
local i;
local units = {};
local arr = {};
	for i = startId, endId do
		arr = GetObjectListArray( i );
		units = ConcatArray( units, arr );
	end;
	return units;
end;

-- Return true if Action uses coordinates
function UsesCoordinates( iAction )
	if ( ( iAction == ACT_MOVE ) or ( iAction == ACT_SWARM ) or ( iAction == ACT_ROTATE ) or ( iAction == ACT_ZEROING ) or 
		( iAction == ACT_SUPPRESS ) or ( iAction == ACT_RESUPPLY ) or ( iAction == ACT_REPAIR ) or ( iAction == ACT_SPYGLASS ) or
		( iAction == ACT_UNLOAD ) or ( iAction == ACT_LEAVE ) or ( iAction == ACT_DEPLOY ) ) then
		return 1;
	end;
end;

-- meta function, used to pass scriptarea names to Cmd and QCmd functions
function cmd_meta( cmdfunc )
return function ( iAction, Id, ... )
	if ( arg.n == 0 ) then
		%cmdfunc( iAction, Id );
	elseif ( arg.n == 1 ) then
		%cmdfunc( iAction, Id, arg[1] );
	elseif ( arg.n == 2 ) then
		%cmdfunc( iAction, Id, arg[1], GetScriptAreaParams( arg[2] ) );
	elseif ( arg.n >= 3 ) then
		%cmdfunc( iAction, Id, arg[1], arg[2], arg[3] );
	end;
end;
end;

oldCmd = Cmd;
oldQCmd = QCmd;
oldUnitCmd = UnitCmd;
oldUnitQCmd = UnitQCmd;

Cmd = cmd_meta( oldCmd );
QCmd = cmd_meta( oldQCmd );
UnitCmd = cmd_meta( oldUnitCmd );
UnitQCmd = cmd_meta( oldUnitQCmd );

-- Individual Cmd for units in script group
function CmdMultiple( iAction, ScriptId, ... )
local Units = {};
	Units = GetObjectListArray( ScriptId );
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("CmdMultiple: empty or invalid object array");
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n == 0 ) then
			UnitCmd( iAction, Units[i] );
		elseif ( arg.n == 1 ) then
			UnitCmd( iAction, Units[i], arg[1] );
		elseif ( arg.n >= 2 ) then
			UnitCmd( iAction, Units[i], 0, arg[1], arg[2] );
		end;
	end;
end;

-- Individual Cmd for units in script group with some coordinates dispersion
function CmdMultipleDisp( iAction, ScriptId, iDispersion, ... )
local Units = {};
	if ( UsesCoordinates( iAction ) == 0 ) then
		Trace( "CmdMultipleDisp: invalid action" );
		return 0;
	end;
	if ( arg.n == 0 ) then
		Trace( "CmdMultipleDisp: not enough parameters" );
		return 0;		
	end;
	Units = GetObjectListArray( ScriptId );
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("CmdMultipleDisp: empty or invalid object array");
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n >= 2 ) then
			UnitCmd( iAction, Units[i], iDispersion, arg[1], arg[2] );
		elseif ( arg.n == 1 ) then
			UnitCmd( iAction, Units[i], iDispersion, arg[1] );
		end;
	end;
end;

-- Individual QCmd for units in script group
function QCmdMultiple( iAction, ScriptId, ... )
local Units = {};
	Units = GetObjectListArray( ScriptId );
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("QCmdMultiple: empty or invalid object array"); 
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n == 0 ) then
			UnitQCmd( iAction, Units[i] );
		elseif ( arg.n == 1 ) then
			UnitQCmd( iAction, Units[i], arg[1] );
		elseif ( arg.n >= 2 ) then
			UnitQCmd( iAction, Units[i], 0, arg[1], arg[2] );
		end;
	end;
end;

-- Individual Cmd for units in script group with some coordinates dispersion
function QCmdMultipleDisp( iAction, ScriptId, iDispersion, ... )
local Units = {};
	if ( UsesCoordinates( iAction ) == 0 ) then
		Trace( "QCmdMultipleDisp: invalid action" );
		return 0;
	end;
	if ( arg.n == 0 ) then
		Trace( "QCmdMultipleDisp: not enough parameters" );
		return 0;		
	end;
	Units = GetObjectListArray( ScriptId );
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("QCmdMultipleDisp: empty or invalid script group");
		return 0;
	end;
	for i = 1, Units.n do		if ( arg.n >= 2 ) then
			UnitQCmd( iAction, Units[i], iDispersion, arg[1], arg[2] );
		elseif ( arg.n == 1 ) then
			UnitQCmd( iAction, Units[i], iDispersion, arg[1] );
		end;
	end;
end;

-- Individual Cmd for array of units
function CmdArray( iAction, Units, ... )
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("CmdArray: second parameter is empty or invalid");
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n == 0 ) then
			UnitCmd( iAction, Units[i]);
		elseif ( arg.n == 1 ) then
			UnitCmd( iAction, Units[i], arg[1] );
		elseif ( arg.n >= 2 ) then
			UnitCmd( iAction, Units[i], 0, arg[1], arg[2] );
		end;
	end;
end;

-- Individual Cmd for units array with some coordinates dispersion
function CmdArrayDisp( iAction, Units, iDispersion, ... )
	if ( UsesCoordinates( iAction ) == 0 ) then
		Trace( "CmdArrayDisp: invalid action (action must use coordinates)" );
		return 0;
	end;
	if ( arg.n == 0 ) then
		Trace( "CmdArrayDisp: not enough parameters" );
		return 0;		
	end;
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("CmdArrayDisp: second parameter is empty or invalid");
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n >= 2 ) then
			UnitCmd( iAction, Units[i], iDispersion, arg[1], arg[2] );
		elseif ( arg.n == 1 ) then
			UnitCmd( iAction, Units[i], iDispersion, arg[1] );
		end;
	end;
end;

-- Individual QCmd for units array with some coordinates dispersion
function QCmdArrayDisp( iAction, Units, iDispersion, ... )
	if ( UsesCoordinates( iAction ) == 0 ) then
		Trace( "QCmdArrayDisp: invalid action (action must use coordinates)" );
		return 0;
	end;
	if ( arg.n == 0 ) then
		Trace( "QCmdArrayDisp: not enough parameters" );
		return 0;		
	end;
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("QCmdArrayDisp: second parameter is empty or invalid");
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n >= 2 ) then
			UnitCmd( iAction, Units[i], iDispersion, arg[1], arg[2] );
		elseif ( arg.n == 1 ) then
			UnitCmd( iAction, Units[i], iDispersion, arg[1] );
		end;
	end;
end;

-- Individual QCmd for array of units
function QCmdArray( iAction, Units, ... )
	if ( ( Units == nil ) or ( Units.n == 0 ) ) then
		Trace("QCmdArray: second parameter is empty or invalid");
		return 0;
	end;
	for i = 1, Units.n do
		if ( arg.n == 0 ) then
			UnitQCmd( iAction, Units[i]);
		elseif ( arg.n == 1 ) then
			UnitQCmd( iAction, Units[i], arg[1] );
		elseif ( arg.n >= 2 ) then
			UnitQCmd( iAction, Units[i], 0, arg[1], arg[2] );
		end;
	end;
end;

-- Returns number of specified player units in area of object or unit in radius
function GetNUnitsNearObj( iPlayer, UniqueId, iRadius )
local x, y = ObjectGetCoord( UniqueId );
local n = GetNUnitsInCircle( iPlayer, x, y, iRadius );
	return n;
end;

-- returns number of player units in radius of all array objects; !!!comment: this function also counts duplicates!!!
function GetNUnitsNearArray( iPlayer, array, iRadius )
local cnt = 0;
	if ( ( array == nil ) or ( array.n == 0 ) ) then
		Trace("GetNUnitsNearArray: second parameter is empty or invalid");
		return 0;
	end;
	for i = 1, array.n do
		if ( IsAlive( array[i] ) > 0 ) then
			cnt = cnt + GetNUnitsNearObj( iPlayer, array[i], iRadius );
		end;
	end;
	return cnt;
end;

-- Returns number of specified player units in area of script object or unit in radius
function GetNUnitsNearScriptObj( iPlayer, ScriptId, iRadius )
local ObjId = GetObjectList( ScriptId );
local x, y =  ObjectGetCoord( ObjId );
local n = GetNUnitsInCircle( iPlayer, x, y, iRadius );
	return n;
end;

-- Returns number of specified player units in area of script object or unit in radius
function GetNScriptUnitsNearScriptObj( ScriptId1, ScriptId2, iRadius )
local UnitList = {};
	UnitList = GetObjectListArray( ScriptId1 );
local ObjId = GetObjectList( ScriptId2 );
local x1, y1 = ObjectGetCoord( ObjId );
local l;
local x2, y2;
local cnt = 0;
	for i = 1, UnitList.n do
		if ( IsAlive( UnitList[i] ) > 0 ) then
			x2, y2 = ObjectGetCoord( UnitList[i] );
			l = len( x1 - x2, y1 - y2 );
			if ( l < iRadius ) then
				cnt = cnt + 1;
			end;
		end;
	end;
	return cnt;
end;

-- returns distance between two units
function Dist( unit1, unit2 )
local x1, x2, y1, y2, l;
	x1,y1 = ObjectGetCoord( unit1 );
	x2,y2 = ObjectGetCoord( unit2 );
	l = len( x1 - x2, y1 - y2 );
	return l;
end;

-- damages all objects in script group
function DamageScriptObject( ScriptId, iDam )
local Objects = {};
	if ( iDam == nil ) then
		Trace("DamageScriptObject: second parameter is invalid");
		return 0;
	end;
	Objects = GetObjectListArray( ScriptId );
	for i = 1, Objects.n do
		DamageObject( Objects[i], iDam );
	end;	
end;

-- damage all objects in object array
function DamageObjectArray( Objects, iDam )
	if ( ( Objects == nil ) or ( Objects.n == nil ) or ( Objects.n == 0 ) ) then
		Trace("DamageObjectArray: first parameter is empty or invalid");
		return 0;
	end;
	if ( iDam == nil ) then
		Trace("DamageObjectArray: second parameter is invalid");
		return 0;
	end;
	for i = 1, Objects.n do
		DamageObject( Objects[i], iDam );
	end;	
end;

-- changes player for all objects in script group
function ChangePlayerForScriptGroup( ScriptId, iPlayer )
local Objects = {};
	if ( iPlayer == nil ) then
		Trace("ChangePlayerForScriptGroup: second parameter is invalid");
		return 0;
	end;
	Objects = GetObjectListArray( ScriptId );
	for i = 1, Objects.n do
		if ( IsAlive( Objects[i] ) == 1 ) then
			ChangePlayer( Objects[i], iPlayer );
		end;
	end;	
end;

-- changes player for all objects in array 
function ChangePlayerForArray( Objects, iPlayer )
	if ( ( Objects == nil ) or ( Objects.n == nil ) or ( Objects.n == 0 ) ) then
		Trace("ChangePlayerForArray: first parameter is empty or invalid");
		return 0;
	end;
	if ( iPlayer == nil ) then
		Trace("ChangePlayerForArray: second parameter is invalid");
		return 0;
	end;
	for i = 1, Objects.n do
		if ( IsAlive( Objects[i] ) == 1 ) then
			ChangePlayer( Objects[i], iPlayer );
		end;
	end;	
end;

-- returns HP for the first object in script group (for single script groups)
function GetScriptObjectHPs( ScriptId )
local Objects = {};
local HP;
	Objects = GetObjectListArray( ScriptId );
	if ( ( Objects == nil ) or ( Objects.n == 0) ) then
		Trace("GetScriptObjectHPs: script group is empty or not exists");
		return 0;
	end;
	HP = GetObjectHPs( Objects[1] );
	return HP;
end;

-- returns array of HPs of objects array
function GetObjectArrayHPs( Objects )
local HPs = {};
	if ( ( Objects == nil ) or ( Objects.n == 0) ) then
		Trace("GetObjectArrayHPs: first parameter is empty or invalid");
		return 0;
	end;
	HPs.n = Objects.n;
	for i = 1, Objects.n do
		HPs[i] = GetObjectHPs( Objects[i] );
	end;
	return HPs;
end;

--returns return n units of HP>0
function NumUnitsAliveInArray( array ) 
	local tmp_array = {};
	local n = 0;
		tmp_array.n = array.n;
		tmp_array = array;
	for i = 1, tmp_array.n do
		if ( IsAlive( tmp_array[i] ) > 0 ) then
			n = n + 1;
		end;
	end;

	if ( n > tmp_array.n ) then
		Trace("Error in NumUnitsAliveInArray n>tmp_array.n");
	end;

--	Trace("result_n%g",n);
	return n;
end;

function GetNUnitsInArray( array )
local n = 0;
	if ( array.n == nil ) then
		Trace( "GetNUnitsInArray: parameter is invalid" );
	end;
	for i = 1, array.n do
		if ( IsAlive( array[i] ) > 0 ) then
			n = n + 1;
		end;
	end;
	return n;
end;

-- returns array of HPs of script group
function GetScriptObjectHPsArray( ScriptId )
local Objects = {};
local HPs = {};
	Objects = GetObjectListArray( ScriptId );
	if ( ( Objects == nil ) or ( Objects.n == 0) ) then
		Trace("GetScriptObjectHPsArray: script group is empty or not exists");
		return 0;
	end;
	HPs.n = Objects.n;
	for i = 1, Objects.n do
		HPs[i] = GetObjectHPs( Objects[i] );
	end;
	return HPs;
end;

-- Removes all units in script group from map
function RemoveScriptGroup( ScriptId )
local Units = {};
	Units = GetObjectListArray( ScriptId );
	for i = 1, Units.n do
		UnitRemove( Units[i] );
	end;
end;

-- Removes all array units from map
function RemoveArray( array )
--local Units = {};
	--Units = GetObjectListArray( ScriptId );
	for i = 1, array.n do
		UnitRemove( array[i] );
	end;
end;

-- Returns coords of single script object
function GetScriptObjCoord( ScriptId )
local ObjId = GetObjectList( ScriptId );
local x, y =  ObjectGetCoord( ObjId );
	return x, y;
end;

-- Returns array of script objects coords
function GetScriptObjCoordArray( ScriptId )
local Objs = {};
local coords = {};
	Objs = GetObjectListArray( ScriptId );
	for i = 1, Objs.n do
		coords[i].x, coords[i].y =  ObjectGetCoord( Objs[i] );
	end;
	coords.n = Objs.n;
	return coords;
end;

-- Returns array of array objects coords
function GetArrayObjCoordArray( array )
local coords = {n = 0};
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "GetArrayObjCoordArray: parameter is invalid or empty" );
		return coords;
	end;
	for i = 1, array.n do
		coords[i] = {x = 0, y = 0};
		coords[i].x, coords[i].y = ObjectGetCoord( array[i] );
	end;
	coords.n = array.n;
	return coords;
end;

-- Returns medium coord of script objects
function GetScriptObjCoordMedium( ScriptId )
local Objs = {};
local mx, my = 0, 0;
local cnt_ = 0;
local x, y;
	Objs = GetObjectListArray( ScriptId );
	for i = 1, Objs.n do
		if ( IsAlive( Objs[i] ) > 0 ) then
			x, y =  ObjectGetCoord( Objs[i] );
			mx = mx + x;
			my = my + y;
			cnt_ = cnt_ + 1;
		end;
	end;
	if ( cnt_ > 0 ) then
		mx = mx / cnt_;
		my = my / cnt_;
	end;
	return mx, my;
end;

-- Returns medium coord of array objects
function GetObjCoordMedium( array )
local mx, my = 0, 0;
local cnt_ = 0;
local x, y;
	if ( ( array == nil ) or ( array.n == 0 ) ) then
		Trace( "GetObjCoordMedium: parameter is invalid or empty" );
		return 0;
	end;
	for i = 1, array.n do
		if ( IsAlive( array[i] ) > 0 ) then
			x, y =  ObjectGetCoord( array[i] );
			mx = mx + x;
			my = my + y;
			cnt_ = cnt_ + 1;
		end;
	end;
	if ( cnt_ > 0 ) then
		mx = mx / cnt_;
		my = my / cnt_;
	end;
	return mx, my;
end;

oldIsUnitInArea = IsUnitInArea;

function IsUnitInArea( player, ... )
	if ( arg.n == 2 ) then
		x, y, r = GetScriptAreaParams( arg[1] );
		res = oldIsUnitInArea( player, x, y, r, arg[2] ) or 0;
		return res;
	else
		res = oldIsUnitInArea( player, arg[1], arg[2], arg[3], arg[4] ) or 0;
		return res;
	end;
end;

-- returns number of array units in script area
function GetNArrayUnitsInArea( player, scriptarea, array )
local cnt = 0;
	if ( ( array == nil ) or ( array.n == 0 ) ) then
		Trace( "GetNArrayUnitsInArea: third parameter is invalid or empty" );
		return 0;
	end;
	for i = 1, array.n do
		if ( IsAlive( array[i] ) > 0 ) then
		Trace( "array[i] = %g", array[i] );
		if ( IsUnitInArea( player, scriptarea, array[i] ) == 1 ) then
			cnt = cnt + 1;
		end;
		end;
	end;
	return cnt;
end;

-- returns 1 if object is in circle
function IsObjectInCircle( object, ... )
	if ( IsAlive( object ) > 0 ) then
		local x1, y1 = ObjectGetCoord( object );
		if ( arg.n == 1 ) then
			x, y, radius = GetScriptAreaParams( arg[1] );
		else
			x, y, radius = arg[1], arg[2], arg[3];
		end;
		if ( len( x1 - x, y1 - y) < radius ) then
			return 1;
		end;
	end;
	return 0;
end;

IsObjectInArea = IsObjectInCircle;

function Patrol( unit, iDispersion, ... )
	if ( unit == nil ) then
		Trace( "Patrol: first parameter is invalid" );
		return 0;
	end;
	if ( arg == nil ) or ( arg.n == 0 ) then
		Trace( "Patrol: not enough paramers" );
		return 0;
	end;
	if ( mod( arg.n, 2 ) == 1 ) then
		Trace( "Patrol: coordinates parameters number is odd" );
		return 0;
	end;
	UnitCmd( ACT_PATROL, unit, iDispersion, arg[1], arg[2] );
	if ( arg.n > 2 ) then
		for i = 1, arg.n / 2 do
			UnitQCmd( ACT_PATROL, unit, iDispersion, arg[(i * 2) + 1], arg[(i + 1) * 2] );
		end;
	end;
end;

function PatrolScriptAreas( unit, iDispersion, ... )
	if ( unit == nil ) then
		Trace( "PatrolScriptAreas: first parameter is invalid" );
		return 0;
	end;
	if ( arg == nil ) or ( arg.n == 0 ) then
		Trace( "PatrolScriptAreas: not enough paramers" );
		return 0;
	end;
	UnitCmd( ACT_PATROL, unit, iDispersion, arg[1] );
	if ( arg.n > 1 ) then
		for i = 2, arg.n do
			UnitQCmd( ACT_PATROL, unit, iDispersion, arg[i] );
		end;
	end;
end;

-- returns number of array units in circle
function GetNArrayUnitsInCircle( array, x, y, radius )
local cnt = 0;
	if ( ( array == nil ) or ( array.n == 0 ) ) then
		Trace( "GetNArrayUnitsInCircle: first parameter is invalid or empty" );
		return 0;
	end;
	for i = 1, array.n do
		cnt = cnt + IsObjectInCircle( array[i], x, y, radius );
	end;
	return cnt;
end;

function IsGroupInArea( player, scriptarea, array )
	if ( GetNArrayUnitsInArea( player, scriptarea, array ) == NumUnitsAliveInArray( array ) ) then
		return 1;
	end;
	return 0;
end;

-- wait until all player units in array will reach script area (inside)
function WaitForArrayAtArea( player, scriptarea, array )
	while ( GetNArrayUnitsInArea( player, scriptarea, array ) < NumUnitsAliveInArray( array ) ) do
		Wait( 2 );
	end;
end;

-- wait until all player units in array will reach circle
function WaitForArrayAtPosition( array, x, y, radius )
	while ( GetNArrayUnitsInCircle( array, x, y, radius ) < NumUnitsAliveInArray( array ) ) do
		Wait( 2 );
	end;
end;

-- order an array of units to swarm at scriptobject and attack it on arrival
function ArrayAttackScriptObject( group, scriptid, defendingplayer )
local x, y = GetScriptObjCoord( scriptid );
	CmdArrayDisp( ACT_SWARM, group, 256, x, y );
	WaitForArrayAtPosition( group, x, y, 400 ); -- 256 * sqrt( 2 )
	if ( NumUnitsAliveInArray( group ) > 0 ) then
	CmdArray( ACT_ATTACKOBJECT, group, GetObjectList( scriptid ) );
	while ( ( GetScriptObjectHPs( scriptid ) > 0 ) and ( NumUnitsAliveInArray( group ) > 0 ) ) do
		if ( GetNUnitsNearArray( defendingplayer, group, SIGHTRANGE ) > 0 ) then
		CmdArray( ACT_STOP, group );
			while ( ( GetNUnitsNearArray( defendingplayer, group, SIGHTRANGE ) > 0 ) and ( NumUnitsAliveInArray( group ) > 0 ) ) do
				Wait( 2 );
			end;
		CmdArray( ACT_ATTACKOBJECT, group, GetObjectList( scriptid ) );
		end;
		Wait( 1 );
	end;
	end;
end;

function GetUnitListWithHPs( array, hp )
local list = {};
local k = 0;
	if ( ( array.n == nil ) or ( array.n == 0 ) ) then
		Trace( "GetUnitListWithHPs: first parameter is invalid or empty" );
		return 0;
	end;
	for i = 1, array.n do
		if ( GetObjectHPs( array[i] ) == hp ) then
		k = k + 1;
		list[k] = array[i];
		end;
	end;
	list.n = k;
	return list;
end;

-- old, unused
function LandReinforcement2( nPlayer, nReinfId, nTemplateId, nPoint, ScriptId )
	if ( ScriptId ~= nil ) then
		LandReinforcementAndAssignScriptID( nPlayer, nReinfId, nTemplateId, nPoint, ScriptId );
	else
		LandReinforcement( nPlayer, nReinfId, nTemplateId, nPoint );
	end;
end;

function GetUnitsByParam( array, paramtype, param )
local sorted = {};
local stats = {};
local k = 0;
	sorted.n = 0;
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "GetUnitsByParam: first parameter is invalid or empty" );
		return sorted;
	end;
	if ( paramtype == nil ) then
		Trace( "GetUnitsByParam: second parameter is invalid" );
		return sorted;
	end;
	if ( param == nil ) then
		Trace( "GetUnitsByParam: third parameter is invalid" );
		return sorted;
	end;
	if ( paramtype > 7 ) then
		Trace( "GetUnitsByParam: unknown param type" );
		return sorted;
	end;
	for u = 1, array.n do
		if ( IsAlive( array[u] ) > 0 ) then
			stats = GetArray( GetUnitRPGStats( array[u] ) );
			if ( paramtype == PT_CLASS ) then
				if ( param > 100 ) then
					if ( stats[ PT_TYPE ] == TYPE_INF ) then
						if ( stats[ paramtype ] == ( param - 100 ) ) then
							k = k + 1;
							sorted[k] = array[u];
						end;
					end;
				else
					if ( stats[ PT_TYPE ] == TYPE_MECH ) then
						if ( stats[ paramtype ] == param ) then
							k = k + 1;
							sorted[k] = array[u];
						end;
					end;
				end;
			else
				if ( stats[ paramtype ] == param ) then
					k = k + 1;
					sorted[k] = array[u];
				end;
			end;
		end;
	end;
	sorted.n = k;
	return sorted;
end;

function GetSortedByClassUnits( array )
local sorted = {};
local stats = {};
local k = 0;
local st;
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "GetSortedByParamUnits: parameter is invalid or empty" );
		return sorted;
	end;
	
	for u = 1, 28 do
		sorted[ u ] = { n = 0 };
	end;
	for u = 101, 106 do
		sorted[ u ] = { n = 0 };
	end;
	
	for u = 1, array.n do
		if ( IsAlive( array[u] ) > 0 ) then
			stats = GetArray( GetUnitRPGStats( array[u] ) );
			if ( stats[ PT_TYPE ] == TYPE_INF ) then
				st = stats[ PT_CLASS ] + 100;
			else
				st = stats[ PT_CLASS ];
			end;	
			k = sorted[ st ].n + 1;
			sorted[ st ][ k ] = array[ u ];
			sorted[ st ].n = k;
		end;
	end;
	return sorted;
end;

function GetUnitsByParamScriptId( sid, pt, type )
local units = {};
	units = GetUnitsByParam( GetObjectListArray( sid ), pt, type );
	return units;
end;

function IsUnitType( unit, superclass )
local stats = GetArray( GetUnitRPGStats( unit ) );
	if ( SUPERCLASSES[ stats[ PT_CLASS ] ] == superclass ) then
		return 1;
	else
		return 0;
	end;
end;

function GetUnitArrayStatesArray( array )
local states = {};
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "GetUnitArrayStatesArray: first parameter is invalid or empty" );
		return 0;
	end;
	for u = 1, array.n do
		states[u] = GetUnitState( array[u] );
	end;
	states.n = array.n;
	return states;
end;

function OnlyValues( array1, array2 )
local t;
	for i = 1, array1.n do
		t = 0;
		for j = 1, array2.n do
			if ( array1[i] == array2[j] ) then
				t = 1;
				break;
			end;
		end;
		if ( t == 0 ) then
			return 0;
		end;
	end;
	return 1;
end;

function CountMatchingValues( array1, array2 )
local cnt = 0;
	for i = 1, array1.n do
		for j = 1, array2.n do
			if ( array1[i] == array2[j] ) then
				cnt = cnt + 1;
				break;
			end;
		end;
	end;
	return cnt;
end;

function GetWithoutPassangers( array )
local cnt = 0;
local passanger;
local newarray = {};
	for i = 1, array.n do
		cnt = cnt + 1;
		passanger = GetPassangers( array[i] );
		if ( passanger == nil ) then
			newarray[cnt] = array[i];
		end;
	end;
	newarray.n = cnt;
	return newarray;
end;

function AreAllUnitsInDirection( array, mindir, maxdir, innerarc )
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "AreAllUnitsInDirection: first parameter is invalid or empty" );
		return 0;
	end;
	for u = 1, array.n do
		if ( IsAlive( array[u] ) > 0 ) then
			dir = GetFrontDir( array[u] );
			if ( ( dir > mindir ) and ( dir < maxdir ) ) then
				if ( innerarc ~= 1 ) then
					return 0;
				end;
			else
				if ( innerarc == 1 ) then
					return 0;
				end;
			end;
		end;
	end;
	return 1;
end;

function GetNUnitsInDirection( array, mindir, maxdir, innerarc )
local k = 0;
	if ( array == nil ) or ( array.n == 0 ) then
		Trace( "AreAllUnitsInDirection: first parameter is invalid or empty" );
		return 0;
	end;
	for u = 1, array.n do
		if ( IsAlive( array[u] ) > 0 ) then
			dir = GetFrontDir( array[u] );
			if ( ( dir > mindir ) and ( dir < maxdir ) ) then
				if ( innerarc == 1 ) then
					k = k + 1;
				end;
			else
				if ( innerarc ~= 1 ) then
					k = k + 1;
				end;
			end;
		end;
	end;
	return k;
end;

function GetUnitRPGStatsArray( unit )
local stats = { Type = 0, Id = 0, Class = 0, Price = 0, MaxHP = 0, Weight = 0, TowingForce = 0 };
local rawstats = {};
	rawstats = GetArray( GetUnitRPGStats( unit ) );
	stats.Type = rawstats[1];
	stats.Id = rawstats[2];
	stats.Class = rawstats[3];
	stats.Price = rawstats[4];
	stats.MaxHP = rawstats[5];
	stats.Weight = rawstats[6];
	stats.TowingForce = rawstats[7];
	return stats;
end;

--function GetNUnitsInArea( player, scriptarea )
--local units = {};
--local rpgstats = {};
--local cnt = 0;
--	units = GetUnitListInAreaArray( player, scriptarea );
--	if ( units == nil ) then
--		return 0;
--	end;
--	if ( units.n == 0 ) then
--		return 0;
--	end;
--	for i = 1, units.n do
--		rpgstats = GetUnitRPGStatsArray( units[i] );
--		if ( ( rpgstats.Class ~= CLASS_FIGHTER ) and
--			( rpgstats.Class ~= CLASS_BOMBER ) and
--			( rpgstats.Class ~= CLASS_GROUND_ATTACK ) and
--			( rpgstats.Class ~= CLASS_PARADROPPER )) then
--			cnt = cnt + 1;
--		end;
--	end;
--	return cnt;
--end;

function SetScriptObjectHPs( scriptid, newhp )
local hps = GetScriptObjectHPs( scriptid );
	if ( hps - newhp ~= 0 ) then
		DamageScriptObject( scriptid, hps - newhp );
	end;
end;

function SetObjectHPs( object, newhp )
local hps = GetObjectHPs( object );
	if ( hps - newhp ~= 0 ) then
		DamageObject( object, hps - newhp );
	end;
end;

function WaitForGroupAtArea( ScriptID, scriptarea )
	while ( GetNScriptUnitsInArea( ScriptID, scriptarea, 0 ) < GetNUnitsInScriptGroup( ScriptID ) ) do
		Wait( 2 );
	end;
end;

--function WaitWhileStateArray( array, state )
--local stop = 0;
--	while ( stop == 0 ) do
--		stop = 1;
--		for i = 1, array.n do
--			if ( IsAlive( array[i] ) == 1 ) then
--				if ( GetUnitState( array[i] ) == state ) then--					stop = 0;
--					break;
--				end;
--			end;
--		end;
--		Wait( 1 );
--	end;
--end;

function waitwhile_meta( func )
	return function( array, param )
	local stop = 0;
	while ( stop == 0 ) do
		stop = 1;
		for i = 1, array.n do
			if ( IsAlive( array[i] ) == 1 ) then
				if ( %func( array[i] ) == param ) then					stop = 0;
					break;
				end;
			end;
		end;
		Wait( 1 );
	end;
	end;
end;

WaitWhileStateArray = waitwhile_meta( GetUnitState );
function Unload( id )
	while 1 do
		local unload_inf = {};
		local units = GetObjectListArray( id );
		local attackers = GetUnitsByParam( units, PT_TYPE, TYPE_MECH );
			unload_inf[1], unload_inf[2] = ObjectGetCoord ( attackers[ Random( attackers.n ) ] );
		if GetNUnitsInCircle ( 0,  unload_inf[1], unload_inf[2], 1184 ) > 0 then
			Trace("ours units near attackers = %g",GetNUnitsInCircle ( 0,  unload_inf[1], unload_inf[2], 1184 ));
			for i = 1, attackers.n do
				unload_inf[1], unload_inf[2] = ObjectGetCoord ( attackers[ i ] );
				UnitCmd( ACT_UNLOAD, attackers[ i ], 0, unload_inf[1], unload_inf[2] );
			end;
			return 1;
		end;
		Wait(1);
	end;
end;

-----
function FlagManager( flagsnumber )
local tmpold = {};
local tmp;
	for i = 1, flagsnumber do
	if ( ( GetNUnitsInScriptGroup( i + 500, 0 ) + 
		GetNUnitsInScriptGroup( i + 500, 2 ) ) == 1 ) then
		tmpold[i] = 0;
	elseif ( ( GetNUnitsInScriptGroup( i + 500, 1 ) + 
		GetNUnitsInScriptGroup( i + 500, 3 ) ) == 1 ) then
		tmpold[i] = 1;
	end;
	end;
	while ( 1 ) do
	Wait( 1 );
	for i = 1, flagsnumber do
		if ( GetNUnitsInScriptGroup( i + 500, 0 ) == 1 ) then
			tmp = 0;
		elseif ( GetNUnitsInScriptGroup( i + 500, 1 ) == 1 ) then
			tmp = 1;
		end;
		if ( tmp ~= tmpold[i] ) then
			if ( tmp == 0 ) then
				SetScriptObjectHPs( 700 + i, 50 );
			else
				SetScriptObjectHPs( 700 + i, 100 );
			end;
			tmpold[i] = tmp;
		end;
	end;
	end;
end;
-----

-- retreat function for single unit
function Retreat( unit, x, y )
local cx, cy, dir, s, l;
local OGUREZ = 360 / 65536;
local GRAD2RAD = M_PI / 180;
local SEGMENT_LENGTH = 128;
local SEGMENT_ANGLE = 20 * GRAD2RAD;
local MAXPOINTS = 10;
local points = {};
local deltacos;
local dv = {};
local _dv = {};
local vec_dir = {};
local normdv = {};
local i = 0;
local normnew = {};
local stopiter = 0;
local a, K = SinCos( SEGMENT_ANGLE );

	if ( IsAlive( unit ) == 0 ) then
		return 0;
	end;
	
	cx, cy = ObjectGetCoord( unit );
	dir = GetFrontDir( unit );
	dir = dir * OGUREZ + 90;
	dir = dir * GRAD2RAD;
	vec_dir.y, vec_dir.x = SinCos( dir );
	vec_dir.y = -vec_dir.y;
	vec_dir.x = -vec_dir.x;
	
	dv.x, dv.y = x - cx, y - cy;
	l = len( dv.x, dv.y );
	dv = norm( dv );
	
	s = sign( vec_dir.x * dv.y - vec_dir.y * dv.x );
	
	-- building points
	while ( ( i < MAXPOINTS ) and ( stopiter == 0 ) and ( l > SEGMENT_LENGTH ) ) do
		i = i + 1;
		points[ i ] = { x = 0, y = 0 };
		if ( i > 1 ) then
			vec_dir = rotvec( vec_dir, SEGMENT_ANGLE * s );
			points[ i ].x = points[ i - 1 ].x + vec_dir.x * SEGMENT_LENGTH;
			points[ i ].y = points[ i - 1 ].y + vec_dir.y * SEGMENT_LENGTH;
		else
			points[ i ].x = cx + vec_dir.x * SEGMENT_LENGTH * 2;
			points[ i ].y = cy + vec_dir.y * SEGMENT_LENGTH * 2;		
		end;
		dv.x, dv.y = x - points[ i ].x, y - points[ i ].y;
		l = len( dv.x, dv.y );
		dv = norm( dv );
		deltacos = dv.x * vec_dir.x + dv.y * vec_dir.y;
		if ( deltacos > K ) then
			stopiter = 1;
		end;
	end;
	
	while ( ( i < MAXPOINTS ) and ( l > SEGMENT_LENGTH ) ) do
		i = i + 1;
		points[ i ] = { x = 0, y = 0 };
		points[ i ].x = points[ i - 1 ].x + dv.x * SEGMENT_LENGTH;
		points[ i ].y = points[ i - 1 ].y + dv.y * SEGMENT_LENGTH;		
		_dv.x, _dv.y = x - points[ i ].x, y - points[ i ].y;
		l = len( _dv.x, _dv.y );
	end;

	UnitCmd( ACT_MOVE, unit, 0, points[1].x, points[1].y );
	for j = 2, i do
		UnitQCmd( ACT_MOVE, unit, 0, points[j].x, points[j].y );
	end;
	UnitQCmd( ACT_MOVE, unit, 0, x, y );
end;

function RetreatGroup( units, x, y )
	if ( units == nil ) or ( units.n == 0) then
		Trace( "RetreatGroup: first parameter is invalid or empty" );
		return 0;
	end;
	if ( x == nil ) then
		Trace( "RetreatGroup: second parameter is invalid" );
		return 0;
	end;
	if ( y == nil ) then
		Trace( "RetreatGroup: third parameter is invalid" );
		return 0;
	end;
	for i = 1, units.n do
		StartThread( Retreat, units[i], x, y );
	end;
end;

function RetreatScriptGroup( sid, x, y )
	if ( sid == nil) then
		Trace( "RetreatScriptGroup: first parameter is invalid" );
		return 0;
	end;
local units = GetObjectListArray( sid );
	if ( x == nil ) then
		Trace( "RetreatScriptGroup: second parameter is invalid" );
		return 0;
	end;
	if ( y == nil ) then
		Trace( "RetreatScriptGroup: third parameter is invalid" );
		return 0;
	end;
	for i = 1, units.n do
		StartThread( Retreat, units[i], x, y );
	end;
end;

-- Returns 1 if vec{x, y} is in map bounds
--function IsInMapBoundsVec( ... )
--local vec = arg[1];
--local xmax, ymax = GetMapSize(); -- get map bounds

--	if ( ( vec.x <= 0 ) or ( vec.y <= 0) or ( vec.x >= xmax) or ( vec.y >= ymax ) ) then
--		return 0;
--	end;

--	return 1;
--end;

-- Returns 1 if (x, y) is in map bounds
function IsInMapBounds( x, y )
local xmax, ymax = GetMapSize(); -- get map bounds

	if ( ( x <= 0 ) or ( y <= 0 ) or ( x >= xmax ) or ( y >= ymax ) ) then
		return 0;
	end;

	return 1;
end;

-- Returns {x, y} vector as result of 90 degr rotated vec{x, y}; ccw - counterclockwise rotation
function rot90( vec, ccw )
	if ( ccw == 0) then
		ccw = -1;
	else
		ccw = 1;
	end;

	local x1 = vec.y * ccw;
	local y1 = - vec.x * ccw;
	
	vec.x = x1;
	vec.y = y1;

	return vec;
end;

-- rotate vector by angle (radians); vector is {x, y}
function rotvec( vec, angle )
local newvec = {};
local sin, cos = SinCos( angle );
	newvec.x = cos * vec.x + -sin * vec.y;
	newvec.y = sin * vec.x + cos * vec.y;
	return newvec;
end;

-- Returns normalized {x, y} vector
function norm( vec )
	local len1 = len ( vec.x, vec.y );
	local x1 = vec.x / len1;
	local y1 = vec.y / len1;
	
	vec.x = x1;
	vec.y = y1;
	return vec;
end;

-- Returns length of vector
function len( x, y )
local l = sqrt( x * x + y * y );
	return l;
end;

-- Returns square root of x
function sqrt( x )
local ITNUM = 4; -- number of iterations
local sp = 0;
local i = ITNUM;
local inv = 0;
local a, b;

	if ( x <= 0 ) then
		Trace("sqrt: parameter is negative or zero");
		return 0;
	end;

	if ( x < 1 ) then
		x = 1 / x;
		inv = 1;
	end;

	while ( x > 16) do
		sp = sp + 1;
		x = x / 16;
	end;

	a = 2;

-- Newtonian algorithm
	while ( i > 0 ) do
		b = x / a;
		a = a + b;
		a = a * 0.5;
		i = i - 1;
	end;

	while ( sp > 0 ) do
		sp = sp - 1;
		a = a * 4;
	end;

	if ( inv == 1) then
		a = 1 / a;
	end;
	return a;
end;

function mod( a, b )
local c = a;
	if ( a < b ) then
		return a;
	else
	while ( c >= b ) do
		c = c - b;
	end;
	end;
	return c;
end;

function abs( x )
local t = x;
	if ( x < 0 ) then
	t = -t;
	end;
	return t;
end;

function sign( x )
local t = 1;
	if ( x < 0 ) then
		return -t;
	end;
	return t;
end;

-- sine and cosine within 0-PI/4. MFRAC=4 optimized for single precision
MFRAC = 4;
function _Sico( arg1 )
local n, n2, arg2, t, sine, cosi;
local _arg = arg1;
--  /* calculate tangent by continuous fraction */
	t = 0;
	_arg = _arg * 0.5;
	arg2 = _arg * _arg;
	n = MFRAC - 1;
	n2 = n * 2 + 1; -- n << 1
	for k = n, 0, -1 do --(;n>=0;n--)
		if ( k > 0 ) then
			t = arg2 / (n2 - t);
		else 
			t = _arg / ( 1 - t );
		end
		n2 = n2 - 2;
	end;
--  /* sine and cosine */
	_arg = t * t;
	arg2 = 1 / (_arg + 1);
	sine = 2 * t * arg2;
	cosi = (1 - _arg) * arg2;
	return sine, cosi;
end;

--/* argument 0-PI/2 */
function Sico( arg1 )
local sine, cosi;
	if ( arg1 <= M_PI4) then 
		sine, cosi = _Sico( arg1 );
	else 
		cosi, sine = _Sico( M_PI2 - arg1 );
	end;
	return sine, cosi;
end;

--/* first period: -PI<=arg<=PI */
function SinCos_( arg1 )
local s = 0;
local _arg = arg1;
local sine, cosi;
	if ( _arg < 0 ) then
		_arg = -arg1;
		s = 1;
	end;
	if( _arg <= M_PI2 ) then
		sine, cosi = Sico( _arg );
	else
		cosi, sine = Sico( _arg - M_PI2 );
		cosi = -cosi;
	end;
	if ( s == 1 ) then 
		sine = -sine;
	end;
	return sine, cosi;
end;

function SinCos( arg1 )
local _arg = arg1;
local sine, cosi;
local sign = 0;
	if ( _arg > M_PI ) then
	sign = 1;
	elseif ( _arg < -M_PI ) then
	sign = -1;
	end;
	if ( sign ~= 0 ) then
	while ( abs( _arg ) > M_PI ) do
		_arg = _arg - sign * M_2PI;
	end;
	end;
	sine, cosi = SinCos_( _arg );
	return sine, cosi;
end;

oldGetDifficultyLevel = GetDifficultyLevel;
function GetDifficultyLevel()
	if oldGetDifficultyLevel() == 3 then
		return 0;
	end;
	if oldGetDifficultyLevel() == 0 then
		return 0;
	end;
	if oldGetDifficultyLevel() == 1 then
		return 1;
	end;
	if oldGetDifficultyLevel() == 2 then
		return 2;
	end;
end;

oldBlinkActionButton = BlinkActionButton;
function BlinkActionButton( nButton, nState )
	if ( __tutorial_blink_buttons == 1 ) then
		oldBlinkActionButton( nButton, nState )
	end;
end;

oldGetReinforcementCallsLeft = GetReinforcementCallsLeft
function GetReinforcementCallsLeft( player )
	if ( IsReinforcementAvailable( player ) == 0 ) then
		return 0;
	else
		xcalls = oldGetReinforcementCallsLeft( player );
		return xcalls;
	end;
end;