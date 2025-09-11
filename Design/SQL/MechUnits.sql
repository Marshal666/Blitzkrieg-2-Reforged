select substring( dbo.RestoreFolderName_MechUnit(__id), 19, charindex( '\', dbo.RestoreFolderName_MechUnit(__id), 20 ) - 19 ) as [Name], 
       __id_key, UnitType
from MechUnitRPGStats
where dbo.RestoreFolderName_MechUnit(__id) LIKE('b2\units\technics\%')
order by [Name], UnitType, __id_key
