USE [BusinessIntelligence]
GO
/****** Object:  StoredProcedure [Statistics].[usp_WeeklyRollingAverage_IssuedTickets]    Script Date: 7/1/2025 5:37:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		    Gary Brown
-- ALTERd date:     2024-12-11
-- Description:		Average issued tickets (per week) data, showing 13 weekly totals
-- =============================================

ALTER PROCEDURE [Statistics].[usp_WeeklyRollingAverage_IssuedTickets]
AS

    DECLARE @ReportEndDate AS DATE = CAST(GETDATE() AS DATE);
    DECLARE @ReportStartDate AS DATE;
    DECLARE @LastMonday DATE;
    DECLARE @CurrentDate DATE;

    SET @LastMonday = DATEADD(DAY, -((DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST - 2) % 7), GETDATE())
    SET @ReportStartDate = DATEADD(WEEK, -12, @LastMonday)
    SET @CurrentDate = @ReportStartDate
    SET DATEFIRST 1

BEGIN

    BEGIN TRY
        
        -- Use a temporary table to store the dates
        CREATE TABLE #dDate
        (
            DDate DATE
        )

        -- Loop to generate dates and insert them into the temporary table
        WHILE @CurrentDate <= @ReportEndDate
        BEGIN
            INSERT INTO #dDate (DDate)
            VALUES (@CurrentDate)

            -- Move to the next week
            SET @CurrentDate = DATEADD(WEEK, 1, @CurrentDate)
        END

        ;WITH cte_StellaData AS
        (
            SELECT
                ZoneId,
                CASE 
                    WHEN C.FirstIssuedDate >= '2024-01-01' AND C.EventDateTime >= '2024-01-01' THEN DATEADD(DAY, -(DATEPART(WEEKDAY, C.EventDateTime) + @@DATEFIRST - 2) % 7, CAST(C.EventDateTime AS DATE))
                    ELSE DATEADD(DAY, -(DATEPART(WEEKDAY, C.FirstIssuedDate) + @@DATEFIRST - 2) % 7, CAST(C.FirstIssuedDate AS DATE)) 
                END WeekStart,
                --DATEADD(DAY, -(DATEPART(WEEKDAY, C.EventDateTime) + @@DATEFIRST - 2) % 7, CAST(C.EventDateTime AS DATE))  WeekStart,
                SUM(CASE WHEN C.FirstIssuedDate IS NOT NULL THEN 1 ELSE 0 END) [TotalIssuedTickets],
                SUM(CASE WHEN C.[Status] = 1 THEN 1 ELSE 0 END) TotalPaid,
                LEFT(C.Reference, 1) ServiceTypePrefix
            FROM 
                [StellaProduction].[sqldb-stella-prod].[cm].Contraventions C		
            JOIN
                [StellaProduction].[sqldb-stella-prod].sm.Zones Z ON Z.Id = C.ZoneId
            WHERE
                --C.[Status] NOT IN (2,3) --0 Open, 1 Paid, 2 Cancelled, 3 Timeout, 4 Paused
                C.FirstIssuedDate >= @ReportStartDate
                AND ZoneId > 1
                --AND ZoneId = 75
                AND CHARINDEX('test',LOWER(Z.Name)) = 0
            GROUP BY
                CASE 
                    WHEN C.FirstIssuedDate >= '2024-01-01' AND C.EventDateTime >= '2024-01-01' THEN DATEADD(DAY, -(DATEPART(WEEKDAY, C.EventDateTime) + @@DATEFIRST - 2) % 7, CAST(C.EventDateTime AS DATE))
                    ELSE DATEADD(DAY, -(DATEPART(WEEKDAY, C.FirstIssuedDate) + @@DATEFIRST - 2) % 7, CAST(C.FirstIssuedDate AS DATE)) 
                END, 
                ZoneId,
                LEFT(C.Reference, 1)
        )

        ,cte_LocationOutput AS
        (
            SELECT
                ZoneId,
                COUNT(*) Total

            FROM 
                [StellaProduction].[sqldb-stella-prod].cm.Contraventions C		
            JOIN
                [StellaProduction].[sqldb-stella-prod].sm.Zones Z ON Z.Id = C.ZoneId
            WHERE
                --C.[Status] NOT IN (2,3) --0 Open, 1 Paid, 2 Cancelled, 3 Timeout, 4 Paused
                C.FirstIssuedDate >= @ReportStartDate
                AND ZoneId > 1
                AND CHARINDEX('test',LOWER(Z.Name)) = 0
            GROUP BY
                ZoneId
        )

        ,cte_MakeRows AS
        (
            SELECT
                S.ZoneId,
                D.DDate WeekStart
            FROM
                #dDate D
            CROSS JOIN
                cte_LocationOutput S
        )

        ,cte_FinalOutput AS
        (
            SELECT
                O.WeekStart,
                O.ZoneId,       
                ISNULL(S.TotalIssuedTickets,0) TotalIssuedTickets,
                ISNULL(S.TotalPaid,0) TotalPaidTickets,
                CAST(NULLIF(S.TotalIssuedTickets, 0) as DECIMAL(10,2)) [AverageIssuedTickets],
                ServiceTypePrefix
            FROM
                cte_MakeRows O
            LEFT JOIN
                cte_StellaData S ON
                    S.ZoneId = O.ZoneId AND
                    S.WeekStart = O.WeekStart          
        )

		SELECT 
			C.*,
			S.ZoneName,
			S.ZoneExternalReference,
			S.LocationName,
			S.CompanyName,
			S.PortfolioName,
			CT.Contravention_type ContraventionServiceType
		FROM cte_FinalOutput c
		JOIN BusinessIntelligence.[Statistics].[Sites] S ON S.ZoneID = C.ZoneId AND S.[System] = 'Stella'
		JOIN BusinessIntelligence.[Statistics].[Contraventions_ServiceTypes] ST ON ST.Service_type_prefix = C.ServiceTypePrefix
		JOIN BusinessIntelligence.[Statistics].[Contraventions_ServiceTypes_ContraventionTypes] CT ON CT.ID = ST.Contravention_type
		DROP TABLE #dDate

    END TRY
    BEGIN CATCH
        -- raise the error again or log it for further review
        DECLARE @ErrorMessage VARCHAR(4000), @ErrorSeverity VARCHAR(4000), @ErrorState VARCHAR(4000);
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();
          
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END