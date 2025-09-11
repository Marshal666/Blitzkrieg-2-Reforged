declare cur cursor for ( select __id
                         from MapInfo )

open cur
declare @nMapID int

fetch next from cur into @nMapID
while @@fetch_status = 0
begin
  declare @nNumPlayers int
  set @nNumPlayers = ( select count(__id) 
                       from MapInfo_Players
                       where __parent_id = @nMapID )
--  if @nNumPlayers >= 6
--  begin
--    print @nMapID
--  end

  if exists ( select __id
              from MapInfo_objects
              where __parent_id = @nMapID and Player >= @nNumPlayers )
  begin
    print 'Map ' + STR(@nMapID) + ' has objects with invalid player!'

    update MapInfo_objects
    set Player = @nNumPlayers - 1
    where __parent_id = @nMapID and Player >= @nNumPlayers

    
  end
  
  fetch next from cur into @nMapID
end

close cur
deallocate cur