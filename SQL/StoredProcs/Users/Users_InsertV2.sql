USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_InsertV2]    Script Date: 8/14/2022 2:12:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Amezcua, Abel
-- Create date: 03/25/2022
-- Description:	V2 proc to insert users with user profiles
-- Code Reviewer: Changwoo


-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[Users_InsertV2]
				@FirstName nvarchar(100)
			   ,@LastName nvarchar(100)
			   ,@Email nvarchar(100)
			   ,@Password varchar(100)
			   ,@UserStatusId int
			   ,@Id int OUTPUT

AS
/*
	DECLARE @Id int = 0

	DECLARE @FirstName nvarchar(100) = 'Abel'
			   ,@LastName nvarchar(100) = 'Amezcua'
			   ,@Mi nvarchar(2) = 'M'
			   ,@AvatarUrl varchar(255) = null
			   ,@Email nvarchar(100) = 'TestEmail1@gmail.com'
			   ,@Password varchar(100) = 'Password10$'
			   ,@UserStatusId int = 1


	EXECUTE [dbo].[Users_InsertV2]
				@FirstName
			   ,@LastName
			   ,@Mi
			   ,@AvatarUrl
			   ,@Email
			   ,@Password
			   ,@UserStatusId
			   ,@Id OUTPUT
	
	EXECUTE [dbo].[Users_Select_ById]
					@Id

*/
BEGIN

	DECLARE @ProfileId int = 0 

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

END