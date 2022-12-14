USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_Select_ById]    Script Date: 8/9/2022 4:08:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Charles Oh>
-- Create date: <03/28/2022>
-- Description: <ExternalLinks table select by Id>
-- Code Reviewer: <Abel Amezcua>

-- MODIFIED BY: <Hauerlang Delacruz>
-- MODIFIED DATE:<5/19/2022>
-- Code Reviewer: <name>
-- Note: <removed JOIN dbo.Users>
-- =============================================

ALTER PROCEDURE [dbo].[ExternalLinks_Select_ById]
				@Id int

/* ------- Test Code Begin -------

	EXECUTE		dbo.ExternalLinks_Select_ById
				@Id = 5

*/ -------- Test Code End --------

AS

BEGIN

	SELECT		[Id]
				,[UserId]
				,[UrlTypeId]
				,[Url]
				,[EntityId]
				,[EntityTypeId]
				,[DateCreated]
				,[DateModified]

	FROM		dbo.ExternalLinks
	WHERE		Id = @Id

END
