USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Cart_Update]    Script Date: 8/9/2022 2:30:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/20/2022
-- Description: Update Cart
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


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
