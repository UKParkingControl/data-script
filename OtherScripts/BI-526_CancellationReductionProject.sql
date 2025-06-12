select c.ID
, MAX(CASE WHEN wa.Description = 'Keeper Lookup' THEN aa.Created END) KeeperLookupDate
, MIN(CASE WHEN wa.Description = 'Issue Initial Notice' THEN aa.Created END) IssueInitialNoticeDate
into BusinessIntelligence.development.tmp_PCN_Action
from [StellaProduction].[sqldb-stella-prod].cm.WorkflowActions wa
JOIN [StellaProduction].[sqldb-stella-prod].cm.Accounts a  on wa.WorkflowID=a.WorkflowID
JOIN [StellaProduction].[sqldb-stella-prod].cm.Contraventions c on a.ID=c.ActiveAccountId
JOIN [StellaProduction].[sqldb-stella-prod].cm.AccountActions aa on aa.WorkflowActionId = wa.ID and aa.AccountId = a.ID
where year(c.FirstIssuedDate)=2024
and aa.Deleted is null
and wa.Description IN ('Keeper Lookup', 'Issue Initial Notice')
group by c.ID;

WITH ranked AS
	(
	select ZoneExternalReference, LocationID, LocationName, pa.ID ContraventionID, ServiceType, ContraventionStatus, ContraventionReason, VRN, ContraventionEventDateTime,
	PermitAddedDate, KeeperLookupDate, IssueInitialNoticeDate,
	CASE WHEN PermitAddedDate BETWEEN COALESCE(KeeperLookupDate,'2024-01-01 00:00:00.000')  AND IssueInitialNoticeDate THEN 1 ELSE 0 END PermitBeforeInitialLetter
	, ROW_NUMBER() OVER (
	            PARTITION BY pa.ID
	            ORDER BY ABS(DATEDIFF(hour, IssueInitialNoticeDate, PermitAddedDate)) ASC) rn
	from BusinessIntelligence.development.tmp_PCN_Action pa
	JOIN BusinessIntelligence.development.tmp_PermitAdded pm 
	On pa.ID=pm.ContraventionID
	WHERE IssueInitialNoticeDate IS NOT NULL
	)
SELECT * from ranked
where rn=1
and ServiceType IN ('PARKING OPS', 'ANPR')
order by ContraventionEventDateTime, ZoneExternalReference;