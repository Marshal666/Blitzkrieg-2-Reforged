declare cur cursor for ( SELECT DISTINCT TABLE_NAME
				FROM      INFORMATION_SCHEMA.COLUMNS t1
				WHERE     EXISTS
				                          (SELECT     *
				                            FROM          INFORMATION_SCHEMA.COLUMNS t2
				                            WHERE      TABLE_NAME = t1.TABLE_NAME AND COLUMN_NAME = '__arr_order') AND EXISTS
				                          (SELECT     *
				                            FROM          INFORMATION_SCHEMA.COLUMNS t2
				                            WHERE      TABLE_NAME = t1.TABLE_NAME AND COLUMN_NAME = '__parent_id') AND exists
				                          (SELECT     *
							    FROM          INFORMATION_SCHEMA.COLUMNS t2
				                            WHERE         TABLE_NAME = t1.TABLE_NAME AND COLUMN_NAME = '__id'))


open cur

declare @table varchar(255)

fetch next from cur into @table
while @@fetch_status = 0
begin
  if @table <> 'MapInfo_Objects'
  begin
    declare @sCmd nvarchar(4000)

    set @sCmd = 'delete from ' + @table + ' where __id in (select __id from ' + @table + ' as t1 where exists ( select * from ' + @table + ' as t2 where t1.__arr_order = t2.__arr_order and t1.__parent_id = t2.__parent_id and t1.__id < t2.__id ))'

    print @table
    exec( @sCmd )
  end


  fetch next from cur into @table
end

close cur
deallocate cur