ALTER proc [dbo].[Attendance_Update]


@Id int OUTPUT
,@SessionId int
,@UserId int
,@isPresent bit

as

/*
SELECT * 

FROM 
	dbo.Attendance

Declare @Id int = 4;

Declare @SessionId int = 194
		,@UserId int = 4
		,@isPresent bit = 0

Execute dbo.Attendance_Update 
						@Id OUTPUT
						,@SessionId
						,@UserId
						,@isPresent



SELECT * 

FROM 
	dbo.Attendance



*/
BEGIN

UPDATE 
[dbo].[Attendance]

SET
	[SessionId] = @SessionId
	,[UserId] = @UserId
	,[isPresent] = @isPresent

WHERE
	Id = @Id

END




