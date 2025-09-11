CREATE PROCEDURE [dbo].[DropFKConstraints] AS
	BEGIN TRANSACTION

	set nocount on

	declare cur cursor for select CONSTRAINT_NAME, TABLE_NAME  from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_TYPE='FOREIGN KEY'
	open cur

	declare @tbl nvarchar(256), @constr nvarchar(256)

	fetch next from cur into @constr, @tbl

	while @@fetch_status = 0
	begin
		declare @sCmd nvarchar(4000)
		set @sCmd = 'ALTER TABLE ' + @tbl + ' DROP CONSTRAINT ' + @constr
		print( @sCmd )

		exec( @sCmd )

		fetch next from cur into @constr, @tbl
	end

	close cur
    deallocate cur
	COMMIT
GO
