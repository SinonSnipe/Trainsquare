USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Update]    Script Date: 8/14/2022 2:01:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Archuleta, Lia
-- Create date: 04/19/2022
-- Description:	Update proc for userProfiles from adminDashboard
-- Code Reviewer:


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_Update]
				   @FirstName nvarchar(100)
				  ,@LastName nvarchar(100)
				  ,@Mi nvarchar(2)
				  ,@AvatarUrl varchar(255)
				  ,@UserId int

AS
/*

	DECLARE @UserId int = 1

	DECLARE @FirstName nvarchar(100) = 'Micheal'
			,@LastName nvarchar(100) = 'Amezcua'
			,@mi nvarchar(2) = 'I'
			,@AvatarUrl varchar(255) = 'https://www.w3schools.com/howto/img_avatar.png'

	EXECUTE [dbo].[UserProfiles_Update]
				   @FirstName
				  ,@LastName
				  ,@Mi
				  ,@AvatarUrl
				  ,@UserId
	SELECT [Id]
		  ,[UserId]
		  ,[FirstName]
		  ,[LastName]
		  ,[Mi]
		  ,[AvatarUrl]
	  FROM [dbo].[UserProfiles]
	  WHERE @UserId = UserId
					

*/
BEGIN 

	DECLARE @DateModified datetime2(7) = getutcdate()

	UPDATE [dbo].[UserProfiles]
	   SET [FirstName] = @FirstName
		  ,[LastName] = @LastName 
		  ,[Mi] = @Mi
		  ,[AvatarUrl] = @AvatarUrl
		  ,[DateModified] = @DateModified
	 WHERE @UserId = UserId




END