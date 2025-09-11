SELECT     SUBSTRING(dbo.RestoreFolderName_Squad(__parent_id), 4, CHARINDEX('\', dbo.RestoreFolderName_Squad(__parent_id), 4) - 4) AS Country, 
                      dbo.RestoreFolderName_Squad(__parent_id) AS [Squad Name], dbo.RestoreFolderName_Infantry([value]) AS [Infantry Name]
FROM         SquadRPGStats_members
WHERE     (dbo.RestoreFolderName_Squad(__parent_id) LIKE 'b2\%')
ORDER BY dbo.RestoreFolderName_Squad(__parent_id), dbo.RestoreFolderName_Infantry([value])
