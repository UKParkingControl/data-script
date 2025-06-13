SELECT
        S.ZoneName, 
      	COALESCE(TotalIssued, 0) TotalIssued,
        COALESCE(TotalCancelled, 0) TotalCancelled
FROM
        [Statistics].[Sites] S
LEFT JOIN 
        (
        SELECT CI.SiteReference, COUNT(DISTINCT CI.ContraventionID) TotalIssued
        FROM [Statistics].[Contraventions_Issued] CI 
        WHERE CI.DateIssued BETWEEN DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0) AND EOMONTH(DATEADD(MONTH, -1, GETDATE()))
        GROUP BY CI.SiteReference
        ) CI ON CI.SiteReference = S.ZoneExternalReference
LEFT JOIN 
		(
		SELECT C.SiteID, COUNT(DISTINCT C.ContraventionID) TotalCancelled
        FROM [Statistics].[Contraventions_Cancellations] C 
		WHERE C.CancelledDate BETWEEN DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0) AND EOMONTH(DATEADD(MONTH, -1, GETDATE()))
		GROUP BY C.SiteID
		) C ON C.SiteID = S.ZoneExternalReference
WHERE S.[System] = 'Stella'
AND S.PortfolioName LIKE '%Calthorpe Estates%'
AND S.ActiveDate <= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
AND S.DeactiveDate >= EOMONTH(DATEADD(MONTH, -1, GETDATE()))
ORDER BY ZoneName
;