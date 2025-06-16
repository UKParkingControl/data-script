WITH list_siteID_ipermit AS
	(
	SELECT DISTINCT -- List of SiteID using iPermit in recent 1 month
	    es.Id ID
	FROM UKPC.dbo.ClientWhitelist cw
	JOIN UKPC.dbo.ExtranetSites es 
	    ON cw.Siteid = es.Id
	WHERE es.Name LIKE '%McDonalds%'
	GROUP BY es.Id
	HAVING MAX(cw.Createddate) >= DATEADD(MONTH, -1, GETDATE())
	)
, list_siteID_ihub AS
	(
	SELECT DISTINCT -- List of SiteID using iHub in recent 1 month
	  ms.ExternalReference ID
	FROM VehicleList.dbo.VehicleLists vl
	JOIN VehicleList.dbo.Scopes s ON s.VehicleListId = vl.Id
	JOIN VehicleList.dbo.MappedScopes ms
	ON (s.ScopeType = 1 AND s.ScopeId = ms.CompanyId)
	OR (s.ScopeType = 3 AND s.ScopeId = ms.LocationId)
	OR (s.ScopeType = 4 AND s.ScopeId = ms.ZoneId)
	WHERE vl.ServiceId = 2
	AND s.WhiteListId IS NULL
	AND ms.ZoneName LIKE '%McDonalds%'
	AND vl.Created >= DATEADD(MONTH, -1, GETDATE())
	)
SELECT 
  ID,
  ExternalReference, 
  Name,
  IsUsingIhub,
  STRING_AGG(ManagerName, char(10)) AS ManagerName,
  STRING_AGG(TenantName, char(10)) AS TenantName,
  STRING_AGG(ManagerEmail, char(10)) AS ManagerEmail,
  STRING_AGG(TenantEmail, char(10)) AS TenantEmail,
  STRING_AGG(ManagerPhone, char(10)) AS ManagerPhone,
  STRING_AGG(TenantPhone, char(10)) AS TenantPhone
FROM (
SELECT 
      z.ID,
      z.ExternalReference, 
      z.Name,
      CASE WHEN lsih.ID IS NOT NULL THEN 'Yes' ELSE 'No' END IsUsingIhub,
      CASE WHEN c.Label='Managing agent' THEN FirstName + ' ' + LastName END AS ManagerName,
      CASE WHEN c.Label='Tenant' THEN FirstName + ' ' + LastName END AS TenantName,
      CASE WHEN c.Label='Managing agent' THEN Email END AS ManagerEmail,
      CASE WHEN c.Label='Tenant' THEN Email END AS TenantEmail,
      CASE WHEN c.Label='Managing agent' THEN PhoneNumber END AS ManagerPhone,
      CASE WHEN c.Label='Tenant' THEN PhoneNumber END AS TenantPhone
    FROM list_siteID_ipermit lsip 
    JOIN StellaProduction.[sqldb-stella-prod].sm.Zones z ON z.ExternalReference=lsip.ID
    LEFT JOIN StellaProduction.[sqldb-stella-prod].sm.employeelocation l ON l.LocationID = z.LocationId 
    LEFT JOIN StellaProduction.[sqldb-stella-prod].sm.employee e ON e.ID = l.EmployeeID
    LEFT JOIN StellaProduction.[sqldb-stella-prod].sm.client c ON c.ID = e.ClientId 
    LEFT JOIN list_siteID_ihub lsih ON lsih.ID = lsip.ID
) AS src
GROUP BY ID, ExternalReference, Name, IsUsingIhub;