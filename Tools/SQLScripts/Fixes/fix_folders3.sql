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
    declare @nCrapID int
    set @nCrapID = ( select id 
                     from folders 
                     where folder_name = 'CRAP' and 
                           obj_type = @szObjType and 
                           parent_id is null )
    if @nCrapID is null
    begin
      insert into folders ( folder_name, obj_type ) values( 'CRAP', @szObjType )
      set @nCrapID = ( select id 
                       from folders 
                       where folder_name = 'CRAP' and 
                             obj_type = @szObjType and 
                             parent_id is null )
    end

    update folders
    set parent_id = @nCrapID
    where id = @nID
  end
  
  fetch next from cur into @nID, @nParentID, @szObjType
end

close cur
deallocate cur