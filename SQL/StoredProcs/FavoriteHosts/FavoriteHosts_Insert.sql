USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FavoriteHosts_Insert]    Script Date: 8/9/2022 4:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Jered Casuga	
-- Create date: 6/5/22
-- Description: Insert into FavoriteHosts
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================

ALTER Proc [dbo].[FavoriteHosts_Insert]
			
			@HostId int,
			@WorkShopId int,
			@Id int OUTPUT

/* -------------   TEST CODE       -------------
	
	Declare @Id int = 1,
			@WorkShopId int = 8,
			@Id int

	Execute dbo.FavoriteHosts_Insert
			@HostId,
			@WorkShopId,
			@HostId OUTPUT

	Select *
	From dbo.FavoriteHosts

*/

as

BEGIN

	INSERT INTO dbo.FavoriteHosts
				(
					[HostId],
					[WorkShopId]
				)
		VALUES
				(
					@HostId,
					@WorkShopId
				)

	SET @Id = SCOPE_IDENTITY();

END