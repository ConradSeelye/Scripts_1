USE FRED
GO


-- get date of the current ActiveLive
SELECT MAX(DATESTAMP) AS EffectiveDate FROM ActiveLive.dbo.Transactions

-- Check whether Fred.dbo.NewMembersHist is current.
SELECT TOP 5 effective_date, transaction_date, new_member_hist_id, record_date
FROM [dbo].[NewMembersHist]
ORDER BY transaction_date DESC

--SELECT COUNT(new_member_hist_id) AS ID_Count, effective_date
--FROM [dbo].[NewMembersHist]
--GROUP BY effective_date

--SELECT * 
--FROM [dbo].[NewMembersHist]
--ORDER BY transaction_date DESC

USE FRED
GO

SELECT 'Count by record_date' AS ' '
SELECT COUNT(new_member_hist_id) As CountNewMemberHist, record_date
--FROM NewMembersHist
FROM NewMembersHist
GROUP BY record_date
ORDER BY record_date DESC

SELECT 'Count by transaction_date' AS ' '
SELECT COUNT(new_member_hist_id) AS CountNewMemberHist, Cast(transaction_date AS DATE) AS Transaction_Date
FROM NewMembersHist
GROUP BY Cast(transaction_date AS DATE)
ORDER BY transaction_date DESC

-- Check whether Fred.dbo.ActiveMemberHist is current.
--SELECT active_member_datestamp, record_date, active_member_hist_id
--FROM ActiveMemberHist
--ORDER BY record_date DESC

USE FRED
GO
SELECT COUNT(active_member_hist_id) AS ID_Count, active_member_datestamp
FROM ActiveMemberHist
GROUP BY active_member_datestamp
ORDER BY active_member_datestamp DESC

--SELECT *
--INTO ActiveMemberHist_BU2
--FROM ActiveMemberHist






