declare cur cursor for (select distinct __parent_id, __arr_order
                        from Terrain_Roads as m1
                        where ( select count(*)
                                from Terrain_Roads as m2
                                where m1.__parent_id = m2.__parent_id and
                                      m1.__arr_order = m2.__arr_order ) > 1 )
open cur
declare @nObjID int
declare @nArrOrder int
declare @nParentID int


fetch next from cur into @nParentID, @nArrOrder
while @@fetch_status = 0
begin
  set @nObjID = ( select top 1 __id
                  from Terrain_Roads
                  where __parent_id = @nParentID and
                        __arr_order = @nArrOrder )
  print @nObjID

  delete from Terrain_Roads
  where __parent_id = @nParentID and
        __arr_order = @nArrOrder and
        __id <> @nObjID
  print @nObjID

  fetch next from cur into @nParentID, @nArrOrder
end

close cur
deallocate cur