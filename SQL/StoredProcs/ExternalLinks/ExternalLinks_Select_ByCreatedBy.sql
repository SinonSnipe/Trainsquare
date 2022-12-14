USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_Select_ByCreatedBy]    Script Date: 8/9/2022 4:07:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Hauerlang Delacruz>
-- Create date: <5/17/2022>
-- Description: <paginated select by UserId>
-- Code Reviewer:

-- MODIFIED BY: <name>
-- MODIFIED DATE:<00/00/2022>
-- Code Reviewer: <name>
-- Note: <comment>
-- =============================================

ALTER PROCEDURE [dbo].[ExternalLinks_Select_ByCreatedBy]
				@UserId int
				,@PageIndex int
				,@PageSize  int

/* ------- Test Code Begin -------

	EXECUTE		dbo.ExternalLinks_Select_ByCreatedBy
				@UserId = 233
				,@PageIndex = 0
				,@PageSize = 20

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
	WHERE		UserId = @UserId
	ORDER BY	UserId
	OFFSET		@Offset   ROWS
	FETCH NEXT	@PageSize ROWS ONLY

END
