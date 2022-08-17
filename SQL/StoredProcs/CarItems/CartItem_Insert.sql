USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CartItem_Insert]    Script Date: 8/9/2022 2:30:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/23/2022
-- Description: Insert Cart Item
-- Code Reviewer: Jake Lowrance

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


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
