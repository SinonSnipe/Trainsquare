ALTER PROCEDURE [dbo].[CartItem_Update] 
						@Id INT
						,@Quantity INT
						,@InventoryId INT
						,@CartId INT
						

AS

/* ----- Test Code -----

	DECLARE @Id INT = 9
			,@Quantity INT = 3
			,@InventoryId INT = 11
			,@CartId INT = 2

	SELECT * FROM dbo.CartItems
	WHERE Id = @Id

	EXECUTE dbo.CartItem_Update
						@Id
						,@Quantity
						,@InventoryId
						,@CartId

	SELECT * FROM dbo.CartItems
	WHERE Id = @Id

----- End Test Code -----
*/

BEGIN

	DECLARE @DateNow DATETIME2(7) = GETUTCDATE();

	UPDATE dbo.CartItems
		SET InventoryId = @InventoryId
			,Quantity = @Quantity
			,DateModified = @DateNow
			,CartId = @CartId
	WHERE Id = @Id

END
