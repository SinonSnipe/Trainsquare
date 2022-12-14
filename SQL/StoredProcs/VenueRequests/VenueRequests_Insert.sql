USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[VenueRequests_Insert]    Script Date: 8/14/2022 2:19:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Allen La Rosa>
-- Create date: <5/19/2022>
-- Description: <Insert Venue Request>
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[VenueRequests_Insert]
			
		    @EventDescription nvarchar(4000)
		   ,@StartDate datetime2(7) 
		   ,@EndDate datetime2(7)
		   ,@Requester int
		   ,@VenueId int 
		   ,@Id int OUTPUT
as


/*
	Declare @VenueId int = 70
	       ,@EventDescription nvarchar(4000) = 'Test Event Description4'
		   ,@StartDate datetime2(7) = getutcdate()
		   ,@EndDate datetime2(7) = getutcdate()
		   ,@Requester int = 6
		   ,@Id int = 0

	Execute dbo.VenueRequests_Insert 
									 @EventDescription
									,@StartDate 
									,@EndDate
									,@Requester 
									,@VenueId 
									,@Id OUTPUT

		Select @VenueId

		Select vr.Id
		      ,vr.VenueId
		      ,vr.EventDescription
			  ,vr.StartDate
			  ,vr.EndDate
			  ,vr.Requester
		From dbo.VenueRequests as vr 
				inner join dbo.Users as u
					on vr.Requester = u.Id
				inner join dbo.Venues as v
					on v.Id = vr.VenueId
		
*/



BEGIN
   
	
	INSERT INTO [dbo].[VenueRequests]
			   ([EventDescription]
			   ,[StartDate]
			   ,[EndDate]
			   ,[Requester]
			   ,[VenueId])
		 VALUES
			   (@EventDescription
			   ,@StartDate
			   ,@EndDate
			   ,@Requester
			   ,@VenueId)	

	Set @Id = SCOPE_IDENTITY()

END 


