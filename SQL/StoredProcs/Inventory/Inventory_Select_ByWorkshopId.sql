USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_Select_ByWorkshopId]    Script Date: 8/9/2022 4:29:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[Inventory_Select_ByWorkshopId]
					@workShopId int

as

/*
		Declare 
				@workShopId int = 10
		
		Execute [dbo].[Inventory_Select_ByWorkShopId] 
						@workShopId


*/

BEGIN
	
	SELECT  i.[Id]
			  ,i.[WorkShopId]
			  ,ws.Name
			  ,ws.Summary
			  ,ws.ImageUrl
			  ,i.[Quantity]
			  ,i.[BasePrice]
			  ,i.DateCreated
			  ,i.DateModified


	From dbo.Inventory as i inner join dbo.WorkShop as ws
			on i.WorkShopId = ws.Id
			inner join dbo.UserProfiles as u
			on u.UserId = i.CreatedBy
			inner join dbo.UserProfiles as up
			on up.UserId = i.ModifiedBy
			
		Where WorkShopId = @workShopId

END