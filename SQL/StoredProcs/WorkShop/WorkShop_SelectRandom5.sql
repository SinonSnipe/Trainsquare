USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShop_SelectRandom5]    Script Date: 8/15/2022 11:12:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Abel Amezcua
-- Create date: 4/21/22
-- Description: <Select random 5,,>
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note: 
-- =============================================

ALTER proc [dbo].[WorkShop_SelectRandom5]


/*

	Execute [dbo].[WorkShop_SelectRandom5] 
									

*/

as
BEGIN



	Select top 5 ws.[Id]
			,ws.[Name]
			,ws.[Summary]
			,ws.[ShortDescription]
			,ws.[VenueId]
			,u.Id
			,u.FirstName 
			,u.LastName
			,u.AvatarUrl
			,wst.Name as workShopType
			,wss.Name workShopStatus
			,ws.[ImageUrl]
			,ws.[ExternalSiteUrl]
			,ws.[LanguageId]
			,ws.[IsFree]
			,ws.[NumberOfSessions]
			,ws.[DateStart]
			,ws.[DateEnd]
			,ws.[DateCreated]
			,ws.[DateModified]

	FROM dbo.WorkShop as ws INNER JOIN dbo.Venues as v
						on ws.VenueId = v.Id
						INNER JOIN dbo.WorkShopStatus as wss
						on ws.WorkShopStatusId = wss.Id
						INNER JOIN dbo.WorkShopTypes as wst
						on ws.WorkShopTypeId = wst.Id
						INNER JOIN dbo.UserProfiles as u
						on ws.HostId = u.UserId
	order by NEWID()



END