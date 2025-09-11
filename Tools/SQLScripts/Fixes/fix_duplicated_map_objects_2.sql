declare @nCounter int
declare @fPosX float, @fPosY float, @fPosZ float
declare @nObjTypeID int
declare @nParentID int
set @nCounter = 0

while @nCounter < 150088
begin
  set @nCounter = @nCounter + 1
  if exists ( select * from MapInfo_Objects where __id = @nCounter )
  begin
    set @fPosX = ( select Pos_x from MapInfo_objects where __id = @nCounter )
    set @fPosY = ( select Pos_y from MapInfo_objects where __id = @nCounter )
    set @fPosZ = ( select Pos_z from MapInfo_objects where __id = @nCounter )
    set @nObjTypeID = ( select Object from MapInfo_objects where __id = @nCounter )
    set @nParentID = ( select __parent_id from MapInfo_objects where __id = @nCounter )
    if ( (select count(*)
          from MapInfo_objects
          where __parent_id = @nParentID and
               Object = @nObjTypeID and
               Pos_x = @fPosX and
               Pos_y = @fPosY and
               Pos_z = @fPosZ and 
               __id <> @nCounter) > 1 )
    begin
      delete from MapInfo_objects
      where __id = @nCounter
    end
  end
end
