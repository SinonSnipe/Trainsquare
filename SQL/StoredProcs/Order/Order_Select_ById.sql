USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Order_Select_ById]    Script Date: 8/14/2022 11:52:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/27/2022
-- Description: Select Order By Id
-- Code Reviewer: Bianchi Mena

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[Order_Select_ById] 
								   @Id INT

AS

/* ----- Test Code -----

	DECLARE		@Id INT = 18

	SELECT * FROM dbo.Orders

	EXECUTE dbo.Order_Select_ById
				@Id

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

	WHERE Id = @Id

END
