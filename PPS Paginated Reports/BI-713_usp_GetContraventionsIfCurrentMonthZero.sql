-----------usp_GetContraventionsIfCurrentMonthZero

CREATE PROCEDURE [Statistics].[usp_GetContraventionsIfCurrentMonthZero]
    @SelectedMonthYear DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @SelectedYear INT,
        @SelectedMonth INT,
        @ThisMonth DATE,
        @LastYearSameMonth DATE;

    SET @SelectedYear = YEAR(@SelectedMonthYear);
    SET @SelectedMonth = MONTH(@SelectedMonthYear);
    SET @ThisMonth = DATEFROMPARTS(@SelectedYear, @SelectedMonth, 1);
    SET @LastYearSameMonth = DATEFROMPARTS(@SelectedYear - 1, @SelectedMonth, 1);

    SELECT 
        ci.SiteName AS ZoneName,
        cst.Service_Type_Filter AS ServiceType,
        COUNT(*) AS TotalPCNsThisMonthLastYear
    FROM [BusinessIntelligence].[Statistics].Contraventions_Issued ci
    INNER JOIN [BusinessIntelligence].[Statistics].Contraventions_ServiceTypes cst 
        ON ci.Service_type_prefix = cst.Service_type_prefix
    WHERE 
        cst.Service_Type_Filter LIKE 'PPS%' AND
        DATEFROMPARTS(YEAR(ci.DateIssued), MONTH(ci.DateIssued), 1) = @LastYearSameMonth
        AND NOT EXISTS (
            SELECT 1
            FROM [BusinessIntelligence].[Statistics].Contraventions_Issued ci2
            INNER JOIN [BusinessIntelligence].[Statistics].Contraventions_ServiceTypes cst2 
                ON ci2.Service_type_prefix = cst2.Service_type_prefix
            WHERE 
                cst2.Service_Type_Filter LIKE 'PPS%' AND
                DATEFROMPARTS(YEAR(ci2.DateIssued), MONTH(ci2.DateIssued), 1) = @ThisMonth
                AND ci2.SiteName = ci.SiteName
                AND cst2.Service_Type_Filter = cst.Service_Type_Filter
        )
    GROUP BY 
        ci.SiteName,
        cst.Service_Type_Filter
    ORDER BY COUNT(*) DESC;
END
