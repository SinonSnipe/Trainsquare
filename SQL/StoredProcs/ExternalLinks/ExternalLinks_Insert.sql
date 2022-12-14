USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_Insert]    Script Date: 8/9/2022 4:07:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Charles Oh>
-- Create date: <03/28/2022>
-- Description: <Entry for ExternalLinks table>
-- Code Reviewer: <Abel Amezcua>

-- MODIFIED BY: <Hauerlang Delacruz>
-- MODIFIED DATE:<5/19/2022>
-- Code Reviewer: <name>
-- Note: <added @EntityTypeId to params
--		removed DECLARE @EntityTypeId int = 8 >
-- =============================================

ALTER PROCEDURE [dbo].[ExternalLinks_Insert]
				@UserId int
				,@UrlTypeId int
				,@Url nvarchar(255)
				,@EntityId int
				,@EntityTypeId int
				,@Id int OUTPUT

/* -------- Test Code Begin ----------

	DECLARE		@UserId int = 0
				,@UrlTypeId int = 0
				,@Url nvarchar(255) = 'url_address.url'
				,@EntityId int = 0
				,@EntityTypeId int = 0
				,@Id int = 0

	EXECUTE		[dbo].[ExternalLinks_Insert]
				@UserId
				,@UrlTypeId
				,@Url
				,@EntityId
				,@EntityTypeId
				,@Id OUTPUT

	SELECT		*
	FROM		[dbo].[ExternalLinks]

*/ --------- Test Code End -----------

AS

BEGIN

	INSERT INTO [dbo].[ExternalLinks]
				([UserId]
				,[UrlTypeId]
				,[Url]
				,[EntityId]
				,[EntityTypeId])

		VALUES	(@UserId
				,@UrlTypeId
				,@Url
				,@EntityId
				,@EntityTypeId)

			SET	@Id = SCOPE_IDENTITY()

END
