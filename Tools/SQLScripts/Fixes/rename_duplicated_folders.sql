declare cur cursor for ( select [id], folder_name, parent_id, obj_type from folders )
open cur
declare @nParentID int
declare @szFolderName varchar(255)
declare @szObjType varchar(255)
declare @nCounter int, @nFolderID int


fetch next from cur into @nFolderID, @szFolderName, @nParentID, @szObjType
while @@fetch_status = 0
begin
  set @nCounter = ( select count(*) 
                    from folders 
                    where folder_name = @szFolderName and
                          parent_id = @nParentID and
                          obj_type = @szObjType )
  if @nCounter > 1
  begin
--    print 'folder ' + @szFolderName + ' of type ' + @szObjType + ' at least duplicated!'
    print @szFolderName + STR(@nFolderID)
  end
  fetch next from cur into @nFolderID, @szFolderName, @nParentID, @szObjType
end

close cur
deallocate cur
