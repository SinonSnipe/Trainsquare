USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_SelectAllV2]    Script Date: 8/9/2022 4:29:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =======================================
-- Author:			Rafael Lynch
-- Create date:		06/06/2022
-- Description:		Select Inventory with workshops details
-- Code Reviewer:	

-- MODIFIED BY:		
-- MODIFIED DATE:	
-- Code Reviewer:	
-- Note:			
-- =============================================

ALTER PROC [dbo].[Inventory_SelectAllV2]
							@pageIndex int
							,@pageSize int

AS

/*

	DECLARE					@pageIndex int = 0
							,@pageSize int = 20

	EXECUTE	[dbo].[Inventory_SelectAllV2] 
							@pageIndex
							,@pageSize

*/

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

	SELECT	i.Id
			,ws.[Id] AS workShopId
			,ws.[Name]
			,ws.[Summary]
			,ws.[ShortDescription]
			,ws.[VenueId]
			,u.UserId
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
			,i.Quantity
			,i.BasePrice
			,i.DateCreated
			,i.DateModified
			,i.CreatedBy
			,i.ModifiedBy
			,TotalCount = COUNT(1) OVER()

	FROM	[dbo].[Inventory] AS i 
			INNER JOIN [dbo].[WorkShop] AS ws 
				ON i.workshopId = ws.Id 
			LEFT JOIN [dbo].[Venues] AS v 
				ON ws.VenueId = v.Id
			LEFT JOIN [dbo].[WorkShopStatus] AS wss 
				ON ws.WorkShopStatusId = wss.Id
			LEFT JOIN [dbo].[WorkShopTypes] AS wst 
				ON ws.WorkShopTypeId = wst.Id
			LEFT JOIN [dbo].[UserProfiles] AS u 
				ON ws.HostId = u.UserId

	ORDER BY i.Id
	Offset @offset ROWS
	FETCH NEXT @pageSize ROWS ONLY 

END