ALTER proc [dbo].[Attendance_Delete_ById]

@Id int

as

/*

Select *
FROM dbo.Attendance


Declare @Id Int = 1;
Execute dbo.Attendance_Delete_ById @Id

Select *
FROM dbo.Attendance

*/
BEGIN

DELETE
FROM
	[dbo].[Attendance]

WHERE
	Id = @Id
END


