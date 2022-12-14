USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[PrivateBooking_Pagination]    Script Date: 8/14/2022 11:55:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Bianchi Mena
-- Create date: 05/17/2022
-- Description: Stored Procedure for PAGINATION for dbo.PrivateBooking Table 
-- Code Reviewer: Ethan Englert

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[PrivateBooking_Pagination]
			@PageIndex int 
		   ,@PageSize int 

AS

/* --- TEST CODE ---

	DECLARE @PageIndex int = 0
		   ,@PageSize int = 2

	EXECUTE dbo.PrivateBooking_Pagination @PageIndex         
										 ,@PageSize

	SELECT *                      
	FROM dbo.PrivateBooking   

*/

BEGIN 

	DECLARE @offset int = @PageIndex * @PageSize

SELECT [Id]
      ,[Name]
	  ,[Email]
	  ,[NumberOfPeopleAttending]
      ,[Description]
      ,[NumberOfSessions]
      ,[DateCreated]
      ,[DateModified]
      ,[WorkshopId]
      ,[UserId]
      ,[WorkshopRequestId]
	  ,TotalCount = COUNT(1) OVER()
  FROM [dbo].[PrivateBooking]

  ORDER BY Id
  OFFSET @offset ROWS
  FETCH NEXT @PageSize ROWS ONLY

END


