Use BusinessIntelligence
	SET DATEFIRST 1;

	DECLARE @DateFrom AS DATE;
	DECLARE @DateTo AS DATE;

	SET @DateTo = EOMONTH(GETDATE(),0)
	SET @DateFrom = EOMONTH(DATEADD(MONTH, -18, GETDATE()),0)

	DECLARE @DateTable Table
	(
		DDate Date
	)	
	
	;WITH cte_Dates(DDate) AS 
	(
		SELECT @DateFrom DDate
		UNION ALL
		SELECT EOMONTH(DATEADD(MONTH, 1, DDate),0)
		FROM cte_Dates
		WHERE EOMONTH(DATEADD(MONTH, 1, DDate),0) <= @DateTo
	)

	,cte_ANPR_ZonesNotIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			'ANPR' [Service],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.ANPRLiveDate LiveDate,
			Z.ANPRTermDate TermDate,
			SUM(CASE WHEN CI.ContraventionID IS NOT NULL THEN 1 ELSE 0 END) [TotalIssued]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.ANPRTermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ANPRLiveDate <= Ddate AND Z.ANPR=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType = 'ANPR' AND CI.SiteReference = S.ZoneExternalReference
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneExternalReference,
			S.ZoneName,
			Z.ANPRLiveDate,
			Z.ANPRTermDate
		HAVING
			SUM(CASE WHEN CI.ContraventionID IS NOT NULL THEN 1 ELSE 0 END) = 0
	)
	,cte_eCam_ZonesNotIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			'ECAM' [Service],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.eCamLiveDate LiveDate,
			Z.eCamTermDate TermDate,
			SUM(CASE WHEN CI.ContraventionID IS NOT NULL THEN 1 ELSE 0 END) [TotalIssued]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamTermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.eCamLiveDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType = 'ECAM' AND CI.SiteReference = S.ZoneExternalReference
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneExternalReference,
			S.ZoneName,
			Z.eCamLiveDate,
			Z.eCamTermDate
		HAVING
			SUM(CASE WHEN CI.ContraventionID IS NOT NULL THEN 1 ELSE 0 END) = 0
	)
	,cte_PO_ZonesNotIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			'Parking Ops' [Service],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.PPSLiveDate LiveDate,
			Z.PPSTermDate TermDate,
			SUM(CASE WHEN CI.ContraventionID IS NOT NULL THEN 1 ELSE 0 END) [TotalIssued]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.PPSTermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.PPSLiveDate <= Ddate AND Z.[PARKING OPS]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType IN ('PARKING OPS', 'ITICKET VIRTUAL','ITICKET PHYSICAL') AND CI.SiteReference = S.ZoneExternalReference
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneExternalReference,
			S.ZoneName,
			Z.PPSLiveDate,
			Z.PPSTermDate
		HAVING
			SUM(CASE WHEN CI.ContraventionID IS NOT NULL THEN 1 ELSE 0 END) = 0
	)


	,cte_UNION as
	(
		SELECT Dmonth, [Service], ZoneExternalReference, ZoneName, LiveDate, TermDate FROM cte_ANPR_ZonesNotIssued 
		UNION ALL
		SELECT Dmonth, [Service], ZoneExternalReference, ZoneName, LiveDate, TermDate FROM cte_PO_ZonesNotIssued 
		UNION ALL
		SELECT Dmonth, [Service], ZoneExternalReference, ZoneName, LiveDate, TermDate FROM cte_eCam_ZonesNotIssued 
	)


	SELECT * FROM cte_UNION
	WHERE dMonth < CONVERT(varchar(7), GETDATE(), 23) AND DMonth >= '2024-01'
	ORDER BY dMonth, [Service], ZoneName

	--SELECT * FROM cte_ANPR_ZonesNotIssued
	--WHERE dMonth ='2025-01'
	--ORDER BY ZoneName