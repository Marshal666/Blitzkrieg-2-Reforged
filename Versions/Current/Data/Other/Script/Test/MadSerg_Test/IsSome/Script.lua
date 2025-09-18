function UnitInParty()
	if GetNUnitsInParty(0) > 0 then
		Trace("GetNUnitsInParty(0) = %g",GetNUnitsInParty(0));
		Trace("IsSomeUnitInParty(0) = %g", IsSomeUnitInParty(0));
		if IsSomeUnitInParty(0) == 1 and IsSomeUnitInParty(0) then  -- IsSomeUnitInParty(0) is work
			Trace("IsSomeUnitInParty(0) = %g", IsSomeUnitInParty(0));
		end;
	end;
end;

function UnitInArea()
	if GetNUnitsInArea(0,"Objective5",0) > 0 then
		Trace("GetNUnitsInArea(0,Objective5,0) = %g", GetNUnitsInArea(0,"Objective5",0));
		Trace("IsSomeUnitInArea(0,Objective5,0) = %g", IsSomeUnitInArea(0,"Objective5",0));
		if IsSomeUnitInArea(0,"Objective5",0) == 1 and IsSomeUnitInArea(0,"Objective5",0) then
			Trace("IsSomeUnitInArea(0,Objective5,0) = %g", IsSomeUnitInArea(0,"Objective5",0));
		end;
	end;
end;

function NearScriptObject(id)
	if GetNUnitsNearScriptObj(0,id,1000) > 0 then
		Trace("GetNUnitsNearScriptObj(0,%g,1000) = %g", id, GetNUnitsNearScriptObj(0,id,1000));
		Trace("IsUnitNearScriptObject(0,%g,1000) = %g", id, IsUnitNearScriptObject(0,id,1000));
		if IsUnitNearScriptObject(0,id,1000) == 1 and IsUnitNearScriptObject(0,id,1000) then
			Trace("IsUnitNearScriptObject(0,%g,1000) = %g", id, IsUnitNearScriptObject(0,id,1000));
		end;
	end;
end;

function BodyAliveUnit(id) -- id 10
	local array = {};
	array = GetObjectListArray( id );
	if NumUnitsAliveInArray(array) > 0 then
		Trace("Number units of HP>0 = %g",NumUnitsAliveInArray(array));
		Trace("IsSomeBodyAlive( %g ) = %g", id, IsSomeBodyAlive( id ));
		if IsSomeBodyAlive(id) == 1 and IsSomeBodyAlive(id) then
			Trace("IsSomeBodyAlive( %g ) = %g", id, IsSomeBodyAlive( id ));
		end;
	end;
end;

function BodyAliveBuilding( id ) -- 11 - empty ; 12 - isn't empty ; 13 - destroy
	local building = {};
	building = GetObjectListArray( id );
	if IsAlive( building[1] ) == 1 and NumUnitsAliveInArray(GetArray(GetPassangers( building[1] , 0 ))) > 0  then
		Trace("Units is alive = %g Passangers is alive in building = %g",IsAlive( building[1] ),NumUnitsAliveInArray(GetArray(GetPassangers( building[1] , 0 ))));
		Trace("IsSomeBodyAlive( %g ) = %g", id, IsSomeBodyAlive( id ));
		if IsSomeBodyAlive(id) == 1 and IsSomeBodyAlive(id) then
			Trace("IsSomeBodyAlive( %g ) = %g", id, IsSomeBodyAlive( id ));
		end;
	end;
end;

function WaitForGroup(id) --id 5, 6, 7, 8, 9, 10
	for i = 1, 5 do
		Cmd(ACT_MOVE, id, 0, GetScriptAreaParams("Objective"..i));
		WaitForGroupInArea(id,"Objective"..i);
		Trace("Area Objective%g is done",i);
	end;
end;

buildingdead = {};
buildingdead = GetObjectListArray( 13 );
DamageObject(buildingdead[1], 0);
CoordsRnd();
for i = 1, 10 do
	Trace( "Rnd = %g",Random(2));
end;