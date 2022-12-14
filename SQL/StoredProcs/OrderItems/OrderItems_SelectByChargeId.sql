USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[OrderItems_SelectByChargeId]    Script Date: 8/14/2022 11:53:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/31/2022
-- Description: Select Order Items by Charge Id
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[OrderItems_SelectByChargeId] 
					@ChargeId NVARCHAR(200)

AS

/* ----- Test Code -----

	DECLARE         @ChargeId NVARCHAR(200) = 'charge_7fbdbc45-fb1b-444e-afcb-7a0dca6a02ef'

	SELECT * FROM dbo.OrderItems

	EXECUTE dbo.OrderItems_SelectByChargeId
					@ChargeId

----- End Test Code -----
*/

BEGIN

	SELECT oi.[Id]
		  ,oi.[OrderId]
		  ,oi.[InventoryId]
		  ,oi.[Quantity]
		  ,oi.[CreatedBy]
		  ,oi.[ModifiedBy]
	  FROM [dbo].[OrderItems] AS oi INNER JOIN dbo.Orders AS o
		ON oi.OrderId = o.Id

	WHERE o.ChargeId = @ChargeId

END
