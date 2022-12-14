USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[VenueRequests_Update]    Script Date: 8/14/2022 2:19:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Allen La Rosa>
-- Create date: <5/19/2022>
-- Description: <Update Venue Request>
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[VenueRequests_Update]
			@VenueId int 
		   ,@EventDescription nvarchar(4000)
		   ,@StartDate datetime2(7) 
		   ,@EndDate datetime2(7)
		   ,@Requester int 
		   ,@Id int
as

/*
------Test Code-------
    Declare @VenueId int = 104
		   ,@EventDescription nvarchar(4000) = 'Abu Dhabi Dhow Cruise'
		   ,@StartDate datetime2(7) = getutcdate()
		   ,@EndDate datetime2(7) = getutcdate()
		   ,@Requester int = 266
		   ,@Id int = 77

     Select  vr.Id
	        ,vr.VenueId 
		    ,vr.EventDescription
			,vr.StartDate
			,vr.EndDate
			,vr.Requester
	From dbo.VenueRequests as vr inner join dbo.Users as u
			on vr.Requester = u.Id
	Where VenueId = @VenueId

	Execute dbo.VenueRequests_Update @VenueId 
									,@EventDescription 
									,@StartDate  
									,@EndDate 
									,@Requester  
									,@Id


	Select*
	From dbo.VenueRequests as vr inner join dbo.Users as u
			on vr.Requester = u.Id
	Where VenueId = @VenueId
	------End Test Code-------
*/

BEGIN

	UPDATE [dbo].[VenueRequests]

	   SET 
	       [EventDescription] = @EventDescription
		  ,[StartDate]		  = @StartDate
		  ,[EndDate]          = @EndDate
		  ,[Requester]        = @Requester
		  ,[VenueId]	      = @VenueId
		  ,[DateModified]	  = GETUTCDATE()

	 WHERE Id = @Id

END


