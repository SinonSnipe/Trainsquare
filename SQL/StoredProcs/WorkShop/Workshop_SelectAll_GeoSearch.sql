USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Workshop_SelectAll_GeoSearch]    Script Date: 8/15/2022 11:12:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Elizabeth Phung
-- Create date: 5/1/2022
-- Description:	A geo search proc that takes in lat, long, and distance from user and returns list of workshops,
--				locations, and venues within the specified distance.
-- Code Reviewer: 


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================
ALTER proc [dbo].[Workshop_SelectAll_GeoSearch]
				@Latitude float
				,@Longitude float
				,@Distance int

as

/*

	Declare @Lat float = 24.48267
			,@Long float = 54.3588
			,@Distance int = 30


	Execute [dbo].[Workshop_SelectAll_GeoSearch]
				@Lat
				,@Long
				,@Distance

*/

BEGIN
	Declare @DistanceInMeters int = @Distance * 1000
	Declare @point geography = geography::Point(@Latitude, @Longitude, 4326)


	select 
			l.Id      
			,lt.[Name] AS LocationType
			,l.LineOne
			,l.LineTwo
			,l.City
			,l.Zip
			,s.[Name] AS [State] 
			,l.Latitude
			,l.Longitude
			,ws.[Id]
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
			,v.Id as VenueId
			,v.[Name]
			,v.ImageUrl
			,[Range] =  @point.STDistance(geography::Point(l.Latitude, l.Longitude, 4326))
	from dbo.WorkShop as ws inner join dbo.WorkShopStatus as wss
		on ws.WorkShopStatusId = wss.Id
	inner join dbo.WorkShopTypes as wst
		on ws.WorkShopTypeId = wst.Id
	inner join dbo.UserProfiles as u
		on ws.HostId = u.UserId
	inner join dbo.Venues as v
		on ws.VenueId = v.Id
	inner join dbo.Locations as l
		on v.LocationId = l.Id
	inner join dbo.States as s
		on l.StateId = s.Id
	inner join dbo.LocationTypes as lt
		on l.LocationTypeId = lt.Id

	where @point.STDistance(geography::Point(l.Latitude, l.Longitude, 4326)) <= @DistanceInMeters

END