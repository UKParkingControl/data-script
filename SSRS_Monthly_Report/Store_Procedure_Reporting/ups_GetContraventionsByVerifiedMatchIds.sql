CREATE PROCEDURE GetContraventionsByVerifiedMatchIds
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @matchIdList NVARCHAR(MAX);

    -- Create MatchId
    SELECT @matchIdList = STRING_AGG(CONVERT(NVARCHAR(50), MatchId), ',') 
    FROM (
        SELECT DISTINCT ao.MatchId
        FROM AnprTechOps.bespoke.AnprOverstays ao
        JOIN AnprTechOps.bespoke.CustomVerifications cv ON cv.AnprOverstayId = ao.Id 
        JOIN AnprTechOps.dbo.AnprMatches am ON am.Id = ao.MatchId
        JOIN AnprTechOps.dbo.AnprMovements mov ON (am.InId = mov.Id OR am.OutId = mov.Id)
        WHERE (cv.Outcome = 'NewPlate' OR (cv.Step = 2 AND cv.Outcome = 'Approved'))
            AND ao.StatusId = 20
            AND am.InDateTime > '2024-11-01'
            AND am.StatusId = 0
    ) AS filtered;

    -- Trường hợp không có MatchId
    IF @matchIdList IS NULL
    BEGIN
        PRINT 'MatchId is null';
        RETURN;
    END

    -- Câu lệnh OPENQUERY
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = '
    SELECT * 
    FROM OPENQUERY([StellaProduction], ''
        SELECT 
            c.Reference,
            c.Plate,
            cda.InDateTime,
            cda.OutDateTime,
            c.EventDateTime,
            crt.Summary AS Reason,
            CASE 
                WHEN c.Status = 0 THEN ''''Open''''
                WHEN c.Status = 1 THEN ''''Paid''''
                WHEN c.Status = 2 THEN ''''Cancelled''''
                WHEN c.Status = 3 THEN ''''Timeout''''
                ELSE ''''Paused''''
            END AS [PCN Status],
            a.DaysInProgress,
            c.FirstIssuedDate
        FROM [sqldb-stella-prod].cm.Contraventions c
        JOIN [sqldb-stella-prod].cm.ContraventionDetailsAnpr cda ON c.Id = cda.ContraventionId
        JOIN [sqldb-stella-prod].cm.ContraventionReasonTranslations crt ON crt.ContraventionReasonId = c.ReasonId
        JOIN [sqldb-stella-prod].cm.Accounts a ON a.Id = c.ActiveAccountId
        WHERE cda.AnprMatchId IN (' + @matchIdList + ')
    '')';

    EXEC sp_executesql @sql;
END
