USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteHosts_SelectAllWorkShopIds]    Script Date: 8/9/2022 4:14:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jered Casuga
-- Create date: 6/5/22
-- Description: Selects favorite workshops by HostId
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

ALTER Proc [dbo].[FavoriteHosts_SelectAllWorkShopIds]

/* ------------- TEST CODE ---------------------

	Execute dbo.FavoriteHosts_SelectAllWorkShopIds

------------- TEST CODE --------------------- */

as

BEGIN

	SELECT Id
	  FROM [dbo].[WorkShop]

END