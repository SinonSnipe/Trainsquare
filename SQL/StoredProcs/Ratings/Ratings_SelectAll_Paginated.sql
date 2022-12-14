USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Ratings_SelectAll_Paginated]    Script Date: 8/14/2022 11:58:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author: Jake Lowrance
-- Create date: 5/18/2022
-- Description: This SelectAll proc will return all the Ratings in a paginated format 
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:	
-- Note:
-- =============================================


ALTER PROC [dbo].[Ratings_SelectAll_Paginated]
			@Index int
			,@PageSize int

AS
/* ============== Test Code ==============
DECLARE @Index int = 0
		,@PageSize int = 10

EXECUTE dbo.Ratings_SelectAll_Paginated
		@Index
		,@PageSize

	======================================= */


BEGIN

	DECLARE @offset int = @Index * @PageSize

	SELECT [Id]
		  ,[Rating]
		  ,[CommentId]
		  ,[EntityTypeId]
		  ,[EntityId]
		  ,[DateCreated]
		  ,[DateModified]
		  ,[CreatedBy]
		  ,[IsDeleted]

		  ,[TotalCount] = COUNT(1)OVER()
	  FROM [dbo].[Ratings]
  
	  ORDER BY Id

	  OFFSET @offset Rows
	  Fetch Next @PageSize Rows ONLY



END