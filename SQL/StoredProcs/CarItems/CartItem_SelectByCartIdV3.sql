USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CartItem_SelectByCartIdV3]    Script Date: 8/9/2022 2:30:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/26/2022
-- Description: Selects all Cart Items from a Cart with payment info
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[CartItem_SelectByCartIdV3] 
									  @CartId INT
						
AS

/* ----- Test Code -----

	DECLARE @CartId INT = 1

	SELECT * FROM dbo.CartItems

	EXECUTE [dbo].[CartItem_SelectByCartIdV3] 
			       @CartId

----- End Test Code -----
*/

BEGIN

	SELECT ci.Id
		  ,ci.InventoryId
		  ,ci.Quantity
		  ,ci.CartId
		  ,w.[Name]
		  ,w.ImageUrl
		  ,w.Summary
		  ,i.BasePrice
		  ,pa.AccountId
		  ,pa.Fee

	FROM dbo.CartItems AS ci INNER JOIN dbo.Inventory AS i
		ON ci.InventoryId = i.Id INNER JOIN dbo.WorkShop AS w
		ON i.WorkShopId = w.Id LEFT JOIN dbo.PaymentAccounts AS pa
		ON w.HostId = pa.VendorId
	WHERE CartId = @CartId

END
