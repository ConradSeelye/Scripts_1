/*
ActiveNet database base query

Title: SELECT all current Customers and Members
As of: 10/25/2016
Based on: Memberships Total Members and Households
Original author: Nate at Seer
Edited by: Conrad

Notes:
* There is no direct join between Memberships and Customers. These tables can be joined through Passes or Usage.

ToDo:
* Find other ways to join Memberships and Customers.


*/

	DECLARE @date Date = '10/1/2016'; --Date to determine ACTIVE status;

	select distinct
	memberships.membership_id,
	customers.customer_id,
	customers.firstname,
	customers.lastname,
	convert(varchar(55),customers.birthdate, 01) 'DOB',
	--CASE WHEN packages.site_id IS NULL THEN 'All Sites'
	--ELSE sites.sitename END AS 'PackageSite',
	--glaccounts.accountname AS 'GLAccountName',
	--glaccounts.accountnumber AS 'GLAccountNumber',
	package_categories.categoryname,
	packages.packagename,
	case when memberships.datesuspendedfrom = '1899-12-30 00:00:00.000' then null else convert(varchar(55),memberships.datesuspendedfrom,101) end 'Date Suspended From',
	case when memberships.datesuspendedto = '1899-12-30 00:00:00.000' then null else convert(varchar(55),memberships.datesuspendedto,101) end 'Date Suspended To',
	memberships.dateeffective,
	memberships.datesold,
	memberships.dateexpires

	FROM ActiveLive.dbo.memberships 
	LEFT JOIN ActiveLive.dbo.packages ON memberships.package_id = packages.package_id
	LEFT JOIN ActiveLive.dbo.package_fees ON packages.package_id = package_fees.package_id
	LEFT JOIN ActiveLive.dbo.package_categories on packages.packagecategory_id = package_categories.packagecategory_id
	LEFT JOIN ActiveLive.dbo.sites ON packages.site_id = sites.site_id
	LEFT JOIN ActiveLive.dbo.glaccounts ON package_fees.glaccount_id = glaccounts.glaccount_id
	LEFT JOIN ActiveLive.dbo.membership_passes ON memberships.membership_id = membership_passes.membership_id
	LEFT JOIN ActiveLive.dbo.passes ON membership_passes.pass_id = passes.pass_id
	LEFT JOIN ActiveLive.dbo.customers ON passes.customer_id = customers.customer_id

	-----------------------------------------------------------------
	--Condition to return Active status memberships that have not yet expired
	-----------------------------------------------------------------

	WHERE memberships.status = 1
	--membership expires after this date
	AND memberships.dateexpires >= @date
	--membership was effective before the end of the year
	AND memberships.dateeffective < @date
	--membership was sold before the end of the year
	AND memberships.datesold < @date
	-----------------------------------------------------------------
	--Condition to return primary fee for membership package
	-----------------------------------------------------------------
	AND package_fees.primaryfee = -1
	-----------------------------------------------------------------
	--Condition to return retention eligible memberships 
	-----------------------------------------------------------------
	AND package_categories.retention_eligible <> '0'
	--remove suspended members
	AND customers.customer_id not in 
	(
	select distinct
	customers.customer_id
	FROM ActiveLive.dbo.memberships 
	LEFT JOIN ActiveLive.dbo.packages ON memberships.package_id = packages.package_id
	LEFT JOIN ActiveLive.dbo.package_fees ON packages.package_id = package_fees.package_id
	LEFT JOIN ActiveLive.dbo.package_categories on packages.packagecategory_id = package_categories.packagecategory_id
	LEFT JOIN ActiveLive.dbo.sites ON packages.site_id = sites.site_id
	LEFT JOIN ActiveLive.dbo.glaccounts ON package_fees.glaccount_id = glaccounts.glaccount_id
	LEFT JOIN ActiveLive.dbo.membership_passes ON memberships.membership_id = membership_passes.membership_id
	LEFT JOIN ActiveLive.dbo.passes ON membership_passes.pass_id = passes.pass_id
	LEFT JOIN ActiveLive.dbo.customers ON passes.customer_id = customers.customer_id

	-----------------------------------------------------------------
	--Condition to return Active status memberships that have not yet expired
	-----------------------------------------------------------------

	WHERE memberships.status = 1
	--membership expires after date
	AND memberships.dateexpires >= @date
	--membership was effective before date
	AND memberships.dateeffective < @date
	--membership was sold before the end of the year
	AND memberships.datesold < @date
	AND memberships.datesuspendedfrom <> '1899-12-30 00:00:00.000'
	AND memberships.datesuspendedfrom < @date
	And memberships.datesuspendedto >= @date
	-----------------------------------------------------------------
	--Condition to return primary fee for membership package
	-----------------------------------------------------------------
	AND package_fees.primaryfee = -1
	-----------------------------------------------------------------
	--Condition to return retention eligible memberships 
	-----------------------------------------------------------------
	AND package_categories.retention_eligible <> '0')
	-- order by lastname, firstname desc