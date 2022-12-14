USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShop_SelectAll]    Script Date: 8/15/2022 11:12:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Author,,Matias Montijo>
-- Create date:		<4/1/22,,>
-- Description:		<Select All,,>
-- Code Reviewer:	Jared Williams

-- MODIFIED BY:		Matias Montijo
-- MODIFIED DATE:	4/6/22
-- Code Reviewer:	Elizabeth Phung
-- Note:			added joins
-- =============================================

ALTER PROC [dbo].[WorkShop_SelectAll]

			@pageIndex int
			, @pageSize int

AS

/*

	DECLARE	@pageIndex int = 0
			, @pageSize int = 20

	EXECUTE	[dbo].[WorkShop_SelectAll] 
			@pageIndex
			, @pageSize

*/

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

	SELECT	ws.[Id]
			, ws.[Name]
			, ws.[Summary]
			, ws.[ShortDescription]
			, ws.[VenueId]
			, u.UserId
			, u.FirstName 
			, u.LastName
			, u.AvatarUrl
			, wst.Name as workShopType
			, wss.Name workShopStatus
			, ws.[ImageUrl]
			, ws.[ExternalSiteUrl]
			, ws.[LanguageId]
			, ws.[IsFree]
			, ws.[NumberOfSessions]
			, ws.[DateStart]
			, ws.[DateEnd]
			, ws.[DateCreated]
			, ws.[DateModified]
			, TotalCount = COUNT(1) OVER()

	FROM	[dbo].[WorkShop] AS ws 
			INNER JOIN [dbo].[Venues] AS v ON ws.VenueId = v.Id
			INNER JOIN [dbo].[WorkShopStatus] AS wss ON ws.WorkShopStatusId = wss.Id
			INNER JOIN [dbo].[WorkShopTypes] AS wst ON ws.WorkShopTypeId = wst.Id
			INNER JOIN [dbo].[UserProfiles] AS u ON ws.HostId = u.UserId

	ORDER BY ws.Id
	Offset @offset ROWS
	FETCH NEXT @pageSize ROWS ONLY 

END