USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRegistration_Update]    Script Date: 8/15/2022 11:55:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:			Jonathon Nolden
-- Create date:		5/16/22
-- Description:		Update for Bridge table disconnecting WorkShops to Users
-- Code Reviewer:


-- MODIFIED BY:		Jonathon Nolden
-- MODIFIED DATE:	5/24/22
-- Code Reviewer: 
-- Note:			Added StatusId. Update now changes StatusId rather than disconnecting the WorkShops to the Users
-- =============================================

ALTER PROC [dbo].[WorkshopRegistration_Update]

			@WorkshopId int
			, @UserId int
			, @StatusId int

AS

/* --------- Test Code ------------

	DECLARE @WorkshopId int = 5
			, @userId int = 261
			, @StatusId int = 3

	SELECT	*
	FROM	[dbo].[WorkshopRegistration]
    WHERE	WorkshopId = @WorkshopId;

	EXECUTE	[dbo].[WorkshopRegistration_Update]
			@WorkshopId
			, @UserId
			, @StatusId
			
	SELECT	*
	FROM	[dbo].[WorkshopRegistration]
    WHERE	WorkshopId = @WorkshopId;

*/

BEGIN

	UPDATE	[dbo].[WorkshopRegistration]
	SET		[StatusId] = @StatusId

	WHERE	WorkshopId = @WorkshopId AND
			UserId = @UserId

END 