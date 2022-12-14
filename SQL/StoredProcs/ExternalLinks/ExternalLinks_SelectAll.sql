USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_SelectAll]    Script Date: 8/9/2022 4:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/28/2022>
-- Description: <ExternalLinks table select all>
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: <Hauerlang Delacruz>
-- MODIFIED DATE:<5/19/2022>
-- Code Reviewer: <name>
-- Note: <removed JOIN dbo.Users dbo.UserProfiles
-- 					dbo.UrlTypes dbo.EntityTypes>
-- =============================================

ALTER PROCEDURE [dbo].[ExternalLinks_SelectAll]
				@PageIndex int
				,@PageSize int

/* ------- Test Code Begin -------

	EXECUTE		dbo.ExternalLinks_SelectAll
				@PageIndex = 0
				,@PageSize = 50

*/ -------- Test Code End --------

AS

BEGIN

	DECLARE		@Offset int = @PageIndex * @PageSize

	SELECT		[Id]
				,[UserId]
				,[UrlTypeId]
				,[Url]
				,[EntityId]
				,[EntityTypeId]
				,[DateCreated]
				,[DateModified]
				,TotalCount = Count(1) OVER()

	FROM		dbo.ExternalLinks
	ORDER BY	Id
	OFFSET		@Offset   ROWS
	FETCH NEXT	@PageSize ROWS ONLY

END
