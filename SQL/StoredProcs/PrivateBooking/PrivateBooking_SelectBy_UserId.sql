USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[PrivateBooking_SelectBy_UserId]    Script Date: 8/14/2022 11:55:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[PrivateBooking_SelectBy_UserId]
		@UserId int

AS

/* --- TEST CODE ---
	DECLARE @UserId int = 10
	EXECUTE dbo.PrivateBooking_SelectBy_UserId @UserId
*/

BEGIN

SELECT pb.Id
      ,pb.Name
      ,pb.NumberOfPeopleAttending
      ,pb.Description
      ,pb.NumberOfSessions
      ,pb.DateCreated
      ,pb.DateModified
      ,pb.WorkshopId
      ,pb.UserId
      ,wr.Id
	  ,wr.Topic
  FROM [dbo].[PrivateBooking] as pb inner join WorkshopRequests as wr
							  on pb.UserId = wr.UserId
  WHERE pb.UserId = @UserId

 END




