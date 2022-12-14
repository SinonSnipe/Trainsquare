USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_Select_ByCreatedBy]    Script Date: 8/9/2022 4:29:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sagan Jackson
-- Create date: 4/1/22
-- Description:	Select By Created By Proc for Inventory
-- Code Reviewer: Guillermo Arreguin


-- MODIFIED BY: author
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:  
-- =============================================


ALTER PROC [dbo].[Inventory_Select_ByCreatedBy] 
			@CreatedBy int
			,@pageIndex int
			,@pageSize int
			

/*

	Declare @CreatedBy int = 2
			,@pageIndex int = 0
			,@pageSize int = 10

	

	

	Execute [dbo].[Inventory_Select_ByCreatedBy] @CreatedBy
												,@pageIndex
												,@pageSize
												

												

*/
AS
BEGIN
	DECLARE @offset int = @pageIndex * @pageSize

		SELECT  i.[Id]
			  ,i.[WorkShopId]
			  ,ws.Name
			  ,ws.Summary
			  ,ws.ImageUrl
			  ,up.FirstName
			  ,up.LastName
			  ,i.[Quantity]
			  ,i.[BasePrice]
			  ,i.CreatedBy
			  ,i.DateCreated
			  ,i.DateModified
			  
				, TotalCount = COUNT(1) OVER()
		FROM [dbo].[Inventory] as i inner join dbo.WorkShop as ws
								on i.WorkShopId = ws.Id
								inner join dbo.UserProfiles as u
								on i.CreatedBy = u.Id
								inner join dbo.UserProfiles as up
								on u.Id = up.Id
							
		Where CreatedBy = @CreatedBy
		ORDER BY i.Id DESC
		
		
		OFFSET @offset Rows
		
		FETCH NEXT @pageSize Rows ONLY
END

