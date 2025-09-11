declare @nMapID integer
set @nMapID = 847

select *
from mapinfo_objects
where __parent_id = @nMapID and
      Object in ( select __base_id from EntrenchmentRPGStats ) and
      Link_LinkID not in (select mapinfo_entrenchments_sections_data.value
                      from mapinfo_entrenchments_sections_data, mapinfo_entrenchments_sections, mapinfo_entrenchments
                      where mapinfo_entrenchments.__parent_id = @nMapID and
                            mapinfo_entrenchments_sections.__parent_id = mapinfo_entrenchments.__id and
                            mapinfo_entrenchments_sections_data.__parent_id = mapinfo_entrenchments_sections.__id)