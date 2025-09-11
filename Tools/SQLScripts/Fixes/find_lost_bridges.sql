DECLARE @nMapID integer
set @nMapID = 802

select *
from MapInfo_objects
where __parent_id = @nMapID and
      Object in ( select StaticObjectRPGStats.__base_id
                  from bridgerpgstats, StaticObjectRPGStats
                  where StaticObjectRPGStats.__id = bridgerpgstats.__base_id ) and
      Link_LinkID not in ( select mapinfo_bridges_data.value
                           from mapinfo_bridges_data, mapinfo_bridges
                           where mapinfo_bridges_data.__parent_id = mapinfo_bridges.__id and
                                 mapinfo_bridges.__parent_id = @nMapID )