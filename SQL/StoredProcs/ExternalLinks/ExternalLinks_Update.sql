USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_Update]    Script Date: 8/9/2022 4:08:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Charles Oh>
-- Create date: <03/28/2022>
-- Description: <ExternalLinks update by Id>
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: <Hauerlang Delacruz>
-- MODIFIED DATE:<5/19/2022>
-- Code Reviewer: <name>
-- Note: <added @EntityTypeId to params
--			& SELECT statement to body>
-- =============================================

ALTER PROCEDURE [dbo].[ExternalLinks_Update]
				@UserId int
				,@UrlTypeId int
				,@Url nvarchar(255)
				,@EntityId int
				,@EntityTypeId int
				,@Id int

/* -------- Test Code Begin ----------

	DECLARE		@UserId int = 0
				,@UrlTypeId int = 0
				,@Url nvarchar(255) = 'url_change.url'
				,@EntityId int = 0
				,@EntityTypeId int = 0
				,@Id int = 0 --////////-- requires actual Id --////////--

	EXECUTE		[dbo].[ExternalLinks_Update]
				@UserId
				,@UrlTypeId
				,@Url
				,@EntityId
				,@EntityTypeId
				,@Id

	SELECT		*
	FROM		[dbo].[ExternalLinks]

*/ --------- Test Code End -----------

AS

BEGIN

	UPDATE		[dbo].[ExternalLinks]

	SET			[UserId] = @UserId
				,[UrlTypeId] = @UrlTypeId
				,[Url] = @Url
				,[EntityId] = @EntityId
				,[EntityTypeId] = @EntityTypeId
				,[DateModified] = GETUTCDATE()

	WHERE		Id = @Id

END
