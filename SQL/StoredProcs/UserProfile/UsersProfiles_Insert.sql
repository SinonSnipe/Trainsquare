USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UsersProfiles_Insert]    Script Date: 8/14/2022 2:10:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Amezcua, Abel
-- Create date: 03/25/2022
-- Description:	Insert for user profiles
-- Code Reviewer: 
-- Note: Only execute this proc from Users_InsertV2 to avoid entering bad data. 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UsersProfiles_Insert]
				@UserId int
			   ,@FirstName nvarchar(100)
			   ,@LastName nvarchar(100)
			   ,@Id int OUTPUT

AS
/*

	DECLARE @Id int = 0 

	DECLARE @UserId int = 6
			,@FirstName nvarchar(100) = 'Myra'
			,@LastName nvarchar(100) = 'Cabrera'
			,@Mi nvarchar(2) = 'V'
			,@AvatarUrl varchar(255) = 'https://www.w3schools.com/howto/img_avatar.png'

	EXECUTE [dbo].[UsersProfiles_Insert]
				@UserId
			   ,@FirstName
			   ,@LastName
			   ,@Mi
			   ,@AvatarUrl
			   ,@Id OUTPUT

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


*/
BEGIN


	INSERT INTO [dbo].[UserProfiles]
			   ([UserId]
			   ,[FirstName]
			   ,[LastName])

		VALUES	(@UserId
				,@FirstName
				,@LastName)

	SET @Id = SCOPE_IDENTITY()

END