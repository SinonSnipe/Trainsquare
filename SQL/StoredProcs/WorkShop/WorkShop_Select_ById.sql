USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShop_Select_ById]    Script Date: 8/15/2022 11:12:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/1/22,,>
-- Description: <Select Workshop by Id,,>
-- Code Reviewer:Jared Williams

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/6/22
-- Code Reviewer: Elizabeth Phung
-- Note: added joins
-- =============================================

ALTER proc [dbo].[WorkShop_Select_ById]
		@Id int

/*
	Declare @Id int = 7

	Execute dbo.WorkShop_Select_ById @Id 

*/

as
BEGIN

	Select ws.[Id]
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
						on ws.HostId = u.Id

	WHERE ws.Id = @Id

End