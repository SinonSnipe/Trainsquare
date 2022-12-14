USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_Select_ById]    Script Date: 8/14/2022 2:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description:	select by Id proc with joins with UserStatus table.
-- Code Reviewer: Charles Oh


-- MODIFIED BY: Amezcua, Abel
-- MODIFIED DATE: 03/24/2022
-- Code Reviewer: Changwoo
-- Note: Added joins for roles, and userProfiles





ALTER PROC [dbo].[Users_Select_ById]
			@Id int
AS
/*

	DECLARE @Id int = 1

	EXECUTE [dbo].[Users_Select_ById]
			@Id

*/
BEGIN 


	SELECT u.[Id]
		  ,p.FirstName
		  ,p.LastName
		  ,p.Mi
		  ,p.AvatarUrl
		  ,[Email]
		  ,[Password]
		  ,[IsConfirmed]
		  ,s.Name as UserStatus
		  ,u.[DateCreated]
		  ,u.[DateModified]
		  ,Roles = (
					SELECT r.Id as id
							,r.Name as role
					FROM dbo.Roles AS r inner join dbo.UserRoles AS ur
								on r.Id = ur.RoleId
					WHERE u.Id = ur.UserId
					FOR JSON AUTO
		  )
	  FROM [dbo].[Users] AS u Inner join dbo.UserProfiles AS p
	      on u.Id = p.UserId inner join dbo.UserStatus as s
		  on u.UserStatusId = s.Id
	 WHERE @Id = u.Id 




END


