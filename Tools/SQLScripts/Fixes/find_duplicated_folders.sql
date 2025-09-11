select distinct dbo.RestoreFolderName( [id] ) as [Folder Name], obj_type as [Object Type]
from folders as f1
where ( select count(*) 
        from folders as f2
        where f2.folder_name = f1.folder_name and
              f2.parent_id = f1.parent_id and
              f2.obj_type = f1.obj_type ) > 1
order by dbo.RestoreFolderName( [id] ), obj_type