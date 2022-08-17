ALTER proc [dbo].[Attendance_ByWorkShopId]

	@PageIndex int
	,@PageSize int
	,@SessionId int

as

/*
Declare @pageIndex int = 0
		,@pageSize int = 5
		,@SessionId int = 204

Execute dbo.Attendance_ByWorkShopId
		@pageIndex 
		,@pageSize 
		,@SessionId




*/
BEGIN

DECLARE @offset int = @pageIndex * @pageSize

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
	,TotalCount = COUNT(1) OVER()


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

WHERE a.SessionId = @SessionId

ORDER BY a.Id
OFFSET @offSet Rows
Fetch Next @PageSize Rows ONLY

END
