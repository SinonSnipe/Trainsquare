USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_SelectAll]    Script Date: 8/9/2022 4:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sagan Jackson
-- Create date: 4/1/22
-- Description:	Select all Inventory - Paginated
-- Code Reviewer: Guillermo Arreguin


-- MODIFIED BY: author
-- MODIFIED DATE: 4/6/2022
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER PROC [dbo].[Inventory_SelectAll] 
			@pageIndex int
			,@pageSize int

/*

	
	Declare @pageIndex int = 0
			,@pageSize int = 10

	Execute [dbo].[Inventory_SelectAll] @pageIndex
												,@pageSize


*/
AS
BEGIN
	Declare @offset int = @pageIndex * @pageSize

		SELECT i.[Id]			
			  ,i.[WorkShopId]
			  ,ws.Name
			  ,ws.Summary
			  ,ws.ImageUrl
			  ,i.CreatedBy
			  ,up.FirstName
			  ,up.LastName
			  ,up.AvatarUrl
			  ,i.ModifiedBy
			  ,up.FirstName
			  ,up.LastName
			  ,up.AvatarUrl
			  ,i.[Quantity]
			  ,i.[BasePrice]
			  ,i.DateCreated
			  ,i.DateModified
			  
			  
			
			  ,[TotalCount] = COUNT(1) OVER()

		FROM [dbo].[Inventory] as i inner join dbo.WorkShop as ws
								on i.WorkShopId = ws.Id
								inner join dbo.UserProfiles as up
								on up.UserId = i.CreatedBy
								inner join dbo.UserProfiles as u
								on u.UserId = i.ModifiedBy
								

		ORDER BY i.Id

		OFFSET @offset Rows
		Fetch Next @pageSize Rows ONLY
END

