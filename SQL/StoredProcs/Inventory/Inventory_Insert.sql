USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_Insert]    Script Date: 8/9/2022 4:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sagan Jackson
-- Create date: 4/1/22
-- Description:	Insert new Inventory
-- Code Reviewer: Guillermo Arreguin


-- MODIFIED BY: author
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER PROC [dbo].[Inventory_Insert]
			@Id int OUTPUT
			,@WorkShopId int
			,@Quantity int
			,@BasePrice money
			,@User int
			
			
			

/*

	Declare @Id int
			,@WorkShopId int = 10
			,@Quantity int = 5
			,@BasePrice money = 9.99
			,@CreatedBy int = 9
			
			
			

	Execute [dbo].[Inventory_Insert] @Id OUTPUT
									,@WorkShopId
									,@Quantity
									,@BasePrice
									,@CreatedBy
									
									
	SELECT Id
			,WorkShopId
			,Quantity
			,BasePrice
			,DateCreated
			,DateModified
			,CreatedBy
			,ModifiedBy
	FROM dbo.Inventory
	Where Id = @Id

	

*/
as

BEGIN

	INSERT INTO  [dbo].[Inventory] 
				([WorkShopId]
				,[Quantity]
				,[BasePrice]
				,CreatedBy
				,ModifiedBy
				
				)
				
		VALUES
				(@WorkShopId
				,@Quantity
				,@BasePrice
				,@User
				,@User
				
				
				)

		SET		@Id = SCOPE_IDENTITY()

END