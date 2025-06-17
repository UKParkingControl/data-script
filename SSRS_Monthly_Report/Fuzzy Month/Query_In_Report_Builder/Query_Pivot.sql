CREATE TABLE #TempGetContraventionsByFuzzyMatchIds (
    Reference NVARCHAR(1024),
    Plate NVARCHAR(1024),
    InDateTime DATETIME,
    OutDateTime DATETIME,
    EventDateTime DATETIME,
    Reason NVARCHAR(1024),
    PCNStatus NVARCHAR(1024),
    DaysInProgress INT,
    FirstIssuedDate DATETIME
);

INSERT INTO #TempGetContraventionsByFuzzyMatchIds
EXEC Reporting.GetContraventionsByFuzzyMatchIds;

SELECT 
FORMAT(InDateTime, 'yyyy-MM') AS [YearMonth],
PCNStatus AS ContraventionStatus,
COUNT(*) AS PCNs
FROM #TempGetContraventionsByFuzzyMatchIds
GROUP BY FORMAT(InDateTime, 'yyyy-MM'), PCNStatus
ORDER BY FORMAT(InDateTime, 'yyyy-MM');

DROP TABLE IF EXISTS #TempGetContraventionsByFuzzyMatchIds;



-- CREATE TABLE #TempGetContraventionsByFuzzyMatchIds (
--     Reference NVARCHAR(1024),
--     Plate NVARCHAR(1024),
--     InDateTime DATETIME,
--     OutDateTime DATETIME,
--     EventDateTime DATETIME,
--     Reason NVARCHAR(1024),
--     PCNStatus NVARCHAR(1024),
--     DaysInProgress INT,
--     FirstIssuedDate DATETIME
-- );

-- INSERT INTO #TempGetContraventionsByFuzzyMatchIds
-- EXEC Reporting.GetContraventionsByFuzzyMatchIds;

-- -- Combine all results into a single result set with a Type column
-- SELECT 
--     [Label],
--     ISNULL([SubLabel], [Label]) AS [SubLabel],
--     TotalPCNs,
--     [Type]
-- FROM (
--     SELECT 
--         CAST(YEAR(InDateTime) AS NVARCHAR(10)) AS [Label],
--         NULL AS [SubLabel],
--         COUNT(*) AS TotalPCNs,
--         'Year' AS [Type]
--     FROM #TempGetContraventionsByFuzzyMatchIds
--     GROUP BY YEAR(InDateTime)

--     UNION ALL

--     SELECT 
--         CAST(YEAR(InDateTime) AS NVARCHAR(10)) AS [Label],
--         DATENAME(MONTH, InDateTime) AS [SubLabel],
--         COUNT(*) AS TotalPCNs,
--         'Month' AS [Type]
--     FROM #TempGetContraventionsByFuzzyMatchIds
--     GROUP BY YEAR(InDateTime), DATENAME(MONTH, InDateTime), MONTH(InDateTime)

--     UNION ALL

--     SELECT 
--         CAST(YEAR(InDateTime) AS NVARCHAR(10)) AS [Label],
--         PCNStatus AS [SubLabel],
--         COUNT(*) AS TotalPCNs,
--         'Status' AS [Type]
--     FROM #TempGetContraventionsByFuzzyMatchIds
--     GROUP BY YEAR(InDateTime), PCNStatus
-- ) AS CombinedResults
-- ORDER BY 
--     [Label] DESC, 
--     CASE [Type] 
--         WHEN 'Year' THEN 0
--         WHEN 'Month' THEN 1
--         WHEN 'Status' THEN 2
--         ELSE 3
--     END,
--     CASE WHEN [Type] = 'Month' THEN 
--         CASE 
--             WHEN ISDATE([Label] + ' ' + [SubLabel] + ' 01') = 1 
--                 THEN DATEPART(MONTH, CAST([Label] + ' ' + [SubLabel] + ' 01' AS DATETIME))
--             ELSE 0
--         END
--     ELSE 0 END,
--     ISNULL([SubLabel], [Label]);
