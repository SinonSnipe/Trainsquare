USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[OrderItems_InsertBatch]    Script Date: 8/14/2022 11:53:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/27/2022
-- Description: Insert Order Item Batch
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[OrderItems_InsertBatch] 
				@newOrderItems dbo.OrderItemsV2 READONLY

AS

/* ----- Test Code -----
	
	DECLARE @newOrderItems dbo.OrderItemsV2

	INSERT INTO @newOrderItems (OrderId, InventoryId, Quantity, UserId)
		VALUES (17, 71, 1, 261) 
	INSERT INTO @newOrderItems (OrderId, InventoryId, Quantity, UserId)
		VALUES (17, 11, 2, 261) 

	SELECT * FROM dbo.OrderItems

	EXECUTE dbo.OrderItems_InsertBatch
					@newOrderItems
	
	SELECT * FROM dbo.OrderItems

----- End Test Code -----
*/

BEGIN

	INSERT INTO [dbo].[OrderItems]
			   ([OrderId]
			   ,[InventoryId]
			   ,[Quantity]
			   ,[CreatedBy]
			   ,[ModifiedBy])
	SELECT	   OrderId
			   ,InventoryId
			   ,Quantity
			   ,UserId
			   ,UserId

	FROM @newOrderItems

END
