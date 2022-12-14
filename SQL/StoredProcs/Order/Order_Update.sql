USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Order_Update]    Script Date: 8/14/2022 11:52:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/27/2022
-- Description: Update Order
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[Order_Update] 
				@Id INT
				,@PaymentStatusId INT
				,@TrackingCode NVARCHAR(100)
				,@TrackingUrl NVARCHAR(200)
				,@Total DECIMAL(18,2)
				,@ShippingAddressId INT
				,@ChargeId NVARCHAR(200)
				,@BillingAddressId INT
				,@PaymentMethod NVARCHAR(50)
				,@PhoneNumber NVARCHAR(50)
				,@SessionId NVARCHAR(50)
				,@UserId INT
				
				
AS

/* ----- Test Code -----

	DECLARE		@Id INT = 17
	            ,@PaymentStatusId INT = 2
				,@TrackingCode NVARCHAR(100) = NULL
				,@TrackingUrl NVARCHAR(200) = NULL
				,@Total DECIMAL(18,2) = 120.55
				,@ShippingAddressId INT = NULL
				,@ChargeId NVARCHAR(200) = 'charge_2'
				,@BillingAddressId INT = NULL
				,@PaymentMethod NVARCHAR(50) = 'Card'
				,@PhoneNumber NVARCHAR(50) = NULL
				,@SessionId NVARCHAR(50) = NULL
				,@UserId INT = 261

	SELECT * FROM dbo.Orders
	WHERE Id = @Id

	EXECUTE dbo.Order_Update
				@Id
				,@PaymentStatusId
				,@TrackingCode
				,@TrackingUrl 
				,@Total
				,@ShippingAddressId
				,@ChargeId
				,@BillingAddressId
				,@PaymentMethod
				,@PhoneNumber
				,@SessionId
				,@UserId
	
	SELECT * FROM dbo.Orders
	WHERE Id = @Id

----- End Test Code -----
*/

BEGIN

	DECLARE @DateNow DATETIME2(7) = GETUTCDATE()

	UPDATE [dbo].[Orders]
	   SET [PaymentStatusId] = @PaymentStatusId
		  ,[TrackingCode] = @TrackingCode
		  ,[TrackingUrl] = @TrackingUrl
		  ,[Total] = @Total
		  ,[ShippingAddressId] = @ShippingAddressId
		  ,[ChargeId] = @ChargeId
		  ,[ModifiedBy] = @UserId
		  ,[DateModified] = @DateNow
		  ,[BillingAddressId] = @BillingAddressId
		  ,[PaymentMethod] = @PaymentMethod
		  ,[PhoneNumber] = @PhoneNumber
		  ,[SessionId] = @SessionId

	 WHERE Id = @Id

END
