ALTER PROCEDURE [dbo].[CartItem_Insert] 
						@Quantity INT
						,@InventoryId INT
						,@CartId INT
						,@Id INT OUTPUT
						

AS

/* ----- Test Code -----

	DECLARE @Id INT = 0
			,@Quantity INT = 2
			,@InventoryId INT = 68
			,@CartId INT = 0

	SELECT * FROM dbo.CartItems
	WHERE Id = @Id

	EXECUTE dbo.CartItem_Insert
						@Quantity
						,@InventoryId
						,@CartId
						,@Id OUTPUT

	SELECT * FROM dbo.CartItems
	WHERE Id = @Id

----- End Test Code -----
*/

BEGIN

	INSERT INTO [dbo].[CartItems]
			   ([CartId]
			   ,[InventoryId]
			   ,[Quantity])
		 VALUES
			   (@CartId
			   ,@InventoryId
			   ,@Quantity)

	SET @Id = SCOPE_IDENTITY()

END
