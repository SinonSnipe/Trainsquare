USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CartItem_SelectByCartId]    Script Date: 8/9/2022 2:30:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/24/2022
-- Description: Selects all Cart Items from a Cart
-- Code Reviewer: Jake Lowrance

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


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
