USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[LocationTypes_SelectAll]    Script Date: 8/9/2022 4:37:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--AUTHOR: FRANK VILARDI
--CREATE DATE: 3/24/2022
--DESCRIPTION: A lookup table for Location types. 
--The table is not called Addresses because not every location is an Address. 
--For example, if wanted to capture a user's favorite Cities, we can do so here and even capture a Lat and Long for said location. 
--But a City is not an Address. This name give us more flexibility in what we can store here.
--Home
--Billing
--Business
--Shipping
--Vending Location

--CODE REVIEWER: Elizabeth Phung
--MODIFIED BY: Matthew Golben
--MODIFIED DATE: 4/10/22
--CODE REVIEWER:
--NOTE: 

--CODE REVIEWER: 
--MODIFIED BY: Matthew Golben
--MODIFIED DATE: 4/28/22
--CODE REVIEWER:
--NOTE: Removed pagination as to simplify lookup service call. This should not induce any problems as the dropdown menu is limited. 

ALTER PROC [dbo].[LocationTypes_SelectAll] 

AS

/*


Execute dbo.[LocationTypes_SelectAll]  
								 @pageIndex
								,@pageSize
				
*/

BEGIN


	SELECT Id
		,[Name]
	FROM dbo.LocationTypes

	ORDER BY Id 


END
