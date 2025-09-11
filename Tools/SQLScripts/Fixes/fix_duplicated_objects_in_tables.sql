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

fetch next from cur into @table
while @@fetch_status = 0
begin
--  if @table <> 'MapInfo_Objects'
  begin
    declare @sCmd nvarchar(4000)
    declare @sCmd1 nvarchar(4000)

    set @sCmd = 'update ' + @table + ' set __id_key = __id_key + STR(__id) where __id in (select __id from ' + @table + ' as t1 where exists ( select * from ' + @table + ' as t2 where t1.__id_key = t2.__id_key and t1.__folder_id = t2.__folder_id and t1.__id <> t2.__id ))'
--    set @sCmd = 'select __id as ' + @table + ', __id_key, __folder_id from ' + @table + ' where __id in (select __id from ' + @table + ' as t1 where exists ( select * from ' + @table + ' as t2 where t1.__id_key = t2.__id_key and t1.__folder_id = t2.__folder_id and t1.__id <> t2.__id ))'
--    set @sCmd1 = 'if exists ( ' + @sCmd + ' ) begin ' + @sCmd + '  order by __folder_id, __id_key, __id end'

--    print @table
--    exec( @sCmd1 )
   exec( @sCmd )
  end


  fetch next from cur into @table
end

close cur
deallocate cur