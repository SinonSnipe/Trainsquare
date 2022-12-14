USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRequests_SelectBy_UserId]    Script Date: 8/15/2022 12:07:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[WorkshopRequests_SelectBy_UserId]
			@UserId int

AS 

/* --- TEST CODE ---

	DECLARE @UserId int = 10
	EXECUTE dbo.WorkshopRequests_SelectBy_UserId @UserId  

*/

  BEGIN

  SELECT Id
      ,UserId
      ,HostId
      ,Topic
      ,BriefDescription
      ,DateCreated
      ,DateModified
  FROM [dbo].[WorkshopRequests]
  WHERE UserId = @UserId

  END




