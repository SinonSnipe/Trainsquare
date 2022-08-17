ALTER PROCEDURE [dbo].[CartItem_DeleteByCartId] 
									@CartId INT
						

AS

/* ----- Test Code -----

	DECLARE @CartId INT = 0

	SELECT * FROM dbo.CartItems
	WHERE CartId = @CartId

	EXECUTE dbo.CartItem_DeleteByCartId
						@CartId

	SELECT * FROM dbo.CartItems
	WHERE CartId = @CartId

----- End Test Code -----
*/

BEGIN

	DELETE dbo.CartItems
	WHERE CartId = @CartId

END
