
declare cur cursor for select __id, __folder_id, __id_key from Text
open cur

declare @nID int, @nFolderID int, @szName nvarchar(255)

fetch next from cur into @nID, @nFolderID, @szName
while @@fetch_status = 0
begin
  if not EXISTS( select * from folders where [id] = @nFolderID ) 
  begin    
     print 'folder ' + STR(@nFolderID) + ' is not exist! (referenced by text ' + STR(@nID) + ')'
     update [Text] set __folder_id = 35232 where __folder_id = @nFolderID
  end
  fetch next from cur into @nID, @nFolderID, @szName
end

close cur
deallocate cur