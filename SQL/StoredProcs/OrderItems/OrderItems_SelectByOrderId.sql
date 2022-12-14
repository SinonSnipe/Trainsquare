USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[OrderItems_SelectByOrderId]    Script Date: 8/14/2022 11:53:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/31/2022
-- Description: Select Order Items by Order Id
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[OrderItems_SelectByOrderId] 
					@OrderId INT

AS

/* ----- Test Code -----

	DECLARE         @OrderId INT = 17

	SELECT * FROM dbo.OrderItems

	EXECUTE dbo.OrderItems_SelectByOrderId
					@OrderId

----- End Test Code -----
*/

BEGIN

	SELECT [Id]
		  ,[OrderId]
		  ,[InventoryId]
		  ,[Quantity]
		  ,[CreatedBy]
		  ,[ModifiedBy]
	  FROM [dbo].[OrderItems]

	WHERE OrderId = @OrderId

END
