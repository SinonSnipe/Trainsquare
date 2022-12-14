USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 8/14/2022 2:12:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description:	Insert new user proc. Implementing joins with UserStatus table in the test code.
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 


ALTER PROC [dbo].[Users_Insert]
				@Email nvarchar(100)
			   ,@Password varchar(100)
			   ,@Id int OUTPUT

AS
/*


	DECLARE @Id int = 0

	DECLARE @Email nvarchar(100) = 'TestUser4@gmail.com'
			,@Password varchar(100) = 'Password17%'
			,@UserStatusId int = 1
	
	EXECUTE [dbo].[Users_Insert]
			@Email
			,@Password
			,@UserStatusId
			,@Id OUTPUT

	SELECT u.Id
		  ,[Email]
		  ,[Password]
		  ,[IsConfirmed]
		  ,s.Name as UserStatus
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[Users] AS u INNER JOIN [dbo].[UserStatus] as s
						ON u.UserStatusId = s.Id
	  WHERE @Id = u.Id


*/
BEGIN 

	DECLARE @UserStatusId int = 1

	DECLARE @RoleId int = 1

	INSERT INTO [dbo].[Users]
			   ([Email]
			   ,[Password]
			   ,[UserStatusId])

		 VALUES
			   (@Email
			   ,@Password
			   ,@UserStatusId)

	SET @Id = SCOPE_IDENTITY()

	EXECUTE dbo.UserRoles_insert
				@Id
				,@RoleId
END



