USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CartItem_DeleteByCartId]    Script Date: 8/9/2022 2:30:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/23/2022
-- Description: Deletes all Cart Items from a Cart
-- Code Reviewer: Jake Lowrance

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


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
