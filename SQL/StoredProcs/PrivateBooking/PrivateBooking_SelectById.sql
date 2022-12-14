USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[PrivateBooking_SelectById]    Script Date: 8/14/2022 11:55:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Bianchi Mena
-- Create date: 05/17/2022
-- Description: Stored Procedure for SELECT_BY_ID for dbo.PrivateBooking Table 
-- Code Reviewer: Ethan Englert

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[PrivateBooking_SelectById]
			@Id int
AS

/* --- TEST CODE ---

	DECLARE @Id int = 1;
	EXECUTE dbo.PrivateBooking_SelectById @Id

*/

BEGIN

SELECT [Id]
	,[Name]
	,[Email]
	,[NumberOfPeopleAttending]
	,[Description]
	,[NumberOfSessions]
	,[DateCreated]
	,[DateModified]
	,[WorkshopId]
	,[UserId]
	,[WorkshopRequestId]
FROM [dbo].[PrivateBooking]
WHERE @Id = Id

END


