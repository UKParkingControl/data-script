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
    
    SELECT  ci.SiteName AS ZoneName,
        cst.Service_Type_Filter AS ServiceType,
        COUNT(*) AS TotalPCNsThisMonthLastYear, 
        CAST(szas.PPSTermDate AS DATE) PPSTermDate
	FROM [Statistics].Sites_ZoneActiveServices szas 
	JOIN  [BusinessIntelligence].[Statistics].Contraventions_Issued ci ON szas.ZoneExternalReference = ci.SiteReference
	INNER JOIN [BusinessIntelligence].[Statistics].Contraventions_ServiceTypes cst    ON ci.Service_type_prefix = cst.Service_type_prefix AND  cst.Service_Type_Filter LIKE 'PPS%'
	WHERE DATEFROMPARTS(YEAR( szas.PPSTermDate), MONTH(szas.PPSTermDate), 1) = @ThisMonth 
		AND  DATEFROMPARTS(YEAR(ci.DateIssued), MONTH(ci.DateIssued), 1) = @LastYearSameMonth
		
	GROUP BY 
        ci.SiteName,
        cst.Service_Type_Filter,
        szas.PPSTermDate
    ORDER BY COUNT(*) DESC;
END