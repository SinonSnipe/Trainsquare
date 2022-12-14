USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_SelectAll]    Script Date: 8/9/2022 2:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Kaelin Clendenin>
-- Create date: <04/02/2022>
-- Description: <Blogs_SelectAll PROC>
-- Code Reviewer: Zachary Musgrave

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Blogs_SelectAll]
					@pageIndex int 
                   ,@pageSize int
as

/*

	Declare @pageIndex int = 0, @pageSize int = 10
	Execute dbo.Blogs_SelectAll @pageIndex,@pageSize

*/

BEGIN 

Declare @offset int = @pageIndex * @pageSize

SELECT		 b.Id
			,b.BlogTypeId
			,bt.Name
			,b.AuthorId			
			,up.FirstName
			,up.LastName
			,up.AvatarUrl
			,b.Title
			,b.Subject
			,b.Content
			,b.IsPublished
			,b.ImageUrl
			,b.DateCreated
			,b.DateModified
			,b.DatePublished
			,b.StatusId	
			,bs.Name
			,TotalCount  = COUNT(1) OVER()

		
			FROM [dbo].[Blogs] AS b INNER JOIN dbo.BlogTypes AS bt
								 ON b.BlogTypeId = bt.Id
								INNER JOIN dbo.UserProfiles AS up
								ON b.AuthorId = up.UserId
								INNER JOIN dbo.BlogStatus AS bs
								ON b.StatusId = bs.Id
						   
        ORDER BY b.Id

	OFFSET @offSet Rows
	Fetch Next @pageSize Rows ONLY

END


/*

*/