USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Attendance_SelectBy_SessionId]    Script Date: 8/9/2022 2:23:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   Proc [dbo].[Attendance_SelectBy_SessionId]
			@SessionId int

As
/*


Declare @SessionId int = 225
Execute dbo.Attendance_SelectBy_SessionId @SessionId


*/
Begin

Select  A.Id,
		u.UserId,
		U.FirstName,
		U.LastName, 
		U.AvatarUrl


From dbo.Attendance as A Inner Join 
	 dbo.Sessions as S 
	 On A.SessionId = S.Id Inner Join
	 dbo.UserProfiles as U 
	 On A.UserId = U.UserId

Where @SessionId = A.SessionId

Order By u.FirstName

End