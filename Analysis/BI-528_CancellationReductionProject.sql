WITH cte_NextWorkingDay AS
(
    SELECT 
        d1.TheDate,
        d1.TheDayName,
        d1.IsBankHoliday,
        d1.IsWeekend,
        MIN(d2.TheDate) AS NextWorkingDay
    FROM 
        BusinessIntelligence.development.Dim_Date d1
    LEFT JOIN 
        BusinessIntelligence.development.Dim_Date d2 ON d2.TheDate > d1.TheDate AND d2.IsFollowingWorkingDay = 1
    WHERE d1.IsBankHoliday =1 OR d1.IsWeekend =1
        GROUP BY 
        d1.TheDate,
        d1.TheDayName,
        d1.IsBankHoliday,
        d1.IsWeekend
)
select init.ContraventionID, ContraventionEventDateTime, ZoneExternalReference, LocationID, LocationName, ServiceType, ContraventionStatus, ContraventionReason, VRN, NTKDateTime, PermitAddedDate,
CASE WHEN dd1.TheDate IS NOT NULL THEN 1 ELSE 0 END NTKOnBankHolidayOrWeekend,
CASE WHEN dd1.TheDate IS NOT NULL AND CAST(PermitAddedDate AS DATE) = dd1.NextWorkingDay THEN 1 ELSE 0 END PermitOnFollowingWorkingDay
from BusinessIntelligence.development.tmp_InitialNotice init
JOIN BusinessIntelligence.development.tmp_PermitAdded pm On init.ContraventionID=pm.ContraventionID
LEFT JOIN cte_NextWorkingDay dd1 ON CAST(init.NTKDateTime AS DATE)=dd1.TheDate
--WHERE dd1.TheDate IS NOT NULL 
--AND CAST(PermitAddedDate AS DATE) = dd1.NextWorkingDay 