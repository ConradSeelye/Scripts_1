


/* Step 1: Check if the count of new members in the most recent date is very low,
and if that date is the current date which is missing
Typically, there will be one 1 member between midnight and 1:20 AM of the current day. 
paste date here:
*/
SELECT COUNT(new_member_hist_id), Cast(transaction_date AS DATE) AS Transaction_Date
FROM NewMembersHist
GROUP BY Cast(transaction_date AS DATE)
ORDER BY transaction_date DESC

/* Step 2: Get the id of the offender.
The date comes from the previous query.
paste new_member_hist_id:  8492
*/
SELECT *
FROM NewMembersHist
WHERE transaction_date >= '1/12/2016'

/* Step 3: Delete the offender from NewMemberHist
DELETE NewMembersHist
-- SELECT * from NewMembersHist
WHERE new_member_hist_id = 8492
*/

/* Step 4: Confirm the currrent date is now needed
*/
		  DECLARE @candidate_dates table
		  (
		  candidate_date date
		  )
		  insert into @candidate_dates
		  select distinct(cast(datestamp as date)) date
		  from activelive.dbo.transactions
		  where transactiontype = '29'
		  and cast(datestamp as date) >= '2015-08-01' 

		  -- SELECT * FROM @candidate_dates ORDER BY candidate_date

-- 
		  
		  DECLARE @existing_dates table
		  (
		  existing_date date
		  )
		  Insert into @existing_dates
		  Select distinct(cast(transaction_date as date)) from dbo.NewMembersHist
	
		-- SELECT * FROM @existing_dates ORDER BY existing_date DESC	  

-- 

		  DECLARE @needed_dates table
		  (
		  needed_date date
		  )
		  Insert into @needed_dates

		  select a.candidate_date from
		  @candidate_dates a
		  left join @existing_dates b
		  on a.candidate_date = b.existing_date
		  where b.existing_date is null

		  SELECT * from @needed_dates ORDER BY needed_date DESC

/* Step 5: re-run main insert
*/
exec usp_new_member_daily

/* Step 6: confirm data is now inserted for today
*/
SELECT COUNT(new_member_hist_id) As CountNewMemberHist, record_date
FROM NewMembersHist
GROUP BY record_date
ORDER BY record_date DESC

/* Step 7: refresh Tableau
*/




