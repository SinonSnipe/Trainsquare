USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[VenueRequests_SelectByRequester]    Script Date: 8/14/2022 2:19:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Allen La Rosa>
-- Create date: <5/19/2022>
-- Description: <Select VenueRequest by Requester>
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[VenueRequests_SelectByRequester]
											@Requester int

as

/*



	Declare @Requester int = 2

	Execute dbo.VenueRequests_SelectByRequester
											@Requester

*/

BEGIN

	SELECT [Id]
	      ,[VenueId]
		  ,[EventDescription]
		  ,[StartDate]
		  ,[EndDate]
		  ,[Requester]

	  FROM dbo.VenueRequests 

	  WHERE Requester = @Requester

END


