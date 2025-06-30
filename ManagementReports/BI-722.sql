
SELECT *
FROM OPENQUERY(StellaProduction, '
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

rn_LowHighIDR AS (
	SELECT 
		aa.AccountId,
		aa.Description,
		aa.Created,
		ROW_NUMBER() OVER (
			PARTITION BY AccountId 
			ORDER BY Created DESC
		) AS rn
	FROM cm.AccountActions aa
	WHERE aa.ActionType IN (1, 2)
		AND aa.Description IN (
			''Change Value (Lower)'', 
			''Change Value (Upper)'', 
			''Issue Initial Internal Debt recovery''
		)
		AND aa.Deleted IS NULL
), 

LowHighIDR AS (
	SELECT 
		AccountId,
		Created,
		CASE
			WHEN Description = ''Change Value (Lower)'' THEN ''Paid at Lower Value''
			WHEN Description = ''Change Value (Upper)'' THEN ''Paid at Higher Value''
			WHEN Description = ''Issue Initial Internal Debt recovery'' THEN ''Paid at Internal Debt Recovery''
		END AS Description	    	
	FROM rn_LowHighIDR
	WHERE rn = 1
),

rn_dcp AS (
	SELECT 
		dcp.ContraventionId,
		dcp.ActiveAccountId,
		dcp.PlacementLevel,
		ROW_NUMBER() OVER (
			PARTITION BY ContraventionId
			ORDER BY dcp.PlacementLevel DESC
		) AS rn
	FROM cm.DebtCollectionPlacements dcp
	WHERE dcp.Deleted IS NULL
		AND (dcp.PlacementLevel IN (0, 1, 2) OR (dcp.PlacementLevel = 3 AND dcp.Status = 4))
), 

dcp AS (
	SELECT 
		ContraventionId,
		ActiveAccountId,
		CASE 
			WHEN PlacementLevel = 0 THEN ''Unpaid''
			WHEN PlacementLevel = 1 THEN ''Paid at Debt Recovery 1st Placement''
			WHEN PlacementLevel = 2 THEN ''Paid at Debt Recovery 2nd Placement''
			WHEN PlacementLevel = 3 THEN ''Paid at Litigation''
		END AS Description
	FROM rn_dcp
	WHERE rn = 1
),

cte_table AS (
	SELECT
		FORMAT(c.FirstIssuedDate, ''yyyy MMM'') AS YearMonth,
		FORMAT(c.FirstIssuedDate, ''yyyyMM'') AS YearMonthIndex,
		c.Id,
		CASE 
			WHEN c.Status = 2 THEN ''Cancelled''
			WHEN c.Status IN (0, 3, 4) OR pa.Created IS NULL THEN ''Unpaid''
			WHEN c.Status = 1 AND dcp.ContraventionId IS NOT NULL THEN dcp.Description
			WHEN c.Status = 1 AND lhi.Created < pa.Created AND lhi.AccountId IS NOT NULL THEN lhi.Description
			ELSE ''Other''
		END AS Status
	FROM cm.Contraventions c
	LEFT JOIN paidAt pa ON pa.AccountId = c.ActiveAccountId
	LEFT JOIN LowHighIDR lhi ON lhi.AccountId = c.ActiveAccountId
	LEFT JOIN dcp ON dcp.ActiveAccountId = c.ActiveAccountId AND dcp.ContraventionId = c.Id
	WHERE YEAR(c.FirstIssuedDate) >= 2023
)

SELECT 
	a.YearMonth, 
	a.YearMonthIndex, 
	a.Status, 
	a.Total, 
	CAST(a.Total AS FLOAT)/NULLIF(b.Total_YM,0) AS Percentage
FROM (
	SELECT 
		YearMonth, 
		YearMonthIndex, 
		Status, 
		COUNT(Id) AS Total
	FROM cte_table
	GROUP BY YearMonth, YearMonthIndex, Status
) a
JOIN (
	SELECT 
		YearMonth, 
		YearMonthIndex, 
		COUNT(Id) AS Total_YM
	FROM cte_table
	GROUP BY YearMonth, YearMonthIndex
) b ON a.YearMonthIndex = b.YearMonthIndex
ORDER BY a.YearMonthIndex, a.Status
');