select *
from Terrain_Roads as m1
where ( select count(*) from Terrain_Roads as m2 where m1.__arr_order = m2.__arr_order and m1.__parent_id = m2.__parent_id ) > 1
--order by __id
order by __parent_id, __id, __arr_order