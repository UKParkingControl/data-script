	;With cte_PaidContraventions AS -- Get contravention and DR data for PAID contraventions. We look at the most recent record from the DR table when partitioned by contraventionID.
	(
		SELECT * FROM 
		(
			SELECT
				p.Id PlacementId, 
				p.Created PlacementCreated,
				co.[Name] DRCompany,
				p.ContraventionId,
				c.EventDateTime,
				c.Reference,
				c.ActiveAccountId,
				c.[Status] ContraventionStatus,
				ROW_NUMBER() OVER(PARTITION BY p.ContraventionId ORDER BY p.Created DESC) row_num
			FROM 
				cm.Contraventions c
			JOIN 
				cm.DebtCollectionPlacements p ON (c.Id  = p.ContraventionId and c.ActiveAccountId = p.ActiveAccountId)
			JOIN 
				cm.DebtCollectionCompanies co ON co.Id = p.DebtCollectionCompanyId
		) AS a
		where 
			row_num = 1
			--AND ContraventionStatus = 1
			AND PlacementCreated > '2023-06-01' -- When the API was in good working order
	)
	   
	,cte_PaidContraventionWithTransactions AS -- Using the paid contraventions, get the payment transactions per contravention. We split out debt recovery and non - debt recovery data.
	(
		SELECT
			c.ContraventionId,
			CASE
				WHEN t.TransactionType in (0,1,2,3,6,7) THEN 'UKPC'
				ELSE 'DR'
			END PaidVia,
			MAX(t.Created) AS PaidAt, MAX(t.Id) TransactionId,
			STRING_AGG(t.TransactionType, ',') TransactionType,
			SUM(CASE
					WHEN t.TransactionType in (0,1,2,3,6,7) THEN -1* t.Amount
					ELSE 0
				END) PaidDirectPayment,
			SUM(CASE
					WHEN t.TransactionType in (10) THEN -1* t.Amount
					ELSE 0
				END) DRPayment,
			SUM(t.Amount) Amount,
			MAX(l.SentAt) as SentAt,
			[APIInstruction]
		FROM 
			cte_PaidContraventions c
		JOIN 
			cm.Accounts a ON c.ActiveAccountId = a.Id
		LEFT JOIN 
			cm.AccountTransactions t ON (t.AccountId  = a.Id AND t.TransactionType IN (0,1,2,3,6,7,10))
		LEFT JOIN 
			(
				SELECT 
					q.AccountTransactionId, 
					l.Created SentAt,
					CASE 
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 0 THEN 'Pending'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 1 THEN 'Placed'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 2 THEN 'Withdrawn'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 3 THEN 'PaymentPlan'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 4 THEN 'Paid'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 5 THEN 'Cancelled'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 6 THEN 'Open'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 7 THEN 'PaidWithSettlement'
						WHEN JSON_VALUE(RequestContent,'$[0].StatusCode') = 8 THEN 'PendingWithdraw'
						ELSE 'Unknown' 
					END [APIInstruction]
				FROM 
					cm.DebtCollectionPaymentTransactionQueue q
				JOIN 
					cm.DebtCollectionHttpSentLog l ON q.ProcessedId = l.Id

			) l ON (l.AccountTransactionId = t.Id and t.Deleted IS NULL ) 
		GROUP BY
			c.ContraventionId,
			CASE
				WHEN t.TransactionType in (0,1,2,3,6,7) THEN 'UKPC'
				ELSE 'DR'
			END,
			[APIInstruction]
	)

	,cte_PaidContraventionWithFullDetail AS -- cte to nicely table the result of the cte_PaidContraventionWithTransactions cte.
	(
		SELECT 
			c.PlacementCreated PlacedAt, 
			c.DRCompany, 
			c.EventDateTime, 
			c.ContraventionId, 
			c.Reference, 
			c.ActiveAccountId ,
			PaidVia,
			t.PaidAt, 
			t.TransactionId, 
			t.TransactionType, 
			t.SentAt, 
			PaidDirectPayment, 
			DRPayment, 
			-(t.Amount) PaidAmount,
			[APIInstruction]
		FROM 
			cte_PaidContraventions c
		LEFT JOIN 
			cte_PaidContraventionWithTransactions t ON c.ContraventionId = t.ContraventionId
	)
 
	-- Result set
	SELECT  
			
		EventDateTime ContraventionDate, 
		PlacedAt DebtPlacementDate, 
		PaidAt PaymentDate, 
		CAST(SentAt as DATETIME) APIStatusSentDate,
		[APIInstruction],
		ContraventionId, 
		Reference,
		CASE -- Separation of the different types of debt recovery. When DR, UKPC - this means we have both DR and UKPC payments on the contravention.
			WHEN PaidDirectPayment > 0 and DRPayment > 0 THEN 'DR, UKPC'
			WHEN PaidDirectPayment > 0 and DRPayment= 0 THEN 'UKPC'
			WHEN PaidDirectPayment = 0 and DRPayment> 0 THEN 'DR'
		END PaidVia, 
		DRCompany,
		PaidDirectPayment, 
		DRPayment
		
	FROM 
		(
			SELECT
				PlacedAt, 
				DRCompany, 
				EventDateTime, 
				ContraventionId, 
				Reference, 
				ActiveAccountId,
				Min(PaidAt) PaidAt,
				STRING_AGG(TransactionId, ', ') TransactionId,
				SUM(PaidDirectPayment) PaidDirectPayment,
				SUM(DRPayment) DRPayment,
				SUM(PaidAmount) PaidAmount,
				SentAt,
				[APIInstruction]
			FROM 
				cte_PaidContraventionWithFullDetail  c
			WHERE 
				DRCompany NOT IN ('UKPC', 'UKPC manual') --Remove any litigation data that we have used ourselves as the 3rd placement.
				AND 
					(
						(PaidAt IS NOT NULL AND PaidAt BETWEEN '2023-06-01' AND cast(getdate() AS DATE)) OR PaidAt IS NULL
					)
			GROUP BY 
				PlacedAt, 
				DRCompany, 
				EventDateTime, 
				ContraventionId, 
				Reference, 
				ActiveAccountId, 
				SentAt,
				[APIInstruction]
		) AS a
	WHERE 
		PaidDirectPayment > 0 -- Make sure this is paid direct
		--and PaidAt >= '2025-05-07'

	ORDER BY 
		PaidAt DESC
 