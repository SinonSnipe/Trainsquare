USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteHosts_Select_ByQuery]    Script Date: 8/9/2022 4:14:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jered Casuga
-- Create date: 6/9/22
-- Description: Selects all favorite workshops by query

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

ALTER Proc [dbo].[FavoriteHosts_Select_ByQuery]
			@PageIndex int,
			@PageSize int,
			@Query nvarchar(100)

/* ------------- TEST CODE ---------------------

	Declare @PageIndex int =  0,
			@PageSize int = 5,
			@Query nvarchar(100) = 'Abel'

	Execute dbo.FavoriteHosts_Select_ByQuery
				@PageIndex,
				@PageSize,
				@Query

*/

as

BEGIN

	Declare @offset int = @PageIndex * @PageSize

		Select ws.[Id] as WorkshopId, COUNT(ws.Id) AS 'TotalFavorited'
			,u.Id as HostId
			,u.FirstName 
			,u.LastName
			
			,TotalCount = COUNT(1) OVER()
			

	From dbo.FavoriteWorkshops as f LEFT JOIN dbo.WorkShop as ws
								on f.WorkShopId = ws.Id
								INNER JOIN dbo.UserProfiles as u
								on ws.HostId = u.UserId

	Where (
			u.[FirstName] LIKE '%' + @Query + '%' OR
			u.[LastName] LIKE '%' + @Query + '%'
			)

	Group by ws.[Id]
			,u.Id
			,u.FirstName 
			,u.LastName

	Order by TotalFavorited DESC

	OFFSET @offset Rows
	FETCH NEXT @PageSize Rows Only

END