declare cur cursor for ( select [id], parent_id, obj_type
                         from folders 
                         where parent_id is not null )

open cur
declare @nID int, @nParentID int
declare @szObjType varchar(255)

fetch next from cur into @nID, @nParentID, @szObjType
while @@fetch_status = 0
begin
  if ( select obj_type from folders where [id] = @nParentID ) <> @szObjType
  begin
    print 'Wrong obj_type: ID = ' + STR(@nID) + ' parentID = ' + STR(@nParentID) + ' type = ' + @szObjType
  end

  if not exists ( select id from folders where [id] = @nParentID )
  begin
    print 'Parent folder not exists: ID = ' + STR(@nID) + ' parentID = ' + STR(@nParentID) + ' type = ' + @szObjType
  end
  
  fetch next from cur into @nID, @nParentID, @szObjType
end

close cur
deallocate cur