USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Ratings_Select_ByCreatedBy]    Script Date: 8/14/2022 11:58:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jake Lowrance
-- Create date: 5/18/2022
-- Description: Select By Id Proc for Ratings
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER PROC [dbo].[Ratings_Select_ByCreatedBy]
							@pageIndex int 
						,@pageSize int
						,@CreatedBy int
						
AS		

/* --TEST CODE--
	
		Declare			@pageIndex int = 0
						,@pageSize int = 10
						,@Createdby int = 2
		
		Execute		[dbo].[Ratings_Select_ByCreatedBy]
						@pageIndex 
						,@pageSize 
						,@CreatedBy 

*/


BEGIN

	DECLARE @offset int = @pageIndex * @pageSize


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
		WHERE @CreatedBy = CreatedBy
			ORDER BY Id


			OFFSET @offset Rows
			Fetch Next @pageSize Rows ONLY

END   

