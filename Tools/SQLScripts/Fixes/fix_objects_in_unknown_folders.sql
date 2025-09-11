declare cur cursor for ( SELECT DISTINCT TABLE_NAME
				FROM      INFORMATION_SCHEMA.COLUMNS t1
				WHERE     EXISTS
				                          (SELECT     *
				                            FROM          INFORMATION_SCHEMA.COLUMNS t2
				                            WHERE      TABLE_NAME = t1.TABLE_NAME AND COLUMN_NAME = '__id_key') AND EXISTS
				                          (SELECT     *
				                            FROM          INFORMATION_SCHEMA.COLUMNS t2
				                            WHERE      TABLE_NAME = t1.TABLE_NAME AND COLUMN_NAME = '__folder_id') )


open cur

declare @table varchar(255)

declare @szCmd nvarchar(4000)
declare @nNewFolderID integer

fetch next from cur into @table
while @@fetch_status = 0
begin
  set @szCmd = 'declare curElement cursor for ( select distinct __folder_id from ' + @table + ' as t1 where __folder_id is not null and not exists ( select * from folders where [id] = t1.__folder_id ) )'
  exec( @szCmd )
  open curElement
  declare @nFolderID integer
  fetch next from curElement into @nFolderID
  while @@fetch_status = 0
  begin
    -- create folder CRAP
    declare @nCrapID integer
    set @nCrapID = ( select [id ]
                     from folders 
                     where folder_name = 'CRAP' and 
                           obj_type = @table and 
                           parent_id is null )
    if @nCrapID is null
    begin
      insert into folders ( folder_name, obj_type ) 
      values( 'CRAP', @table )
      set @nCrapID = ( select [id ]
                       from folders 
                       where folder_name = 'CRAP' and 
                             obj_type = @table and 
                             parent_id is null )
    end
    -- create folder with name STR( @nFolderID )
    set @nNewFolderID = ( select [id] 
                         from folders
                         where folder_name = STR(@nFolderID) and
                               obj_type = @table and 
                               parent_id = @nCrapID )
    if @nNewFolderID is null
    begin
      insert into folders ( folder_name, obj_type, parent_id ) values( STR(@nFolderID), @table, @nCrapID )
      set @nNewFolderID = ( select [id] 
                           from folders
                           where folder_name = STR(@nFolderID) and
                                 obj_type = @table and 
                                 parent_id = @nCrapID )
--      print 'new folder ' + STR(@nFolderID) + ' of type ' + @table + ' created'
    end
    -- move all objects from folder @nFolderID to folder @nIDFolderID
    set @szCmd = 'update ' + @table + ' set __folder_id = ' + STR(@nNewFolderID) + ' where __folder_id = ' + STR(@nFolderID)
    exec( @szCmd )

  fetch next from curElement into @nFolderID
  end
  close curElement
  deallocate curElement

  fetch next from cur into @table
end

close cur
deallocate cur