USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_Update]    Script Date: 8/9/2022 4:29:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sagan Jackson
-- Create date: 4/1/22
-- Description:	Update Inventory
-- Code Reviewer: Guillermo Arreguin


-- MODIFIED BY: author
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER PROC [dbo].[Inventory_Update]
			@Id int OUTPUT
			,@WorkShopId int
			,@Quantity int
			,@BasePrice money
			,@User int
			

/*

	 

	DECLARE @Id int = 138
			,@WorkShopId int = 5
			,@Quantity int = 5
			,@BasePrice money = 30.99
			,@User int = 260
			
	
	

	Execute [dbo].[Inventory_Update] @Id
										 ,@WorkShopId
										 ,@Quantity
										 ,@BasePrice
										 ,@User
select *
from dbo.inventory
										 

*/
as

BEGIN

	DECLARE @date datetime2 = getutcdate();

	UPDATE  [dbo].[Inventory]

	SET		[WorkShopId] = @WorkShopId
			,[Quantity] = @Quantity
			,[BasePrice] = @BasePrice
			,[ModifiedBy] = @User
			,[DateCreated] = @date
			,[DateModified] = @date

	WHERE	Id = @Id

END