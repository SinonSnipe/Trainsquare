USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_Select_BlogCategoryV2]    Script Date: 8/9/2022 2:26:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Alicia Moreno Kaelin Clendenin
-- Create date: 4/04/2022
-- Description: Update Proc for Blogs
-- Code Reviewer:

-- MODIFIED BY: Alicia Moreno
-- MODIFIED DATE: 4/5/2022
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Blogs_Select_BlogCategoryV2]
						 @pageIndex int 
						,@pageSize int
						,@blogTypeId int

/* --TEST CODE--
	
		Declare			@pageIndex int = 0
						,@pageSize int = 10
						,@blogTypeId int = '2'
		
		Execute		[dbo].[Blogs_Select_BlogCategoryV2]
						@pageIndex 
						,@pageSize 
						,@blogTypeId

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
								 ON b.blogTypeId = bt.Id
								INNER JOIN dbo.UserProfiles AS up
								ON b.AuthorId = up.UserId
								INNER JOIN dbo.BlogStatus AS bs
								ON b.StatusId = bs.Id

		WHERE @blogTypeId = bt.Id 
	
		ORDER BY bt.Id


		OFFSET @offset Rows
		Fetch Next @pageSize Rows ONLY

END