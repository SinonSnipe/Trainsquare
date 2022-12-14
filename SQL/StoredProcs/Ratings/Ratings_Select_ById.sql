USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Ratings_Select_ById]    Script Date: 8/14/2022 11:58:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jake Lowrance
-- Create date: 5/18/2022
-- Description: Select By Id Proc for Ratings
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY: Jake Lowrance
-- MODIFIED DATE: 5/18/2022
-- Code Reviewer:
-- Note:
-- =============================================
ALTER PROC [dbo].[Ratings_Select_ById]
				@Id int 

AS
 /*
 
 DECLARE @Id int = 1

 EXECUTE [dbo].[Ratings_Select_ById]
		@Id

 */
BEGIN

	SELECT [Id]
		  ,[Rating]
		  ,[CommentId]
		  ,[EntityTypeId]
		  ,[EntityId]
		  ,[DateCreated]
		  ,[DateModified]
		  ,[CreatedBy]
		  ,[IsDeleted]
	  FROM [dbo].[Ratings]
	  WHERE Id = @Id

END


