select dbo.RestoreFolderName_MechUnit( MechUnitRPGStats.__id ) as [Name]
from basegunrpgstats, weaponrpgstats, mechunitrpgstats, mechunitrpgstats_platforms, mechunitrpgstats_platforms_guns
where weaponrpgstats.RangeMin > 5 and
      basegunrpgstats.Weapon = weaponrpgstats.__id and
      mechunitrpgstats_platforms_guns.__base_id = basegunrpgstats.__id and
      mechunitrpgstats_platforms_guns.__parent_id = mechunitrpgstats_platforms.__id and
      mechunitrpgstats.__id = mechunitrpgstats_platforms.__parent_id and
      dbo.RestoreFolderName_MechUnit( MechUnitRPGStats.__id ) LIKE ( 'b2\units\technics\%' )
--order by dbo.RestoreFolderName_MechUnit( MechUnitRPGStats.__id )
group by dbo.RestoreFolderName_MechUnit( MechUnitRPGStats.__id )