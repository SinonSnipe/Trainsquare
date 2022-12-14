USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteWorkshops_SelectWorkShopIds_ByUserId]    Script Date: 8/9/2022 4:18:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jered Casuga
-- Create date: 5/20/22
-- Description: Selects favorite workshops by UserId
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

ALTER Proc [dbo].[FavoriteWorkshops_SelectWorkShopIds_ByUserId]
			@UserId int

/* ------------- TEST CODE ---------------------

	Declare @UserId int = 260

	Execute dbo.FavoriteWorkshops_SelectWorkShopIds_ByUserId
				@UserId

*/

as

BEGIN

	Select WorkShopId
	From dbo.FavoriteWorkshops
	Where UserId = @UserId

END