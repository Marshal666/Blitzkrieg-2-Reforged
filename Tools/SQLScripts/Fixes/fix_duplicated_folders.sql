update folders
set folder_name = f1.folder_name + STR(f1.[id])
from folders as f1
where ( select count(*) 
        from folders as f2
        where f2.folder_name = f1.folder_name and
              f2.parent_id = f1.parent_id and
              f2.obj_type = f1.obj_type ) > 1