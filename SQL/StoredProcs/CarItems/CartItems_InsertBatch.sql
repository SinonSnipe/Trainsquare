USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CartItems_InsertBatch]    Script Date: 8/9/2022 2:30:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/27/2022
-- Description: Insert Cart Items Batch
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[CartItems_InsertBatch] 
				@newCartItems dbo.CartItemsV2 READONLY

AS

/* ----- Test Code -----
	
	DECLARE @newCartItems dbo.CartItemsV2

	INSERT INTO @newCartItems (CartId, InventoryId, Quantity)
		VALUES (1, 71, 1) 
	INSERT INTO @newCartItems (CartId, InventoryId, Quantity)
		VALUES (1, 11, 2) 

	SELECT * FROM dbo.CartItems

	EXECUTE dbo.CartItems_InsertBatch
					@newCartItems
	
	SELECT * FROM dbo.CartItems

----- End Test Code -----
*/

BEGIN

	INSERT INTO [dbo].[CartItems]
			   ([CartId]
			   ,[InventoryId]
			   ,[Quantity])
		SELECT CartId
			   ,InventoryId
			   ,Quantity

	FROM @newCartItems

END
