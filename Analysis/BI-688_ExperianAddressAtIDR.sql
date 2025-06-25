WITH paidAt AS (
	SELECT 
		at2.AccountId,
		MAX(at2.Created) AS Created
	FROM cm.AccountTransactions at2
	WHERE 
		(at2.TransactionType IN (0,1,2,3,6,7) OR (at2.TransactionType = 10 AND at2.Amount < 0))
		AND at2.Deleted IS NULL
	GROUP BY at2.AccountId
),
idr AS (
	SELECT 
		aa.AccountId,
		MAX(aa.Created) AS Created
	FROM cm.AccountActions aa
	WHERE aa.ActionType = 2 AND aa.Description = 'Issue Initial Internal Debt recovery'
	GROUP BY aa.AccountId
),
dcp AS (
	SELECT 
		dcp.ContraventionId,
		dcp.ActiveAccountId,
		MAX(dcp.Created) AS MaxCreated,
		MIN(dcp.Created) AS MinCreated
	FROM cm.DebtCollectionPlacements dcp
	WHERE dcp.Deleted IS NULL
	GROUP BY dcp.ContraventionId, dcp.ActiveAccountId
),
idrp AS (
	SELECT 
		c.Id, c.ActiveAccountId
	FROM cm.Contraventions c
	LEFT JOIN paidAt ON paidAt.AccountId = c.ActiveAccountId
	LEFT JOIN idr ON idr.AccountId = c.ActiveAccountId
	LEFT JOIN dcp ON dcp.ActiveAccountId = c.ActiveAccountId AND dcp.ContraventionId = c.Id
	WHERE YEAR(c.FirstIssuedDate) >= 2024
	AND (c.Status = 1 AND idr.Created < paidAt.Created AND dcp.ContraventionId IS NULL)
)
SELECT er.ID, ContraventionId, AccountId, SentDateTime, ReturnedDateTime, 
case when idrp.ID IS NULL THEN 0 ELSE 1 END IsPaid
from cm.ExperianRequests er 
LEFT JOIN idrp ON er.ContraventionId=idrp.ID AND idrp.ActiveAccountId=er.AccountId
WHERE er.ResultCode ='F'
AND CAST(SentDateTime AS DATE) >= '2024-12-01'
AND CAST(SentDateTime AS DATE) <= '2025-05-31';