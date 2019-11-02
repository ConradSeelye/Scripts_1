/*
ActiveNet database base query
_short


Title: SELECT all current Customers and Members
As of: 10/25/2016
Based on: ?
Original author: Nate at Seer
Edited by: Conrad

Notes:
* There is no direct join between Memberships and Customers. These tables can be joined through Passes or Usage.

ToDo:
* Find other ways to join Memberships and Customers.
* Compare this to "KB -- Current Members_ID and Customer_ID.sql"

*/


DECLARE @asofdate DATE = GetDate();


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
	