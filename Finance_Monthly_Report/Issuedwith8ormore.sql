;WITH cte_Multiples AS (

		SELECT DISTINCT(Plate), Total FROM
		(
			SELECT
				Plate,
				COUNT(*) Total
			FROM
				cm.Contraventions
			WHERE
				[status] IN (0,3,4)
			GROUP BY
				Plate
			HAVING
				COUNT(*) >= 8
		) t
	)
  
	SELECT
		CONVERT(varchar(10), eventdatetime, 23) ContraventionDate,
		C.FirstIssuedDate,
		Reference,
		C.Plate,
		T.DisplayName [ServiceType],
		ISNULL(M.Total,1) OpenPCNs,
		Z.Name [ZoneName],
		S.DisplayName [ContraventionStatus]
		--COUNT(*) TotalIssued
	FROM
		cm.contraventions C
	JOIN
		common.EnumValues T ON T.TableName = 'cm.contraventions' AND T.ColumnName = 'type'AND T.NumericValue = C.[Type]
	JOIN
		common.EnumValues S ON S.TableName = 'cm.contraventions' AND S.ColumnName = 'status' AND S.NumericValue = C.[Status]
	JOIN
		cte_Multiples M ON M.Plate = C.Plate
	JOIN
		sm.zones Z ON Z.ID = C.ZoneId
	WHERE
		C.FirstIssuedDate IS NOT NULL
		AND C.EventDateTime >= '2025-01-01'
		AND C.EventDateTime < '2025-05-01'
	--GROUP BY
		--CONVERT(varchar(7), eventdatetime, 23)
	ORDER BY
		CONVERT(varchar(7), eventdatetime, 23)
