ALTER PROCEDURE [dbo].[CartItem_SelectByCartId] 
									@CartId INT
						

AS

/* ----- Test Code -----

	DECLARE @CartId INT = 1

	SELECT * FROM dbo.CartItems

	EXECUTE [dbo].[CartItem_SelectByCartId] 
			       @CartId

----- End Test Code -----
*/

BEGIN

	SELECT Id
		  ,InventoryId
		  ,Quantity
		  ,CartId
	FROM dbo.CartItems
	WHERE CartId = @CartId

END
