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
  declare @sCmd nvarchar(4000)
  set @sCmd = '(select * from ' + @table + ' as t1 where ( select count(*) from ' + @table + ' as t2 where t1.__arr_order = t2.__arr_order and t1.__parent_id = t2.__parent_id ) > 1)'

  declare @sCmd1 nvarchar(4000)
  set @sCmd1 = 'if exists ' + @sCmd + ' begin (select count(*) as number, ''' + @table + ''' as tablename from ' + @table + ' as t1 where ( select count(*) from ' + @table + ' as t2 where t1.__arr_order = t2.__arr_order and t1.__parent_id = t2.__parent_id ) > 1) end'
  exec( @sCmd1)
  
--  declare @sCmd nvarchar(4000)
 -- declare @sCmd2 nvarchar(4000)
 --set @sCmd = '( select __id_key as ' + @table + ', __id, __folder_id  from ' + @table + ' t1 
--		            where exists 
--			   ( select * from ' + @table + ' t2
--			     where t1.__id != t2.__id and t1.__id_key = t2.__id_key and t1.__folder_id = t2.__folder_id ) )'
 -- set @sCmd2 = 'if exists ' + @sCmd + ' begin ' +  @sCmd + ' end'
 -- exec( @sCmd2 )
--   print @table


  fetch next from cur into @table
end

close cur
deallocate cur