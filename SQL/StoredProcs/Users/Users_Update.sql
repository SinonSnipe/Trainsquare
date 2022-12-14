USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 8/14/2022 2:12:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description: Update proc for users to update email, password and UserStatus.
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 



ALTER PROC [dbo].[Users_Update]
				@Email nvarchar(100)
			   ,@Password varchar(100)
			   ,@UserStatusId int
			   ,@Id int 
AS
/*

	DECLARE @Id int = 1
	
	DECLARE @Email nvarchar(100) = 'Email@hotmail.com'
			,@Password varchar(100) = 'SuperPAssward11'
			,@UserStatusId int = 1

	EXECUTE [dbo].[Users_Update]
			@Email
			,@Password
			,@UserStatusId
			,@Id

	SELECT u.Id
		  ,[Email]
		  ,[Password]
		  ,[IsConfirmed]
		  ,s.Name AS UserStatus
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[Users] AS u INNER JOIN dbo.UserStatus AS s
			ON u.UserStatusId = s.Id
	WHERE @Id = u.Id 



			
 

*/
BEGIN 


	DECLARE @DateMod  datetime2(7) = GETUTCDATE()

	UPDATE [dbo].[Users]
	   SET [Email] = @Email
		  ,[Password] = @Password
		  ,[UserStatusId] = @UserStatusId
		  ,[DateModified] = @DateMod
	 WHERE @Id = Id




END


