USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteWorkshops_Insert]    Script Date: 8/9/2022 4:18:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Jered Casuga
-- Create date: 5/20/22
-- Description: Insert into FavoriteWorkshops
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

ALTER Proc [dbo].[FavoriteWorkshops_Insert]
			@UserId int,
			@WorkShopId int,
			@Id int OUTPUT

/* -------------   TEST CODE       -------------
	
	Declare @UserId int = 1,
			@WorkShopId int = 8,
			@Id int

	Execute dbo.FavoriteWorkshops_Insert
			@UserId,
			@WorkShopId,
			@UserId OUTPUT

	Select *
	From dbo.FavoriteWorkshops

*/

as

BEGIN

	INSERT INTO dbo.FavoriteWorkshops
				(
					[UserId],
					[WorkShopId]
				)
		VALUES
				(
					@UserId,
					@WorkShopId
				)

	SET @Id = SCOPE_IDENTITY();

END