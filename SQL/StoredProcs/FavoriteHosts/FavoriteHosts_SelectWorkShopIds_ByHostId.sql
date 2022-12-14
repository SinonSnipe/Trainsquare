USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteHosts_SelectWorkShopIds_ByHostId]    Script Date: 8/9/2022 4:14:18 PM ******/
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

ALTER Proc [dbo].[FavoriteHosts_SelectWorkShopIds_ByHostId]
			
			@HostId int

/* ------------- TEST CODE ---------------------

	Declare @HostId int = 260

	Execute dbo.FavoriteHosts_SelectWorkShopIds_ByHostId
				@HostId

------------- TEST CODE --------------------- */

as

BEGIN

	Select Id
	From dbo.Workshop
	Where HostId = @HostId

END