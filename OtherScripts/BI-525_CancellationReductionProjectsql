-- Create a table storing Permit Added Date
SELECT c.*, LocationName, s.WhiteListId, [From], [To], wl.Created PermitAddedDate
into BusinessIntelligence.development.tmp_PermitAdded
from BusinessIntelligence.[Statistics].Contraventions c
JOIN VehicleList.dbo.MappedScopes ms ON c.ZoneExternalReference = ms.ExternalReference
JOIN VehicleList.dbo.Scopes s 
	ON (s.ScopeType = 1 AND s.ScopeId = ms.CompanyId)
	OR (s.ScopeType = 3 AND s.ScopeId = ms.LocationId)
	OR (s.ScopeType = 4 AND s.ScopeId = ms.ZoneId)
JOIN VehicleList.dbo.Permits p on p.Id = s.PermitId
JOIN VehicleList.dbo.WhiteLists wl on wl.VrnNumber = c.VRN AND wl.ID=s.WhiteListId and c.ContraventionEventDateTime between [From] AND [To]
WHERE 1=1
AND YEAR(contraventiondatetime) in (2023,2024);

-- Create a table storing Intinial Notice
SELECT
 co.ContraventionID, ZoneExternalReference, ServiceType,  VRN, FirstIssuedDate, ContraventionStatus, ContraventionReason,
 A.ID AccountID,
 vl.Created,
 ProcessedDateTime [NTKDateTime],
 W.[Name] [LetterType]
INTO BusinessIntelligence.development.tmp_InitialNotice
FROM [StellaProduction].[sqldb-stella-prod].[cm].[AccountCorrespondences]  AC
JOIN [StellaProduction].[sqldb-stella-prod].[cm].[Accounts] A ON AC.AccountId = A.ID
JOIN BusinessIntelligence.[Statistics].Contraventions CO ON A.ContraventionId = CO.ContraventionId
JOIN [StellaProduction].[sqldb-stella-prod].[cm].[WorkflowLetterTemplates] W ON W.ID = AC.WorkflowLetterTemplateId
JOIN VehicleList.dbo.MappedScopes ms ON co.ZoneExternalReference = ms.ExternalReference
JOIN VehicleList.dbo.Scopes s 
	ON (s.ScopeType = 1 AND s.ScopeId = ms.CompanyId)
	OR (s.ScopeType = 3 AND s.ScopeId = ms.LocationId)
	OR (s.ScopeType = 4 AND s.ScopeId = ms.ZoneId)
JOIN VehicleList.dbo.Permits p on p.Id = s.PermitId
JOIN VehicleList.dbo.VehicleLists vl ON s.VehicleListId = vl.Id
JOIN VehicleList.dbo.Vehicles v ON v.VrnNumber = co.VRN and v.PermitsId = p.ID
WHERE 
 AC.SendStatus = 3
 AND AC.Method = 0
 AND AC.Deleted IS NULL
 AND W.[Name] like '%Initial Notice%'
 AND vl.ServiceId = 2
 AND s.WhiteListId IS NULL
 AND YEAR(ProcessedDateTime)=2024;
 
 --Join the two tables
 with ranked as
(
select init.ContraventionID, ContraventionEventDateTime, ZoneExternalReference, LocationID, LocationName, ServiceType, ContraventionStatus, ContraventionReason, VRN, NTKDateTime, PermitAddedDate, DATEDIFF(hour, NTKDateTime, PermitAddedDate) TimeGap 
, ROW_NUMBER() OVER (
            PARTITION BY init.ContraventionID
            ORDER BY ABS(DATEDIFF(hour, NTKDateTime, PermitAddedDate)) ASC
        ) rn
from BusinessIntelligence.development.tmp_InitialNotice init
JOIN BusinessIntelligence.development.tmp_PermitAdded pm On init.ContraventionID=pm.ContraventionID
)
select * from ranked where rn=1
order by ContraventionEventDateTime asc;