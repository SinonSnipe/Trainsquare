USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Insert_V2]    Script Date: 8/14/2022 2:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Archuleta, Lia
-- Create date: 04/18/2022
-- Description:	Proc to insert userProfiles from adminDashboard
-- Code Reviewer:


-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_Insert_V2]
				@AvatarUrl nvarchar (255)
				,@FirstName nvarchar(100)
				,@LastName nvarchar(100)
				,@Email nvarchar(100)
				,@RoleId int
				,@StatusId int
				,@Id int OUTPUT

AS
/* ------ Test Code --------------


	DECLARE @Id int = 0

	DECLARE @AvatarUrl varchar(255) = 'https://tinyurl.com/4cddp92r'
			,@FirstName nvarchar(100) = 'Donald'			   
			,@LastName nvarchar(100) = 'Duck'
			,@Email nvarchar(100) = 'dd@gmail.com'
			,@RoleId int = 1
			,@StatusId int = 1


	EXECUTE [dbo].[UserProfiles_Insert]
			@AvatarUrl
			,@FirstName
			,@LastName
			,@Email
			,@Role Id
			,@StatusId
			,@Id OUTPUT
	
	


*/
BEGIN

	DECLARE @ProfileId int = 0 
	/*
	EXECUTE [dbo].[Users_Insert]
				    @Email
				   ,@Password
				   ,@UserStatusId
				   ,@Id OUTPUT

	EXECUTE [dbo].[UsersProfiles_Insert]
					@Id
				   ,@FirstName
				   ,@LastName
				   ,@ProfileId 
*/
END