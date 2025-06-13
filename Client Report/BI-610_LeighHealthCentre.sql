--Report 1: ANPR move in with/without permit
WITH CurrentQuarter AS (
   SELECT 
       DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0) AS StartDate,
       EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0))) AS EndDate
),
Numbers AS (
    SELECT 0 AS DayOffset UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
DateRange AS (
    SELECT DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, cq.StartDate) AS DateValue
    FROM Numbers n1
    CROSS JOIN Numbers n2
    CROSS JOIN CurrentQuarter cq
    WHERE DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, cq.StartDate) <= cq.EndDate
),
Move_In AS
(
	SELECT
	CAST(am.ReadDateTime AS DATE) Date,
	Plate ,
	case when wl_single.VrnNumber is not null then 1 else 0 end IsPermitted
	FROM AnprTechOps.dbo.AnprMovements AS am
	JOIN AnprTechOps.dbo.Devices D WITH (NOLOCK) ON am.DeviceId = D.Id
	OUTER APPLY
	(SELECT TOP 1 wl.VrnNumber, wl.[From], wl.[To]
	FROM VehicleList.dbo.WhiteLists wl 
	JOIN VehicleList.dbo.Permits p on p.Id = wl.PermitsId 
	JOIN VehicleList.dbo.Scopes s 
	on s.PermitId = p.Id 
	and s.WhiteListId IS NULL
	AND (
	(s.ScopeType = 1 AND s.ScopeId = 29)
	OR (s.ScopeType = 3 AND s.ScopeId = 1836)
	OR (s.ScopeType = 4 AND s.ScopeId = 1906)
	)
	WHERE VrnNumber = am.Plate AND am.ReadDateTime between [From] AND [To]
	) wl_single
	where am.LocationId = 608
	AND direction=1
)
select DateRange.DateValue [Date],
COALESCE (SUM (1-IsPermitted), 0) NoPermit,
COALESCE (SUM (IsPermitted),0) Permit,
COALESCE (COUNT(IsPermitted),0) Total
FROM Move_In
RIGHT JOIN DateRange ON Move_In.[Date]=DateRange.DateValue
GROUP BY DateRange.DateValue
order by DateRange.DateValue asc

-- Report 2: Staying time
WITH CurrentQuarter AS (
	SELECT 
     DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0) AS StartDate,
     EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0))) AS EndDate
),
Numbers AS (
    SELECT 0 AS DayOffset UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
DateRange AS (
    SELECT DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, cq.StartDate) AS DateValue
    FROM Numbers n1
    CROSS JOIN Numbers n2
    CROSS JOIN CurrentQuarter cq
    WHERE DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, cq.StartDate) <= cq.EndDate
),
Stay_Duration AS (
	SELECT 	
	DateValue,
	Plate,
	case when wl_single.VrnNumber is not null then 1 else 0 end IsPermit,
	CASE WHEN DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsVisit,
	CASE 
		WHEN CAST(InDateTime AS DATE) = DateValue AND CAST(OutDateTime as DATE) = DateValue THEN DATEDIFF(SECOND,InDateTime, OutDateTime)
		WHEN CAST(InDateTime AS DATE) < DateValue AND CAST(OutDateTime as DATE) > DateValue THEN 86400
		WHEN CAST(InDateTime AS DATE) < DateValue AND CAST(OutDateTime as DATE) = DateValue THEN DATEDIFF(SECOND,'00:00:00', CAST(OutDateTime as TIME))
		WHEN CAST(InDateTime AS DATE) = DateValue AND CAST(OutDateTime as DATE) > DateValue THEN DATEDIFF(SECOND, CAST(InDateTime as TIME), '23:59:59') + 1
		ELSE 0 
	END StayDuration,
	CASE WHEN StayDuration BETWEEN 0 AND 3599 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_0_1,
	CASE WHEN StayDuration BETWEEN 3600 AND 7199 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_1_2,
	CASE WHEN StayDuration BETWEEN 7200 AND 10799 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_2_3,
	CASE WHEN StayDuration BETWEEN 10800 AND 14399 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_3_4,
	CASE WHEN StayDuration BETWEEN 14400 AND 17999 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_4_5,
	CASE WHEN StayDuration BETWEEN 18000 AND 21599 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_5_6,
	CASE WHEN StayDuration >= 21600 AND DateValue = CAST(InDateTime as DATE) THEN 1 ELSE 0 END AS IsStayDurationByHour_Over_6
	FROM DateRange D
	LEFT JOIN AnprTechOps.dbo.AnprMatches am with (NOLOCK)  ON D.DateValue >= CAST(am.InDateTime AS DATE) AND D.DateValue <= CAST(am.OutDateTime AS DATE) 
	OUTER APPLY
	(SELECT TOP 1 wl.VrnNumber, wl.[From], wl.[To]
	FROM VehicleList.dbo.WhiteLists wl 
	JOIN VehicleList.dbo.Permits p on p.Id = wl.PermitsId 
	JOIN VehicleList.dbo.Scopes s 
	on s.PermitId = p.Id 
	and s.WhiteListId IS NULL
	AND (
	(s.ScopeType = 1 AND s.ScopeId = 29)
	OR (s.ScopeType = 3 AND s.ScopeId = 1836)
	OR (s.ScopeType = 4 AND s.ScopeId = 1906)
	)
	WHERE VrnNumber = am.Plate AND am.InDateTime between [From] AND [To] AND am.OutDateTime between [From] AND [To]
	) wl_single	
	WHERE LocationId = 608
	AND am.StatusId = 0 AND am.StayDuration < (60 * 60 * 24 * 7)
)
SELECT dr.DateValue Date,
2 IsPermit, 
SUM (StayDuration) SumStayDuration,
SUM (IsVisit) AS VisitCount,
SUM (IsStayDurationByHour_0_1) QtyStayDuration_0_1,
SUM (IsStayDurationByHour_0_1) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_0_1,
SUM (IsStayDurationByHour_1_2) QtyStayDuration_1_2,
SUM (IsStayDurationByHour_1_2) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_1_2,
SUM (IsStayDurationByHour_2_3) QtyStayDuration_2_3,
SUM (IsStayDurationByHour_2_3) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_2_3,
SUM (IsStayDurationByHour_3_4) QtyStayDuration_3_4,
SUM(IsStayDurationByHour_3_4) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_3_4,
SUM (IsStayDurationByHour_4_5) QtyStayDuration_4_5,
SUM (IsStayDurationByHour_4_5) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_4_5,
SUM (IsStayDurationByHour_5_6) QtyStayDuration_5_6,
SUM (IsStayDurationByHour_5_6) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_5_6,
SUM (IsStayDurationByHour_Over_6) QtyStayDuration_over_6,
SUM (IsStayDurationByHour_Over_6) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_over_6,
SUM (StayDuration) / SUM (IsVisit) AvgLengthOfVisit
FROM DateRange dr
LEFT JOIN Stay_Duration sd on dr.DateValue = sd.DateValue
group by dr.DateValue
UNION ALL
SELECT dr.DateValue Date,
COALESCE (IsPermit,-1), 
SUM (StayDuration) SumStayDuration,
SUM (IsVisit) AS VisitCount,
SUM (IsStayDurationByHour_0_1) QtyStayDuration_0_1,
SUM (IsStayDurationByHour_0_1) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_0_1,
SUM (IsStayDurationByHour_1_2) QtyStayDuration_1_2,
SUM (IsStayDurationByHour_1_2) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_1_2,
SUM (IsStayDurationByHour_2_3) QtyStayDuration_2_3,
SUM (IsStayDurationByHour_2_3) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_2_3,
SUM (IsStayDurationByHour_3_4) QtyStayDuration_3_4,
SUM (IsStayDurationByHour_3_4) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_3_4,
SUM (IsStayDurationByHour_4_5) QtyStayDuration_4_5,
SUM (IsStayDurationByHour_4_5) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_4_5,
SUM (IsStayDurationByHour_5_6) QtyStayDuration_5_6,
SUM (IsStayDurationByHour_5_6) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_5_6,
SUM (IsStayDurationByHour_Over_6) QtyStayDuration_over_6,
SUM (IsStayDurationByHour_Over_6) * 1.0 / NULLIF(SUM(IsVisit), 0) PercentStayDuration_over_6,
SUM (StayDuration) / SUM (IsVisit) AvgLengthOfVisit
FROM DateRange dr
LEFT JOIN Stay_Duration sd on dr.DateValue = sd.DateValue
group by dr.DateValue, IsPermit
order by dr.DateValue asc;

--Report 3: PCNs
WITH Numbers AS (
    SELECT 0 AS DayOffset UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
DateRange AS (
    SELECT DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)) AS DateValue
    FROM Numbers n1
    CROSS JOIN Numbers n2
    WHERE DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)) <=
        EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)))
),
IssuedPCNs AS (
    SELECT *
    FROM OPENQUERY([StellaProduction], '
        SELECT 
            CAST(c.FirstIssuedDate AS DATE) AS ReportDate,
            COUNT(DISTINCT c.Id) AS TotalIssuedPCNs,
            COUNT(DISTINCT CASE WHEN c.CancellationReasonId IS NOT NULL THEN c.Id END) AS CancelledPCNs,
            COUNT(DISTINCT ap.Id) AS AppealedPCNs,
            COUNT(DISTINCT il.Id) AS IssuedLetterPCNs
        FROM cm.Contraventions c
        INNER JOIN sm.Zones z ON c.ZoneId = z.Id AND z.LocationId = 1836
        LEFT JOIN (
            SELECT DISTINCT a.ContraventionId AS Id
            FROM cm.Accounts a
            INNER JOIN cm.Appeals ap ON ap.AccountId = a.Id
        ) ap ON ap.Id = c.Id
        LEFT JOIN (
            SELECT DISTINCT a.ContraventionId AS Id
            FROM cm.Accounts a
            INNER JOIN cm.AccountActions aa ON aa.AccountId = a.Id
            WHERE aa.WorkflowActionId IN (
                SELECT Id FROM cm.WorkflowActions WHERE ActionType = 2
            )
        ) il ON il.Id = c.Id
        WHERE c.FirstIssuedDate >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
        AND c.FirstIssuedDate <= EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)))
        GROUP BY CAST(c.FirstIssuedDate AS DATE)
    ')
),
CreatedPCNs AS (
    SELECT *
    FROM OPENQUERY([StellaProduction], '
        SELECT 
            CAST(c.Created AS DATE) AS ReportDate,
            COUNT(DISTINCT CASE WHEN cr.[Group] = ''Client Cancellation'' THEN c.Id END) AS CancelByClient,
            COUNT(DISTINCT CASE WHEN cr.[Group] != ''Client Cancellation'' THEN c.Id END) AS CancelByUKPC
        FROM cm.Contraventions c
        INNER JOIN sm.Zones z ON c.ZoneId = z.Id AND z.LocationId = 1836
        LEFT JOIN cm.CancellationReasons cr ON c.CancellationReasonId = cr.Id
        WHERE c.Created >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
        AND c.Created <= EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)))
        GROUP BY CAST(c.Created AS DATE)
    ')
)
SELECT 
    CONCAT('Quarter ', DATEPART(QUARTER, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)), ' - ', YEAR(DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0))) AS Quarter,
    d.DateValue AS ReportDate,
    COALESCE(i.TotalIssuedPCNs, 0) AS TotalIssuedPCNs,
    COALESCE(i.CancelledPCNs, 0) AS CancelledPCNs,
    COALESCE(i.AppealedPCNs, 0) AS AppealedPCNs,
    COALESCE(i.IssuedLetterPCNs, 0) AS IssuedLetterPCNs,
    COALESCE(c.CancelByClient, 0) AS CancelByClient,
    COALESCE(c.CancelByUKPC, 0) AS CancelByUKPC
FROM DateRange d
LEFT JOIN IssuedPCNs i ON d.DateValue = i.ReportDate
LEFT JOIN CreatedPCNs c ON d.DateValue = c.ReportDate
ORDER BY ReportDate ASC

-- Report 4: Contraventions
WITH Numbers AS (
    SELECT 0 AS DayOffset UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
DateRange AS (
    SELECT DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)) AS DateValue
    FROM Numbers n1
    CROSS JOIN Numbers n2
    WHERE DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0))
          <= EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)))
),
ContraventionList AS (
    SELECT *
    FROM OPENQUERY([StellaProduction], '
        SELECT
            CAST(cc.EventDateTime as DATE) AS IssuedDate,
            ISNULL(ccr.Code, ''N/A'') AS ReasonCode,
            ISNULL(ccrt.Summary, ''No reason specified'') AS Reason,
            COUNT(cc.Id) AS PCNCount
        FROM cm.Contraventions cc 
        LEFT JOIN cm.ContraventionReasons ccr ON cc.ReasonId = ccr.Id
        LEFT JOIN cm.ContraventionReasonTranslations ccrt ON ccr.Id = ccrt.ContraventionReasonId
        INNER JOIN sm.Locations sl ON cc.LocationId = sl.Id
        WHERE sl.Id = 1836
        AND cc.EventDateTime >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
        AND cc.EventDateTime <= EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)))
        AND cc.FirstIssuedDate IS NOT NULL
        GROUP BY 
            CAST(cc.EventDateTime as DATE),
            ccr.Code, 
            ccrt.Summary
    ')
),
AllDate AS (
    SELECT DateValue, ReasonCode, Reason, 0 AS PCNCount
    FROM (SELECT DISTINCT ReasonCode, Reason FROM ContraventionList) cl
    CROSS JOIN DateRange
)
SELECT 
    ad.DateValue AS IssuedDate, 
    ad.ReasonCode, 
    ad.Reason, 
    COALESCE(cl.PCNCount, 0) AS PCNCount
FROM AllDate ad
LEFT JOIN ContraventionList cl 
    ON ad.DateValue = cl.IssuedDate AND ad.ReasonCode = cl.ReasonCode
ORDER BY ad.DateValue ASC;

-- Report 5: Revenue
WITH Numbers AS (
    SELECT 0 AS DayOffset UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
),
QuarterDates AS (
    SELECT 
        DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0) AS StartDate,
        EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0))) AS EndDate
),
DateRange AS (
    SELECT DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, qd.StartDate) AS DateValue
    FROM Numbers n1
    CROSS JOIN Numbers n2
    CROSS JOIN QuarterDates qd
    WHERE DATEADD(DAY, n1.DayOffset + 10*n2.DayOffset, qd.StartDate) <= qd.EndDate
),
RevenueList AS (
    SELECT *
    FROM OPENQUERY([StellaProduction], '
        SELECT
            CAST(t.Created AS DATE) AS PaymentDate,
            -SUM(t.Amount) AS Revenue
        FROM cm.AccountTransactions t
        JOIN cm.Accounts a ON t.AccountId = a.Id
        JOIN cm.Contraventions c ON a.ContraventionId = c.Id
        JOIN sm.Zones z ON c.ZoneId = z.Id
        WHERE t.TransactionType IN (0, 1, 2, 3, 6, 7)
        AND t.Deleted IS NULL
        AND z.LocationId = 1836
        AND t.Created >= DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)
        AND t.Created <= EOMONTH(DATEADD(MONTH, 2, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, GETDATE()) - 1, 0)))
        GROUP BY CAST(t.Created AS DATE)
    ')
)
SELECT 
    dr.DateValue AS PaymentDate, 
    MONTH(dr.DateValue) AS MonthID, 
    DATENAME(MONTH, dr.DateValue) AS PaymentMonth, 
    COALESCE(rl.Revenue, 0) AS Revenue
FROM DateRange dr
LEFT JOIN RevenueList rl ON dr.DateValue = rl.PaymentDate
ORDER BY dr.DateValue ASC;
