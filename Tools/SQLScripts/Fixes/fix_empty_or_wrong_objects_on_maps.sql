use b2_local
delete
from MapInfo_Objects
where Object is null or
      not exists (select * from HPObjectRPGStats where __id = Object)

use b2_base
delete
from MapInfo_Objects
where Object is null or
      not exists (select * from HPObjectRPGStats where __id = Object)