USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ShoppingCart_Insert]    Script Date: 8/14/2022 1:32:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
--AUTHOR: FRANK VILARDI
--CREATE DATE: 04/02/2022
--DESCRIPTION: The table that will hold the list of products "in the cart" that have not yet been purchased. 
--When products are purchased they will be moved out of the ShoppingCart and into the OrderDetails table.
--Updates to this table are essentially limited to updating quantities of a given InventoryId that is in the table.

--CODE REVIEWER: Jin Hwan Ahn
--MODIFIED BY:
--MODIFIED DATE:
--CODE REVIEWER:
--NOTE:
-- =============================================

ALTER PROC [dbo].[ShoppingCart_Insert]
			@Id int out
			,@WorkShopId int
			,@InventoryId int
			,@Quantity int
			,@User int
			

AS

/*

			Declare @Id int 
					,@WorkShopId int = 1
					,@InventoryId int = 3
					,@Quantity int = 9
					,@User int = 1
					
			Execute dbo.ShoppingCart_Insert @Id output
											,@WorkShopId 
											,@InventoryId 
											,@Quantity 
											,@User 

					Select *
					From dbo.ShoppingCart

*/

BEGIN
	
INSERT INTO [dbo].[ShoppingCart]
			([WorkShopId]
			,[InventoryId]
			,[Quantity]
			,[CreatedBy]
			,[ModifiedBy])

			VALUES
			(@WorkShopId
			,@InventoryId
			,@Quantity
			,@User
			,@User)

			SET @Id = SCOPE_IDENTITY()
	
END