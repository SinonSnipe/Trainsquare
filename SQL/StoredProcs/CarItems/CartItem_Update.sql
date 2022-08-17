USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CartItem_Update]    Script Date: 8/9/2022 2:30:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/23/2022
-- Description: Update Cart Item
-- Code Reviewer: Jered Casuga

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


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
