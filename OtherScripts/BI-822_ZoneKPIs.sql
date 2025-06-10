	SET DATEFIRST 1;

	DECLARE @DateFrom AS DATE;
	DECLARE @DateTo AS DATE;

	SET @DateTo = EOMONTH(GETDATE(),0)
	SET @DateFrom = EOMONTH(DATEADD(MONTH, -25, GETDATE()),0)

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

	,cte_ANPR_ZonesEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			COUNT(DISTINCT(Z.ZoneID)) [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.ANPRTermDate > DDate AND Z.ANPRLiveDate <= Ddate AND Z.ANPR=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneID
	)	


	,cte_ANPR_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			COUNT(DISTINCT(Z.ZoneID)) [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.ANPRLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ANPRLiveDate <= Ddate AND Z.ANPR=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				  ZA.ANPRLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND ZA.ANPRTermDate >= dDate AND ZA.ANPR=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	
	,cte_ANPR_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			COUNT(DISTINCT(Z.ZoneID)) [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.ANPRTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ANPRTermDate <= Ddate AND Z.ANPR=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				 ZA.ANPRLiveDate <= dDate AND ZA.ANPRTermDate > dDate AND ZA.ANPR=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)
	
		
	,cte_ANPR_ZonesIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			COUNT(DISTINCT(S.ZoneID)) [ANPR_ZonesWithIssuedPCN],
			COUNT(*) [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType = 'ANPR'
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneExternalReference = CI.SiteReference AND S.[System] = 'Stella'
		WHERE
			DateIssued >= DATEADD(MONTH, -28, GETDATE())
		GROUP BY
			CONVERT(varchar(7), DDate, 23) 
	)
	

	,cte_ANPR_ConversionsInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			COUNT(DISTINCT(Z.ZoneID)) [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.ANPRLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ANPRLiveDate <= Ddate AND Z.ANPR=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				( 
					DATEADD(DAY, 30, ZA.PPSLiveDate) < Z.ANPRLiveDate AND ZA.[PARKING OPS]=1 
				)
				AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NOT NULL 
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)

	,cte_PO_ZonesEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			COUNT(DISTINCT(Z.ZoneID)) [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.PPSTermDate > DDate AND Z.PPSLiveDate <= Ddate AND Z.[PARKING OPS]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneID
	)	


	,cte_PO_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			COUNT(DISTINCT(Z.ZoneID)) [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.PPSLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.PPSLiveDate <= Ddate AND Z.[PARKING OPS]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				  ZA.PPSLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND ZA.PPSTermDate >= dDate AND ZA.[PARKING OPS]=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	


	,cte_PO_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			COUNT(DISTINCT(Z.ZoneID)) [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.PPSTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.PPSTermDate <= Ddate AND Z.[PARKING OPS]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				 ZA.PPSLiveDate <= dDate AND ZA.PPSTermDate > dDate AND ZA.[PARKING OPS]=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	

	,cte_PO_ZonesIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			COUNT(DISTINCT(S.ZoneID)) [PO_ZonesWithIssuedPCN],
			COUNT(*) [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType IN ('PARKING OPS', 'ITICKET VIRTUAL','ITICKET PHYSICAL')
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneExternalReference = CI.SiteReference AND S.[System] = 'Stella'
		WHERE
			DateIssued >= DATEADD(MONTH, -28, GETDATE())
		GROUP BY
			CONVERT(varchar(7), DDate, 23) 
	)

	,cte_ECAM_ZonesEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			COUNT(DISTINCT(Z.ZoneID)) [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamTermDate > DDate AND Z.eCamLiveDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneID
	)	


	,cte_ECAM_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			0 [ECAM_Zones(EOM)],
			COUNT(DISTINCT(Z.ZoneID)) [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.eCamLiveDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				  ZA.eCamLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND ZA.eCamTermDate >= dDate AND ZA.ECAM=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	

	,cte_ECAM_ConversionsInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			COUNT(DISTINCT(Z.ZoneID)) [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.eCamLiveDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				( 
					DATEADD(DAY, 30, ZA.PPSLiveDate) < Z.eCamLiveDate AND ZA.[PARKING OPS]=1 
				)
				AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NOT NULL 
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)

	,cte_ECAM_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			COUNT(DISTINCT(Z.ZoneID)) [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.eCamTermDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				 ZA.eCamLiveDate <= dDate AND ZA.eCamTermDate > dDate AND ZA.ECAM=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	

	,cte_ECAM_ZonesIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			COUNT(DISTINCT(S.ZoneID)) [ECAM_ZonesWithIssuedPCN],
			COUNT(*) [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType IN ('ECAM')
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneExternalReference = CI.SiteReference AND S.[System] = 'Stella'
		WHERE
			DateIssued >= DATEADD(MONTH, -28, GETDATE())
		GROUP BY
			CONVERT(varchar(7), DDate, 23) 
	)

	,cte_Total_ZonesEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			COUNT(DISTINCT(Z.ZoneID)) [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.CMTermDate > DDate AND Z.CMLiveDate <= Ddate AND Z.[CONTRAVENTION MANAGEMENT]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneID
	)	


	,cte_Total_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			COUNT(DISTINCT(Z.ZoneID)) [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.CMLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.CMLiveDate <= Ddate AND Z.[CONTRAVENTION MANAGEMENT]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				  ZA.CMLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND ZA.CMTermDate >= dDate AND ZA.[CONTRAVENTION MANAGEMENT]=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	


	,cte_Total_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			COUNT(DISTINCT(Z.ZoneID)) [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.CMTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.CMTermDate <= Ddate AND Z.[CONTRAVENTION MANAGEMENT]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
				 ZA.CMLiveDate <= dDate AND ZA.CMTermDate > dDate AND ZA.[CONTRAVENTION MANAGEMENT]=1 AND SA.ZoneID = S.ZoneID
			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	

	,cte_Total_ZonesIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			COUNT(DISTINCT(S.ZoneID)) [Total_ZonesWithIssuedPCN],
			COUNT(*) [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate 
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneExternalReference = CI.SiteReference AND S.[System] = 'Stella'
		WHERE
			DateIssued >= DATEADD(MONTH, -28, GETDATE())
		GROUP BY
			CONVERT(varchar(7), DDate, 23) 
	)

	,cte_Other_ZonesEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			COUNT(DISTINCT(Z.ZoneID)) [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON 
				(
					Z.STSTermDate > DDate AND Z.STSLiveDate <= Ddate AND Z.STS=1
				)
				OR
				(
					Z.ITICKETTermDate > DDate AND Z.ITICKETLiveDate <= Ddate AND Z.ITICKET=1
				)	
				OR
				(
					Z.ITICKETLITETermDate > DDate AND Z.ITICKETLITELiveDate <= Ddate AND Z.ITICKETLITE=1
				)
				OR
				(
					Z.STSNEWTermDate > DDate AND Z.STSNewLiveDate <= Ddate AND Z.STSNEW=1
				)
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.ZoneID
	)	


	,cte_Other_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,		
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			COUNT(DISTINCT(Z.ZoneID)) [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON 
			(
				Z.STSLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSLiveDate <= Ddate AND Z.STS=1
			)
			OR
			(
				Z.ITICKETLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETLiveDate <= Ddate AND Z.ITICKET=1
			)
			OR
			(
				Z.ITICKETLITELiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETLITELiveDate <= Ddate AND Z.ITICKETLITE=1
			)
			OR
			(
				Z.STSNewLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSNewLiveDate <= Ddate AND Z.STSNEW=1
			)
			
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
			(
				(
					Z.STSLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSTermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STS=1
				)
				OR
				(
					Z.ITICKETLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETTermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKET=1
				)
				OR
				(
					Z.ITICKETLITELiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETLITETermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETLITE=1
				)
				OR
				(
					Z.STSNewLiveDate < DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSNEWTermDate > DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSNEW=1
				)				  
			)	  
			AND SA.ZoneID = S.ZoneID

			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	


	,cte_Other_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			COUNT(DISTINCT(Z.ZoneID)) [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON 
			(			
				Z.STSTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSTermDate <= Ddate AND Z.STS=1
			)
			OR
			(
				Z.ITICKETTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETTermDate <= Ddate AND Z.ITICKET=1
			)
			OR
			(
				Z.ITICKETLITETermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.ITICKETLITETermDate <= Ddate AND Z.ITICKETLITE=1
			)
			OR
			(
				Z.STSNEWTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND Z.STSNEWTermDate <= Ddate AND Z.STSNEW=1
			)

		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		OUTER APPLY
		(
			SELECT
				COUNT(*) [TotalLive]
			FROM
				[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] ZA
			JOIN
				[BusinessIntelligence].[Statistics].[Sites] SA ON SA.ZoneID = ZA.ZoneID AND SA.[System] = 'Stella'
			WHERE
			(
				(
					Z.STSLiveDate <= DDate AND Z.STSTermDate > Ddate AND Z.STS=1
				)
				OR
				(
					Z.ITICKETLiveDate <= DDate AND Z.ITICKETTermDate > Ddate AND Z.ITICKET=1
				)	
				OR
				(
					Z.ITICKETLITELiveDate <= DDate AND Z.ITICKETLITETermDate > Ddate AND Z.ITICKETLITE=1
				)
				OR
				(
					Z.STSNewLiveDate <= DDate AND Z.STSNEWTermDate > Ddate AND Z.STSNEW=1
				)
			)
			AND SA.ZoneID = S.ZoneID

			GROUP BY
				SA.ZoneID
		) L
		WHERE
			[TotalLive] IS NULL
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
		
	)	

	,cte_Other_ZonesIssued AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			COUNT(DISTINCT(S.ZoneID)) [Other_ZonesWithIssuedPCN],
			COUNT(*) [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Contraventions_Issued] CI ON CI.DateIssued >= DATEFROMPARTS(YEAR(DDate), MONTH(dDate), 1) AND  CI.DateIssued <= Ddate AND CI.ServiceType IN ('ITICKET', 'ITICKET LITE', 'STS', 'STS VIRTUAL', 'STS PHYSICAL')
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneExternalReference = CI.SiteReference AND S.[System] = 'Stella'
		WHERE
			DateIssued >= DATEADD(MONTH, -28, GETDATE())
		GROUP BY
			CONVERT(varchar(7), DDate, 23) 
	)

	,cte_ANPR_LocationsEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			COUNT(DISTINCT(LocationID)) [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.ANPRTermDate > DDate AND Z.ANPRLiveDate <= Ddate AND Z.ANPR=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.LocationID
	)

	,cte_PO_LocationsEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			COUNT(DISTINCT(LocationID)) [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.PPSTermDate > DDate AND Z.PPSLiveDate <= Ddate AND Z.[PARKING OPS]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.LocationID
	)


	,cte_ECAM_LocationsEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
		0 [ANPR_Zones(EOM)],
		0 [ANPR_NewZonesInMonth],
		0 [ANPR_LostZonesInMonth],
		0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			COUNT(DISTINCT(LocationID)) [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamTermDate > DDate AND Z.eCamLiveDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.LocationID
	)

	,cte_Other_LocationsEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			COUNT(DISTINCT(LocationID)) [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON 
			(
				Z.STSTermDate > DDate AND Z.STSLiveDate <= Ddate AND Z.STS=1
			)
			OR
			(
				Z.ITICKETTermDate > dDate AND Z.ITICKETLiveDate <= Ddate AND Z.ITICKET=1
			)
			OR
			(
				Z.ITICKETLITETermDate > DDate AND Z.ITICKETLITELiveDate <= Ddate AND Z.ITICKETLITE=1
			)
			OR
			(
				Z.STSNEWTermDate > dDate AND Z.STSNewLiveDate <= Ddate AND Z.STSNEW=1
			)
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.LocationID
	)

	,cte_Total_LocationsEOM AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			COUNT(DISTINCT(LocationID)) [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			0 [PO_VisitedZones]

		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.CMTermDate > DDate AND Z.CMLiveDate <= Ddate AND Z.[CONTRAVENTION MANAGEMENT]=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		GROUP BY
			CONVERT(varchar(7), DDate, 23),
			S.LocationID
	)

	,cte_eCamData AS
	(
		SELECT
			CAST(C.Created as DATE) CreatedDate,
			ISNULL(CAST(C.Deleted as DATE),DATEADD(YEAR,1,GETDATE())) DeletedDate,
			C.ZoneID,
			C.ID,
			COUNT(DISTINCT(C.ID)) [TotalCameras]
		FROM
			[eCAM].[sqldb-ecam-prod-ukpc].[dbo].[Cameras] C
		LEFT JOIN
			[eCAM].[sqldb-ecam-prod-ukpc].[dbo].[CameraPhotos] CP ON C.ID = CP.CameraId
		WHERE
			CAST(C.Created as DATE) > '2022-01-01'
			AND C.ServiceType=0
			AND C.[Status]=0
		GROUP BY
			C.ID,
			CAST(C.Created as DATE),
			CAST(C.Deleted as DATE),
			C.ZoneID

	)

	,cte_ECAM_Cameras AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			SUM(E.TotalCameras) [ECAM_Cameras],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		LEFT JOIN
			[BusinessIntelligence].[Statistics].[Sites_ZoneActiveServices] Z ON Z.eCamTermDate > DDate AND Z.eCamLiveDate <= Ddate AND Z.ECAM=1
		JOIN
			[BusinessIntelligence].[Statistics].[Sites] S ON S.ZoneID = Z.ZoneID AND S.[System] = 'Stella'
		JOIN
			cte_eCamData E ON E.CreatedDate <= dDate AND E.DeletedDate > dDate AND E.ZoneID = S.ZoneID
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
	)	

	,cte_PO_VisitedZones AS
	(
		SELECT 
			CONVERT(varchar(7), DDate, 23) DMonth,
			0 [ANPR_Zones(EOM)],
			0 [ANPR_NewZonesInMonth],
			0 [ANPR_LostZonesInMonth],
			0 [ANPR_ZonesWithIssuedPCN],
			0 [ANPR_ZonesPCNsIssued],
			0 [ANPR_ZonesConversions],
			0 [PO_Zones(EOM)],
			0 [PO_NewZonesInMonth],
			0 [PO_LostZonesInMonth],
			0 [PO_ZonesWithIssuedPCN],
			0 [PO_ZonesPCNsIssued],
			0 [ECAM_Zones(EOM)],
			0 [ECAM_NewZonesInMonth],
			0 [ECAM_LostZonesInMonth],
			0 [ECAM_ZonesWithIssuedPCN],
			0 [ECAM_ZonesPCNsIssued],
			0 [ECAM_ZonesConversions],
			0 [Total_Zones(EOM)],
			0 [Total_NewZonesInMonth],
			0 [Total_LostZonesInMonth],
			0 [Total_ZonesWithIssuedPCN],
			0 [Total_ZonesPCNsIssued],
			0 [Other_Zones(EOM)],
			0 [Other_NewZonesInMonth],
			0 [Other_LostZonesInMonth],
			0 [Other_ZonesWithIssuedPCN],
			0 [Other_ZonesPCNsIssued],
			0 [ANPR_Locations(EOM)],
			0 [PO_Locations(EOM)],
			0 [ECAM_Locations(EOM)],
			0 [Other_Locations(EOM)],
			0 [Total_Locations(EOM)],
			0 [ECAM_Cameras],
			--COUNT(DISTINCT([ZoneId])) [PO_VisitedZones],
			0 [PO_VisitedZones]
		FROM 
			cte_Dates D
		--JOIN
			--[BusinessIntelligence].[Reporting].[POSiteVisits] P ON CONVERT(varchar(7), P.[Date],23) = D.DDate
		GROUP BY
			CONVERT(varchar(7), DDate, 23)
	)	




	,cte_Totals AS
	(

		SELECT * FROM cte_ANPR_ZonesEOM
		UNION ALL
		SELECT * FROM cte_ANPR_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_ANPR_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_ANPR_ZonesIssued
		UNION ALL
		SELECT * FROM cte_ANPR_ConversionsInMonth
		UNION ALL
		SELECT * FROM cte_PO_ZonesEOM
		UNION ALL
		SELECT * FROM cte_PO_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_PO_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_PO_ZonesIssued
		UNION ALL
		SELECT * FROM cte_ECAM_ZonesEOM
		UNION ALL
		SELECT * FROM cte_ECAM_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_ECAM_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_ECAM_ConversionsInMonth
		UNION ALL
		SELECT * FROM cte_ECAM_ZonesIssued
		UNION ALL
		SELECT * FROM cte_Total_ZonesEOM
		UNION ALL
		SELECT * FROM cte_Total_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_Total_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_Total_ZonesIssued
		UNION ALL
		SELECT * FROM cte_Other_ZonesEOM
		UNION ALL
		SELECT * FROM cte_Other_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_Other_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_Other_ZonesIssued
		UNION ALL
		SELECT * FROM cte_ANPR_LocationsEOM
		UNION ALL
		SELECT * FROM cte_PO_LocationsEOM
		UNION ALL
		SELECT * FROM cte_ECAM_LocationsEOM
		UNION ALL
		SELECT * FROM cte_Other_LocationsEOM
		UNION ALL
		SELECT * FROM cte_Total_LocationsEOM
		UNION ALL
		SELECT * FROM cte_ECAM_Cameras
		UNION ALL
		SELECT * FROM cte_PO_VisitedZones
	)



	SELECT
		DMonth,
		SUM([PO_Zones(EOM)]) [PO Sites (EOM)],
		SUM([PO_NewZonesInMonth]) [PO New sites in month],
		SUM([PO_LostZonesInMonth]) [PO Lost sites in month],
		SUM([PO_ZonesWithIssuedPCN]) [PO_ZonesWithIssuedPCN],
		SUM([PO_Locations(EOM)]) [PO_Locations(EOM))],
		SUM([PO_ZonesPCNsIssued]) [PO_ZonesPCNsIssued],
		SUM(PO_VisitedZones) [PO_VisitedZones],
		0 [PO_Zones_PCNsPerPO],

		SUM([ANPR_Zones(EOM)]) [ANPR_Zones(EOM)],
		SUM([ANPR_NewZonesInMonth]) - SUM([ANPR_ZonesConversions]) [ANPR_NewZonesInMonthMinusConversions],
		SUM([ANPR_NewZonesInMonth]) [ANPR_NewZonesInMonth],
		SUM([ANPR_ZonesConversions]) [ANPR_ZonesConversions],
		SUM([ANPR_LostZonesInMonth]) [ANPR_LostZonesInMonth],
		SUM([ANPR_ZonesWithIssuedPCN]) [ANPR_ZonesWithIssuedPCN],
		SUM([ANPR_Locations(EOM)]) [ANPR_Locations(EOM))],
		SUM([ANPR_ZonesPCNsIssued]) [ANPR_ZonesPCNsIssued],
		0 [ANPR_Cameras],

		SUM([ECAM_Zones(EOM)]) [ECAM_Zones(EOM)],
		SUM([ECAM_NewZonesInMonth]) - SUM([ECAM_ZonesConversions]) [ECAM_NewZonesInMonthMinusConversions],
		SUM([ECAM_NewZonesInMonth]) [ECAM_NewZonesInMonth],
		SUM([ECAM_ZonesConversions]) [ECAM_ZonesConversions],
		SUM([ECAM_LostZonesInMonth]) [ECAM_LostZonesInMonth],
		SUM([ECAM_ZonesWithIssuedPCN]) [ECAM_ZonesWithIssuedPCN],
		SUM([ECAM_Locations(EOM)]) [ECAM_Locations(EOM))],
		SUM([ECAM_ZonesPCNsIssued]) [ECAM_ZonesPCNsIssued],
		SUM([ECAM_Cameras]) [ECAM_Cameras],

		SUM([Other_Zones(EOM)]) [Other_Zones(EOM)],
		SUM([Other_NewZonesInMonth]) [Other_NewZonesInMonth],
		SUM([Other_LostZonesInMonth]) [Other_LostZonesInMonth],
		SUM([Other_ZonesWithIssuedPCN]) [Other_ZonesWithIssuedPCN],
		SUM([Other_Locations(EOM)]) [Other_Locations(EOM))],
		SUM([Other_ZonesPCNsIssued]) [Other_ZonesPCNsIssued],

		SUM([Total_Zones(EOM)]) [Total_Zones(EOM)],
		SUM([Total_NewZonesInMonth]) [Total_NewZonesInMonth],
		SUM([Total_LostZonesInMonth]) [Total_LostZonesInMonth],
		SUM([Total_ZonesWithIssuedPCN]) [Total_ZonesWithIssuedPCN],
		SUM([Total_Locations(EOM)]) [Total_Locations(EOM))],
		SUM([Total_ZonesPCNsIssued]) [Total_ZonesPCNsIssued]

		
	FROM
		cte_Totals
	GROUP BY
		DMonth
	ORDER BY
		DMonth





	
