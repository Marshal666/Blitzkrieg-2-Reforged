declare @nMapID int
set @nMapID = 915

select *
from MapInfo_Objects
where __parent_id = @nMapID and
      ( ( Pos_x < 0 or Pos_x > (select NumPatchesX * 16 * 64 from terrain where __id = ( select __base_id from mapinfo where __id = @nMapID )) ) or
        ( Pos_y < 0 or Pos_y > (select NumPatchesY * 16 * 64 from terrain where __id = ( select __base_id from mapinfo where __id = @nMapID )) ) )

