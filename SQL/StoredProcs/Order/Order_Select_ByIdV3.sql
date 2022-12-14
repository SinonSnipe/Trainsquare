USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Order_Select_ByIdV3]    Script Date: 8/14/2022 11:52:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Rafael Lynch
-- Create date: 6/02/2022
-- Description: Select Order By Id with details
-- Code Reviewer: 

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[Order_Select_ByIdV3] 
								   @Id INT

AS

/* ----- Test Code -----

	DECLARE						   @Id INT = 68

	SELECT * FROM dbo.Orders

	EXECUTE dbo.Order_Select_ByIdV3
									@Id

----- End Test Code -----
*/

BEGIN

	SELECT o.[Id]
		  ,ps.Id AS PaymentStatusId
		  ,ps.Name AS PaymentStatus
		  ,[TrackingCode]
		  ,[TrackingUrl]
		  ,[Total]
		  ,[ChargeId]
		  ,o.[CreatedBy]
		  ,o.[ModifiedBy]
		  ,shippingAddress.AddressLine1 AS ShippingAddressLine1
		  ,shippingAddress.AddressLine2 AS ShippingAddressLine2
		  ,shippingAddress.City AS ShippingAddressCity
		  ,shippingAddress.Country AS ShippingAddressCountry
		  ,shippingAddress.PostalCode AS ShippingAddressPostalCode
		  ,shippingAddress.State AS ShippingAddressState
		  ,o.DateCreated
		  ,o.DateModified
		  ,billingAddress.AddressLine1 AS BillingAddressLine1
		  ,billingAddress.AddressLine2 AS BillingAddressLine2
		  ,billingAddress.City AS BillingAddressCity
		  ,billingAddress.Country AS BillingAddressCountry
		  ,billingAddress.PostalCode AS BillingAddressPostalCode
		  ,billingAddress.State AS BillingAddressState
		  ,PaymentMethod
		  ,PhoneNumber
		  ,SessionId
		  ,up.FirstName
		  ,up.LastName
		  ,OrderItems = (
		  					SELECT oi.Id
								   ,oi.InventoryId
								   ,oi.Quantity
								   ,oi.OrderId
								   ,oi.CreatedBy
								   ,oi.ModifiedBy
								   ,w.[Name]
								   ,w.ImageUrl
								   ,w.Summary
								   ,i.BasePrice

							FROM dbo.OrderItems AS oi INNER JOIN dbo.Inventory AS i
								ON oi.InventoryId = i.Id INNER JOIN dbo.WorkShop AS w
								ON i.WorkShopId = w.Id LEFT JOIN dbo.PaymentAccounts AS pa
								ON w.HostId = pa.VendorId

							WHERE OrderId = @Id

							FOR JSON PATH
		  
						)

	  FROM [dbo].[Orders] AS o INNER JOIN dbo.PaymentStatus AS ps
		ON o.PaymentStatusId = ps.Id LEFT JOIN dbo.Addresses AS shippingAddress
		ON o.ShippingAddressId = shippingAddress.Id LEFT JOIN dbo.Addresses AS billingAddress 
		ON o.BillingAddressId = billingAddress.Id INNER JOIN dbo.UserProfiles AS up
		ON o.CreatedBy = up.UserId

	WHERE o.Id = @Id

END
