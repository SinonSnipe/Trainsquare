USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_Select_ById]    Script Date: 8/9/2022 2:26:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Kaelin Clendenin
-- Create date: 4/04/2022
-- Description: Select By CreatedBy Proc for Blogs
-- Code Reviewer: Zachary Musgrave

-- MODIFIED BY: Alicia Moreno
-- MODIFIED DATE: 4/2/2022
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[Blogs_Select_ById]
					@Id int 
AS
/*
	DECLARE @Id int = 2

	EXECUTE [dbo].[Blogs_Select_ById]
					@Id

*/
BEGIN 

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

		
			FROM [dbo].[Blogs] AS b INNER JOIN dbo.BlogTypes AS bt
								 ON b.BlogTypeId = bt.Id
								INNER JOIN dbo.UserProfiles AS up
								ON b.AuthorId = up.UserId
								INNER JOIN dbo.BlogStatus AS bs
								ON b.StatusId = bs.Id

		WHERE @Id = b.Id

		ORDER BY bt.Id

	

END