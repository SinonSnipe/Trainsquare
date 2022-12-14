USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Ratings_Select_ByEntityId]    Script Date: 8/14/2022 11:58:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jake Lowrance
-- Create date: 05/22/2022
-- Description: This proc will return a paginate list of records by EntityId and EntityTypeId
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note: 
-- =============================================

ALTER PROC [dbo].[Ratings_Select_ByEntityId]
			@EntityId int
			,@EntityTypeId int
			,@PageIndex int
			,@PageSize int
AS

/* ============== Test Code ==============

			DECLARE
						
		    @PageIndex int = 0
		   ,@PageSize int = 10
		   ,@EntityTypeId int = 5678
		   ,@EntityId int = 3456
           
		    EXECUTE [dbo].[Ratings_Select_ByEntityId]

		    @PageIndex  
		   ,@PageSize 
		   ,@EntityTypeId
		   ,@EntityId

  ======================================= */




BEGIN

	DECLARE @offset int = @PageIndex * @PageSize

	SELECT r.[Id]
		  ,r.[Rating]
		  ,r.[CommentId]
		  ,r.[EntityTypeId]
		  ,r.[EntityId]
		  ,r.[DateCreated]
		  ,r.[DateModified]
		  ,r.[CreatedBy] 
		  ,r.[IsDeleted]
		  ,c.[Subject]
		  ,c.[Text]
		  ,E.[Name]
		  ,u.[Email]
		  ,up.[FirstName]
		  ,up.[LastName]
		  ,[TotalCount] = COUNT(1)OVER()

	  FROM [dbo].[Ratings] as r left join [dbo].[Comments] as c
	  ON r.CommentId = c.Id
	  left join [dbo].[EntityTypes] as e
	  ON r.EntityTypeId = e.Id
	  left join [dbo].[Users] as u
	  ON r.CreatedBy = u.Id
	  left join [dbo].[UserProfiles] as up
	  ON r.CreatedBy = up.Id
	  ORDER BY r.DateModified

	  OFFSET @offset Rows
	  Fetch Next @pageSize Rows ONLY

END