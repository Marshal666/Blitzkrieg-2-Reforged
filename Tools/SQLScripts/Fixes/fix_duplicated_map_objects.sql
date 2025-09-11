declare cur cursor for (select distinct __parent_id, Object, Pos_x, Pos_y, Pos_z
                        from MapInfo_objects as m1
                        where ( select count(*)
                                from MapInfo_objects as m2
                                where m1.__parent_id = m2.__parent_id and
                                m1.Object = m2.Object and
                                m1.Pos_x = m2.Pos_x and
                                m1.Pos_y = m2.Pos_y and
                                m1.Pos_z = m2.Pos_z ) > 1 )
open cur
declare @nObjID int
declare @fPosX float, @fPosY float, @fPosZ float
declare @nObjTypeID int
declare @nParentID int

fetch next from cur into @nParentID, @nObjTypeID, @fPosX, @fPosY, @fPosZ
while @@fetch_status = 0
begin
  set @nObjID = ( select top 1 __id
                  from MapInfo_objects
                  where __parent_id = @nParentID and
                        Object = @nObjTypeID and
                        Pos_x = @fPosX and
                        Pos_y = @fPosY and
                        Pos_z = @fPosZ )

  delete from MapInfo_objects
  where __parent_id = @nParentID and
        Object = @nObjTypeID and
        Pos_x = @fPosX and
        Pos_y = @fPosY and
        Pos_z = @fPosZ and 
        __id <> @nObjID
  print @nObjID

  fetch next from cur into @nParentID, @nObjTypeID, @fPosX, @fPosY, @fPosZ
end

close cur
deallocate cur