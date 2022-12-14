USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRegistration_SelectAllWorkshopsByUserId]    Script Date: 8/15/2022 11:55:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:			Jonathon Nolden
-- Create date:		5/19/22
-- Description:		Select All Workshops By UserId For Registration Button
-- Code Reviewer:


-- MODIFIED BY:		Jonathon Nolden
-- MODIFIED DATE:	5/24/22
-- Code Reviewer: 
-- Note:			Added StatusId to the proc 
-- =============================================

ALTER PROC [dbo].[WorkshopRegistration_SelectAllWorkshopsByUserId]

			@UserId int

AS

/* --------- Test Code ------------

		DECLARE @userId int = 261

		EXECUTE	[dbo].[WorkshopRegistration_SelectAllWorkshopsByUserId]
				@UserId

*/

BEGIN

	SELECT	ws.[Id] AS WorkshopId
			, wrs.[RegistrationStatus]

	FROM	[dbo].[WorkshopRegistration] AS wr 
			INNER JOIN [dbo].[WorkshopRegistrationStatus] AS wrs ON wr.StatusId = wrs.StatusId
			INNER JOIN [dbo].[WorkShop] AS ws ON wr.WorkshopId = ws.Id

	WHERE	UserId = @UserId

END