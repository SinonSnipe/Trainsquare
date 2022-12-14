USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopRegistration_SelectAll]    Script Date: 8/15/2022 11:55:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:			Jonathon Nolden
-- Create date:		5/31/22
-- Description:		Select all by UserId and WorkshopId for Registration emails.
-- Code Reviewer:

-- MODIFIED BY:		
-- MODIFIED DATE:	
-- Code Reviewer:	
-- Note:			
-- =============================================

ALTER PROC [dbo].[WorkShopRegistration_SelectAll]

AS

/*

	EXECUTE	[dbo].[WorkShopRegistration_SelectAll] 

*/

BEGIN

	SELECT	ws.[Id]
			, ws.[Name]
			, ws.[Summary]
			, ws.[ShortDescription]
			, ws.[VenueId]
			, hu.UserId
			, hu.FirstName 
			, hu.LastName
			, hu.AvatarUrl
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
			, wrs.[RegistrationStatus]		

	FROM	[dbo].[WorkShop] AS ws 
			LEFT JOIN [dbo].[WorkshopRegistration] AS wr ON ws.Id = wr.WorkshopId
			LEFT JOIN [dbo].[WorkshopRegistrationStatus] AS wrs ON wr.StatusId = wrs.StatusId
			INNER JOIN [dbo].[Venues] AS v ON ws.VenueId = v.Id
			INNER JOIN [dbo].[WorkShopStatus] AS wss ON ws.WorkShopStatusId = wss.Id
			INNER JOIN [dbo].[WorkShopTypes] AS wst ON ws.WorkShopTypeId = wst.Id
			INNER JOIN [dbo].[UserProfiles] AS hu ON ws.HostId = hu.UserId

END


