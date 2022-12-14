USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRequest_SelectBy_HostId]    Script Date: 8/15/2022 12:05:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   Proc [dbo].[WorkshopRequest_SelectBy_HostId]
		@HostId int

As
/*
Declare @HostId int = 266

Execute DBO.WorkshopRequest_SelectBy_HostId @HostId
*/
Begin
SELECT wr.Id
      ,wr.UserId
      ,wr.HostId
      ,wr.Topic
      ,wr.BriefDescription
      ,wr.DateCreated
      ,wr.DateModified
	  ,up.AvatarUrl
	  ,up.FirstName
	  ,up.LastName
  FROM [dbo].[WorkshopRequests] as wr inner join users as u
										on wr.UserId = u.Id
									  inner join UserProfiles as up
										on u.Id = up.UserId
  Where wr.HostId = @HostId
End


