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
