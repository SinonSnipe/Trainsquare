USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Sessions_Select_ByCreatedBy]    Script Date: 8/14/2022 1:30:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Returns a paginated selection of dbo.Session records that filter for the creator 
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: Elizabeth Phung
-- MODIFIED DATE:4/15/22
-- Code Reviewer: Alicia Moreno
-- Note: Update new columns and did inner join with dbo.userprofiles
ALTER proc [dbo].[Sessions_Select_ByCreatedBy]
						@pageIndex int
						,@pageSize int
						,@createdBy int
					

as

/*
		Declare @pageIndex int = 0
				,@pageSize int = 10
				,@createdBy int = 9
		
		Execute dbo.Sessions_Select_ByCreatedBy 
						@pageIndex
						,@pageSize
						,@createdBy

*/

BEGIN
		Declare @offset int = @pageIndex * @pageSize
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
				,totalCount = Count(1) Over()
		From dbo.Sessions as s inner join dbo.WorkShop as w
			on s.WorkShopId = w.Id
			inner join dbo.UserProfiles as u
				on u.UserId = s.CreatedBy
			inner join dbo.UserProfiles as up
				on up.UserId = s.ModifiedBy
		Where CreatedBy = @createdBy

		Order by s.Id
		Offset @offset Rows
		Fetch Next @pageSize Rows Only

END