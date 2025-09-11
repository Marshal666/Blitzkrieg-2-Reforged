declare cur cursor for ( select [id], obj_type
                         from folders
                         where parent_id is null and folder_name = 'CRAP' )

open cur
declare @nID int
declare @szObjType varchar(255)

fetch next from cur into @nID, @szObjType
while @@fetch_status = 0
begin  
  if @szObjType <> 'WindowInstance' and
     @szObjType <> 'WindowShared' and
     @szObjType <> 'WindowMultiBkgShared' and
     @szObjType <> 'TerrainDesc' and
     @szObjType <> 'TGTexture' and
     @szObjType <> 'AnimBase' and
     @szObjType <> 'c' and
     @szObjType <> 'Background' and
     @szObjType <> 'WindowBinkPlayerShared' and
     @szObjType <> 'WindowBinkPlayer'
  begin
    declare @sCmd nvarchar(4000)
--    print 'Object type: ' + @szObjType
--    print 'Folder ID: ' + STR(@nID)
--    set @sCmd = 'select __id_key from ' + @szObjType + ' where __folder_id = ' + STR(@nID)
--    exec( @sCmd )
    set @sCmd = 'select id as [' + @szObjType + '], folder_name from folders where parent_id = ' + STR(@nID) + ' order by folder_name'
--    print @sCmd
    exec( @sCmd )
  end

  fetch next from cur into @nID, @szObjType
end

close cur
deallocate cur