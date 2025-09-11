declare cur cursor for select __id, __id_key from MechUnitRPGStats
open cur
declare @nID int, @szName nvarchar(255)
declare @nCounter int
set @nCounter = 1

fetch next from cur into @nID, @szName
while @@fetch_status = 0
begin
  declare @szFolderName varchar(255)
  set @szFolderName = dbo.RestoreFolderName_MechUnit( @nID )
  if @szFolderName LIKE( 'b2\units\technics\%' ) and 
	@szFolderName NOT LIKE( 'b2\units\technics\common\%' ) and 
	exists (select __color 
		from MechUnitRPGStats, UnitBaseRPGStats
		where MechUnitRPGStats.__id = @nID and MechUnitRPGStats.__color <> 0 and
			UnitBaseRPGStats.__id = MechUnitRPGStats.__base_id and
			UnitBaseRPGStats.EncyclopediaFilterUnitType <> 'EFUT_UNKNOWN' )
  begin
    insert into GameRoot_EncyclopediaMechUnits (__arr_order, __parent_id, value) values ( @nCounter, 2, @nID )
    set @nCounter = @nCounter + 1
  end
  fetch next from cur into @nID, @szName
end

close cur
deallocate cur