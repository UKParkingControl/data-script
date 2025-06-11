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


	,cte_ANPR_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'ANPR' [ServiceType],
			'New' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.ANPRLiveDate [ServiceLiveDate],
			Z.ANPRTermDate [ServiceTermDate]
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
		
	)	

	,cte_ANPR_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'ANPR' [ServiceType],
			'Termination' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.ANPRLiveDate [ServiceLiveDate],
			Z.ANPRTermDate [ServiceTermDate]
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

		
	)
	
	,cte_PO_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'PPS' [ServiceType],
			'New' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.PPSLiveDate [ServiceLiveDate],
			Z.PPSTermDate [ServiceTermDate]
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

	)	


	,cte_PO_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'PPS' [ServiceType],
			'Termination' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.PPSLiveDate [ServiceLiveDate],
			Z.PPSTermDate [ServiceTermDate]			
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

		
	)	

	,cte_ECAM_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'ECAM' [ServiceType],
			'New' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.eCamLiveDate [ServiceLiveDate],
			Z.eCamTermDate [ServiceTermDate]	
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

		
	)	

	,cte_ECAM_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'ECAM' [ServiceType],
			'Termination' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
			Z.eCamLiveDate [ServiceLiveDate],
			Z.eCamTermDate [ServiceTermDate]			
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

		
	)	



	,cte_Other_NewZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,		
			'OTHER' [ServiceType],
			'New' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
	    CASE
        WHEN Z.STSLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSLiveDate <= DDate AND Z.STS = 1 THEN Z.STSLiveDate
        WHEN Z.ITICKETLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETLiveDate <= DDate AND Z.ITICKET = 1 THEN Z.ITICKETLiveDate
        WHEN Z.ITICKETLITELiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETLITELiveDate <= DDate AND Z.ITICKETLITE = 1 THEN Z.ITICKETLITELiveDate
        WHEN Z.STSNewLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSNewLiveDate <= DDate AND Z.STSNEW = 1 THEN Z.STSNewLiveDate
        ELSE NULL
    END AS ServiceLiveDate,
    CASE
        WHEN Z.STSLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSLiveDate <= DDate AND Z.STS = 1 THEN Z.STSTermDate
        WHEN Z.ITICKETLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETLiveDate <= DDate AND Z.ITICKET = 1 THEN Z.ITICKETTermDate
        WHEN Z.ITICKETLITELiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETLITELiveDate <= DDate AND Z.ITICKETLITE = 1 THEN Z.ITICKETLITETermDate
        WHEN Z.STSNewLiveDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSNewLiveDate <= DDate AND Z.STSNEW = 1 THEN Z.STSNEWTermDate
        ELSE NULL	END AS ServiceTermDate		
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

	)	


	,cte_Other_LostZonesInMonth AS
	(
		SELECT
			CONVERT(varchar(7), DDate, 23) DMonth,
			'OTHER' [ServiceType],
			'Termination' [Type],
			S.ZoneExternalReference,
			S.ZoneName,
 CASE
        WHEN Z.STSTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSTermDate <= DDate AND Z.STS = 1 THEN Z.STSLiveDate
        WHEN Z.ITICKETTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETTermDate <= DDate AND Z.ITICKET = 1 THEN Z.ITICKETLiveDate
        WHEN Z.ITICKETLITETermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETLITETermDate <= DDate AND Z.ITICKETLITE = 1 THEN Z.ITICKETLITELiveDate
        WHEN Z.STSNEWTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSNEWTermDate <= DDate AND Z.STSNEW = 1 THEN Z.STSNewLiveDate
        ELSE NULL
    END AS ServiceLiveDate,
 CASE
        WHEN Z.STSTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSTermDate <= DDate AND Z.STS = 1 THEN Z.STSTermDate
        WHEN Z.ITICKETTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETTermDate <= DDate AND Z.ITICKET = 1 THEN Z.ITICKETTermDate
        WHEN Z.ITICKETLITETermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.ITICKETLITETermDate <= DDate AND Z.ITICKETLITE = 1 THEN Z.ITICKETLITETermDate
        WHEN Z.STSNEWTermDate >= DATEFROMPARTS(YEAR(DDate), MONTH(DDate), 1)
             AND Z.STSNEWTermDate <= DDate AND Z.STSNEW = 1 THEN Z.STSNEWTermDate
        ELSE NULL
    END AS ServiceTermDate
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
		
	)	




	,cte_Totals AS
	(

		SELECT * FROM cte_ANPR_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_ANPR_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_PO_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_PO_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_ECAM_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_ECAM_LostZonesInMonth
		UNION ALL
		SELECT * FROM cte_Other_NewZonesInMonth
		UNION ALL
		SELECT * FROM cte_Other_LostZonesInMonth
	)



	SELECT
		*

		
	FROM
		cte_Totals
	--WHERE dMonth < CONVERT(varchar(7), GETDATE(), 23)
	ORDER BY
		DMonth





	
