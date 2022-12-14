USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[PrivateBooking_Search_Pagination]    Script Date: 8/14/2022 11:55:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Bianchi Mena
-- Create date: 05/17/2022
-- Description: Stored Procedure for SEARCH_PAGINATION for dbo.PrivateBooking Table 
-- Code Reviewer: Ethan Englert

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[PrivateBooking_Search_Pagination]
			@PageIndex int 
		   ,@PageSize int 
		   ,@Query nvarchar(100)

AS

/* --- TEST CODE --- 
	
	DECLARE @PageIndex int = 0
		   ,@PageSize int = 2
		   ,@Query nvarchar(100) = 'd'

	EXECUTE dbo.PrivateBooking_Search_Pagination @PageIndex   
									 ,@PageSize
									 ,@Query

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
  WHERE (Name LIKE '%' + @Query + '%')

  ORDER BY Id
  OFFSET @offset ROWS
  FETCH NEXT @PageSize ROWS ONLY

END


