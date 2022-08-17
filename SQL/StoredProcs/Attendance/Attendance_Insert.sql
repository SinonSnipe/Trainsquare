ALTER proc [dbo].[Attendance_Insert]


@Id int OUTPUT
,@SessionId int
,@UserId int

as

/*
Declare @Id int = 0;

Declare @Session int = 142
		,@UserId int = 8

Execute dbo.Attendance_Insert 
						@Id OUTPUT
						,@SessionId
						,@UserId

SELECT
	*
FROM 
	dbo.Attendance



*/
BEGIN

INSERT INTO 
[dbo].[Attendance]
	([SessionId]
	,[UserId])

VALUES
	(
	@SessionId
	,@UserId)

SET
	@Id = SCOPE_IDENTITY()

END
	


