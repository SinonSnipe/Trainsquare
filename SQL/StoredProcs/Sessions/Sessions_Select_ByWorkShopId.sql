USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Sessions_Select_ByWorkShopId]    Script Date: 8/14/2022 1:31:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/30/22
-- Description:	Returns all records from dbo.Sessions
--				including a JSON column from dbo.SessionAvailabilities
--				where the workShopId is equal to the parameter
-- Code Reviewer: Changwoo Lee


-- MODIFIED BY: Elizabeth Phung
-- MODIFIED DATE:4/18/2022
-- Code Reviewer: Alicia Moreno
-- Note: Changed JSON Column to include Day from dbo.Days. Added TotalSlots
--	     took out totalCount, and did an inner join with dbo.WorkShops
--		 and dbo.UserProfiles
ALTER proc [dbo].[Sessions_Select_ByWorkShopId]
						@workShopId int
					

as

/*
		Declare 
				@workShopId int = 10
		
		Execute [dbo].[Sessions_Select_ByWorkShopId] 
						@workShopId

*/

BEGIN

		Select s.Id
				,s.TotalSlots
				,s.OpenSlots
				,s.[Date]
				,s.StartTime
				,s.EndTime
				,s.DateCreated
				,s.DateModified
				,s.CreatedBy
				,u.FirstName
				,u.LastName
				,u.AvatarUrl
				,s.ModifiedBy
				,up.FirstName
				,up.LastName
				,up.AvatarUrl
				,w.Id
				,w.[Name]
				,w.HostId
				,hp.FirstName
				,hp.LastName
				,hp.AvatarUrl
				,w.Summary
				,w.ShortDescription
				,w.ImageUrl
				,w.NumberOfSessions
				,w.ExternalSiteUrl
				,w.DateStart
				,w.DateEnd
		From dbo.Sessions as s inner join dbo.WorkShop as w
			on s.WorkShopId = w.Id
			inner join dbo.UserProfiles as u
				on u.UserId = s.CreatedBy
			inner join dbo.UserProfiles as up
				on up.UserId = s.ModifiedBy
			inner join dbo.UserProfiles as hp
				on hp.UserId = w.HostId
			
		Where WorkShopId = @workShopId
		Order by s.[Date], s.startTime

END