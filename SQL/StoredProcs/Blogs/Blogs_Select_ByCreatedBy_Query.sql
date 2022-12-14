USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_Select_ByCreatedBy_Query]    Script Date: 8/9/2022 2:26:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Alicia Moreno
-- Create date: 4/02/2022
-- Description: Select By CreatedBy Proc for Blogs
-- Code Reviewer: Zachary Musgrave

-- MODIFIED BY: Alicia Moreno
-- MODIFIED DATE: 4/2/2022
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Blogs_Select_ByCreatedBy_Query]
						 @pageIndex int 
						,@pageSize int
						,@query nvarchar(100)
						,@AuthorId int

/* --TEST CODE--
	
		Declare			@pageIndex int = 0
						,@pageSize int = 10
						,@query nvarchar(100) = ' '
						,@AuthorId int = 268
		
		Execute		dbo.Blogs_Select_ByCreatedBy_Query
						@pageIndex 
						,@pageSize 
						,@query
						,@AuthorId

						select * from dbo.Blogs
*/

AS

BEGIN

		DECLARE		   @offset int = @pageIndex * @pageSize

		SELECT		 b.Id
			,b.BlogTypeId
			,bt.[Name] as BlogType
			,b.AuthorId			
			,up.[FirstName] as UserProfiles
			,up.[LastName] as UserProfiles
			,up.[AvatarUrl] as UserProfiles
			,b.Title
			,b.Subject
			,b.Content
			,b.IsPublished
			,b.ImageUrl
			,b.DateCreated
			,b.DateModified
			,b.DatePublished
			,b.StatusId	
			,bs.[Name] as BlogStatus
			,TotalCount  = COUNT(1) OVER()

		
			FROM [dbo].[Blogs] AS b INNER JOIN dbo.BlogTypes AS bt
								 ON b.BlogTypeId = bt.Id
								INNER JOIN dbo.UserProfiles AS up
								ON b.AuthorId = up.UserId
								INNER JOIN dbo.BlogStatus AS bs
								ON b.StatusId = bs.Id

	   WHERE @AuthorId = b.AuthorId
	   AND (b.Title LIKE '%' + @Query + '%' OR
			b.Subject LIKE '%' + @Query + '%' OR
			b.Content LIKE '%' + @Query + '%' OR
			b.IsPublished LIKE '%' + @Query + '%' OR
			b.ImageUrl LIKE '%' + @Query + '%' OR
			b.DatePublished LIKE '%' + @Query + '%')


		ORDER BY bt.Id


		OFFSET @offset Rows
		Fetch Next @pageSize Rows ONLY

END
