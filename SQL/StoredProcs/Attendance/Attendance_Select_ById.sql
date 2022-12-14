ALTER proc [dbo].[Attendance_Select_ById]

@Id int

as

/*

Declare @Id Int = 5;
Execute dbo.Attendance_Select_ById @Id




*/
BEGIN

SELECT 
		a.[Id]
	,a.[SessionId]
	,s.[WorkShopId]
	,ws.[Name]
	,a.[UserId]
	,ur.[RoleId]
	,r.[Name] as [RoleName]
	,up.[FirstName]
	,up.[LastName]
	,[isPresent]
	,up.[AvatarUrl]

FROM [dbo].[Attendance]
		AS a INNER JOIN dbo.Sessions AS s
		ON a.SessionId = s.Id
		INNER JOIN dbo.UserProfiles AS up
		ON a.UserId = up.UserId
		INNER JOIN dbo.UserRoles as ur
		ON a.UserId = ur.UserId
		INNER JOIN dbo.Roles as r
		ON ur.RoleId = r.Id
		INNER JOIN dbo.WorkShop as ws
		ON s.WorkShopId = ws.Id

WHERE
	@Id = a.Id

ORDER BY a.Id


END
