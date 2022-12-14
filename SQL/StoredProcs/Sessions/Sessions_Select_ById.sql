USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Sessions_Select_ById]    Script Date: 8/14/2022 1:31:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Returns a single record from dbo.Session that matches the given @Id
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: Elizabeth Phung
-- MODIFIED DATE:4/18/22
-- Code Reviewer: Alicia Moreno
-- Note: Update new columns and did inner join with dbo.userprofiles
ALTER proc [dbo].[Sessions_Select_ById]
					@Id int

as

/*
		Declare @Id int = 194
		
		Execute dbo.Sessions_Select_ById @Id

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
				,s.WorkShopId
		From dbo.Sessions as s inner join dbo.WorkShop as w
			on s.WorkShopId = w.Id
			inner join dbo.UserProfiles as u
				on u.UserId = s.CreatedBy
			inner join dbo.UserProfiles as up
				on up.UserId = s.ModifiedBy
		Where s.Id = @Id
END