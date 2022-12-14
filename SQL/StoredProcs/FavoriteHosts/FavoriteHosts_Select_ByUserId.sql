USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteHosts_Select_ByUserId]    Script Date: 8/9/2022 4:14:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jered Casuga
-- Create date: 6/9/22
-- Description: Selects favorite hosts by UserId
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

ALTER Proc [dbo].[FavoriteHosts_Select_ByUserId]
			@UserId int,
			@PageIndex int,
			@PageSize int

/* ------------- TEST CODE ---------------------

	Declare @UserId int = 261,
			@PageIndex int =  0,
			@PageSize int = 5

	Execute dbo.FavoriteHosts_Select_ByUserId
				@UserId,
				@PageIndex,
				@PageSize

*/

as

BEGIN

	Declare @offset int = @PageIndex * @PageSize

		Select ws.[Id] as WorkshopId
			,u.Id as HostId
			,u.FirstName 
			,u.LastName
	
			,TotalCount = COUNT(1) OVER()

	From dbo.FavoriteWorkshops as f LEFT JOIN dbo.WorkShop as ws
								on f.WorkShopId = ws.Id
								INNER JOIN dbo.UserProfiles as u
								on ws.HostId = u.UserId

	Where f.UserId = @UserId
	
	Order by ws.id
	
	OFFSET @offset Rows
	FETCH NEXT @PageSize Rows Only

END