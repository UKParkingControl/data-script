WITH ContraventionTypes AS (
---- to filter contravention created since 2024
    SELECT 
        a.Id AS AccountId,
    
        LEFT(C.Reference,1)  ContraventionType 
    FROM [StellaProduction].[sqldb-stella-prod].cm.Accounts a
    JOIN [StellaProduction].[sqldb-stella-prod].cm.Contraventions c 
    
        ON a.Id = c.ActiveAccountId and c.Created >= '2024-01-01')
,SentLetters AS (
---to obtain all the letter that sent to Account (Initial Notice, Final Reminder, IDR )
    SELECT 
        ac.AccountId,   
        ac.Created, ct.ContraventionType,
        CASE 
            WHEN wlt.LetterType = 0 THEN 0
            WHEN wlt.LetterType IN (1, 7) THEN 1
            WHEN wlt.LetterType IN (6, 8) THEN 2
        END AS LetterType
    FROM [StellaProduction].[sqldb-stella-prod].cm.AccountCorrespondences ac 
    INNER JOIN [StellaProduction].[sqldb-stella-prod].cm.WorkflowLetterTemplates wlt  
        ON ac.WorkflowLetterTemplateId = wlt.Id  
        AND wlt.LetterType IN (0, 1, 7, 6, 8)
    INNER JOIN ContraventionTypes ct on ac.AccountId = ct.AccountId
    WHERE   ac.SendStatus = 3
),
LatestLetterDates AS (
---to pivot the table by account, with one row per account.
    SELECT
        AccountId, ContraventionType,
        CAST(MAX(CASE WHEN LetterType = 0 THEN Created END) AS DATE) AS ini_date, --the latest date a initial letter is sent
        CAST(MAX(CASE WHEN LetterType = 1 THEN Created END) AS DATE) AS fin_date, --the latest date a final letter is sent
        CAST(MAX(CASE WHEN LetterType = 2 THEN Created END) AS DATE) AS idr_date, --the latest date a idr letter is sent
        CAST(MAX(Created) AS DATE) AS last_letter
    FROM SentLetters
    GROUP BY AccountId,ContraventionType
) 
--- to join with payment table to calculate Payment Ammount
    SELECT 
        lld.AccountId,  lld.ContraventionType,
        lld.ini_date,  
        lld.fin_date,  
        lld.idr_date,  
        lld.last_letter,
        CASE 
            WHEN lld.fin_date IS NOT NULL THEN 1 
            WHEN lld.ini_date IS NOT NULL THEN 0 
            ELSE 2 
        END AS last_letter_type,
        pi.paid_date, 
        pi.Amount,
        DATEDIFF(DAY, lld.fin_date, pi.paid_date) AS DaysToPayment,
        pi.is_debt_recovery
    FROM LatestLetterDates lld
    LEFT JOIN (  
        SELECT   
            at2.AccountId, 
            -SUM(CASE 
                WHEN at2.TransactionType IN (0, 1, 2, 3, 6, 7, 10) 
                THEN at2.Amount  
                ELSE 0 
            END) AS Amount,
            CAST(MAX(at2.Created) AS DATE) AS paid_date,
            ---to check if the payment is debt recovery
            CASE 
                WHEN SUM(CASE WHEN at2.TransactionType = 10 THEN 1 ELSE 0 END) > 0 
                THEN 1 
                ELSE 0 
            END AS is_debt_recovery
        FROM [StellaProduction].[sqldb-stella-prod].cm.AccountTransactions at2 
        JOIN [StellaProduction].[sqldb-stella-prod].cm.Contraventions c 
            ON c.ActiveAccountId = at2.AccountId 
            AND c.Status = 1
        WHERE at2.Deleted IS NULL
        GROUP BY at2.AccountId
    ) pi ON lld.AccountId = pi.AccountId
    WHERE (lld.ini_date IS NOT NULL OR lld.fin_date IS NOT NULL)
 