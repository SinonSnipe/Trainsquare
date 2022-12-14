ALTER PROCEDURE [dbo].[Cart_SelectByCustomerId] 
								@CustomerId INT
AS

/* ----- Test Code -----
	
	DECLARE	@CustomerId INT = 11

	EXECUTE dbo.Cart_SelectByCustomerId 
								@CustomerId

----- End Test Code -----
*/

BEGIN
	
	SELECT c.Id
		  ,CartItems = (

							SELECT ci.Id 
								  ,i.Id AS InventoryId
								  ,w.Name
								  ,w.ImageUrl
								  ,ci.Quantity 
								  ,w.Summary
								  ,i.BasePrice

							FROM dbo.CartItems AS ci INNER JOIN dbo.Inventory AS i
								ON ci.InventoryId = i.Id INNER JOIN dbo.WorkShop AS w
								ON i.WorkshopId = w.Id

							WHERE ci.CartId = c.Id

							FOR JSON PATH

						)

	FROM dbo.Cart AS c
	WHERE c.CustomerId = @CustomerId

END
