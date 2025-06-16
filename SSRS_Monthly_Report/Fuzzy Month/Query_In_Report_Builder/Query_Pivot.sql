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
COUNT(0) PCNs
FROM #TempGetContraventionsByFuzzyMatchIds
GROUP BY FORMAT(InDateTime, 'yyyy-MM'), PCNStatus
Order by FORMAT(InDateTime, 'yyyy-MM')