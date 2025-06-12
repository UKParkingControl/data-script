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

-- Chèn kết quả từ stored procedure vào bảng tạm
INSERT INTO #TempGetContraventionsByFuzzyMatchIds
EXEC Reporting.GetContraventionsByFuzzyMatchIds;

-- Sau đó bạn có thể select
SELECT 
Reference AS ContraventionNumber,
InDateTime AS dMonth, 
'ANPR' ServiceType, 
PCNStatus AS ContraventionStatus 
FROM #TempGetContraventionsByFuzzyMatchIds
ORDER BY InDateTime;