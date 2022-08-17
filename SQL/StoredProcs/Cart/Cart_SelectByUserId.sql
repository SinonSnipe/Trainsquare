ALTER PROCEDURE [dbo].[Cart_SelectByUserId] 
								@UserId INT
AS

/* ----- Test Code -----
	
	DECLARE	@UserId INT = 1

	EXECUTE [dbo].[Cart_SelectByUserId] 
								@UserId

----- End Test Code -----
*/

BEGIN
	
	SELECT Id
		  ,CustomerId

	FROM dbo.Cart
	WHERE CustomerId = @UserId

END
