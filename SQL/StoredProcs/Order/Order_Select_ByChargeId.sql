USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Order_Select_ByChargeId]    Script Date: 8/14/2022 11:52:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/31/2022
-- Description: Select Order By Charge Id
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[Order_Select_ByChargeId] 
						@ChargeId NVARCHAR(200)

AS

/* ----- Test Code -----

	DECLARE		@ChargeId NVARCHAR(200) = 'charge_7fbdbc45-fb1b-444e-afcb-7a0dca6a02ef'

	SELECT * FROM dbo.Orders

	EXECUTE dbo.Order_Select_ByChargeId
				@ChargeId

----- End Test Code -----
*/

BEGIN

	SELECT [Id]
		  ,[PaymentStatusId]
		  ,[TrackingCode]
		  ,[TrackingUrl]
		  ,[Total]
		  ,[ShippingAddressId]
		  ,[ChargeId]
		  ,[CreatedBy]
		  ,[ModifiedBy]
	  FROM [dbo].[Orders]

	WHERE ChargeId = @ChargeId

END
