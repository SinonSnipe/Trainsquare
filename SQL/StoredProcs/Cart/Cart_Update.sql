ALTER PROCEDURE [dbo].[Cart_Update] 
						@Id INT
						,@CustomerId INT

AS

/* ----- Test Code -----
	
	DECLARE @Id INT = 5

	SELECT * FROM dbo.Cart
	WHERE Id = @Id

	EXECUTE dbo.Cart_Update
						@Id
						,@CustomerId = 260

	SELECT * FROM dbo.Cart
	WHERE Id = @Id

----- End Test Code -----
*/

BEGIN

	DECLARE @DateNow DATETIME2(7) = GETUTCDATE();

	UPDATE dbo.Cart
		SET CustomerId = @CustomerId
			,DateModified = @DateNow
	WHERE Id = @Id

END
