USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Ratings_Select_ByCreatedBy_V2]    Script Date: 8/14/2022 11:58:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jake Lowrance
-- Create date: 5/20/2022
-- Description: Select By CreatedBy Proc for Ratings with joins
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[Ratings_Select_ByCreatedBy_V2]
			@CreatedBy int

AS
/* ---TEST CODE---

DECLARE @CreatedBy int = 1

EXECUTE [dbo].[Ratings_Select_ByCreatedBy_V2]
		@CreatedBy

*/




BEGIN


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

	  FROM [dbo].[Ratings] as r left join [dbo].[Comments] as c
	  ON r.CommentId = c.Id
	  left join [dbo].[EntityTypes] as e
	  ON r.EntityTypeId = e.Id
	  left join [dbo].[Users] as u
	  ON r.CreatedBy = u.Id
	  left join [dbo].[UserProfiles] as up
	  ON r.CreatedBy = up.Id

	  WHERE r.CreatedBy = @CreatedBy
	  ORDER BY r.DateModified


END