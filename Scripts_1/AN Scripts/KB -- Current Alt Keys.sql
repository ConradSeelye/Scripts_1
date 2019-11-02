



USE ActiveLive
GO

DECLARE @asofdate DATE = GetDate();

WITH CurrentCustomers (Customer_ID, Membership_ID, MaxEffectiveDate, Package_ID) -- , EFFECTIVE_DATE, expiration_date
AS (
	SELECT 
		customer_membership_dates.Customer_ID
		,MAX(customer_membership_dates.Membership_ID)
		,MAX(customer_membership_dates.EFFECTIVE_DATE)
		,Memberships.Package_ID
	FROM Memberships
		JOIN customer_membership_dates 
			ON memberships.membership_id = customer_membership_dates.membership_id
		JOIN Packages 
			ON Packages.package_id = Memberships.package_id
	WHERE 1=1
		AND customer_membership_dates.effective_date <= @asofdate
		AND customer_membership_dates.expiration_date >= @asofdate
		AND (customer_membership_dates.termination_date = '1899-12-30' OR customer_membership_dates.termination_date > @asofdate)
		AND packages.maxuses = 0
	GROUP BY 
		customer_membership_dates.Customer_ID
		,Memberships.Package_ID
	)

, AltKeys (CUSTOMER_ID, Alternate_Key_Status, Alternate_Key_Type ,AlternateKey_ID)
AS (
	SELECT 
		CurrentCustomers.CUSTOMER_ID
		, AKS.Alternate_Key_Status 
		, AKT.Alternate_Key_Type
		, CAK.AlternateKey_ID 

	FROM 
		CurrentCustomers
		LEFT JOIN CUSTOMER_ALTERNATE_KEYS CAK
			ON CAK.Customer_ID = CurrentCustomers.Customer_ID
		LEFT JOIN ALTERNATE_KEY_STATUSES AKS
			ON AKS.AlternateKeyStatus_ID = CAK.AlternateKeyStatus_ID
		LEFT JOIN ALTERNATE_KEY_TYPES AKT
			ON AKT.AlternateKeyType_ID = CAK.AlternateKeyType_ID
	)

-- SELECT * FROM AltKeys

--SELECT COUNT(Customer_ID) AS CountCustomer_Id 
--FROM AltKeys 
--GROUP BY Customer_ID 
--HAVING COUNT(Customer_ID) > 1 

SELECT Count(Customer_ID), Alternate_Key_Status
FROM AltKeys
WHERE Alternate_Key_Status LIKE '%IBP%' AND Alternate_Key_Status NOT LIKE ('%Employee%')
GROUP BY Alternate_Key_Status
ORDER BY Alternate_Key_Status


