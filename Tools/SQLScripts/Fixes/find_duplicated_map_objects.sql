select *
from MapInfo_objects as m1
where ( select count(*)
        from MapInfo_objects as m2
        where m1.__parent_id = m2.__parent_id and
              m1.Object = m2.Object and
              m1.Pos_x = m2.Pos_x and
              m1.Pos_y = m2.Pos_y and
              m1.Pos_z = m2.Pos_z ) > 1
order by Object, Pos_x, Pos_y, Pos_z, __id