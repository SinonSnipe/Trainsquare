USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_UpdateStatus]    Script Date: 8/14/2022 2:12:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description:	Update proc to update a users status.
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 



ALTER PROC [dbo].[Users_UpdateStatus]
			   @UserStatusId int
			   ,@Id int 
AS
/*

	DECLARE @Id int = 1
	
	DECLARE @UserStatusId int = 4

	EXECUTE [dbo].[Users_UpdateStatus]
			@UserStatusId
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
	   SET [UserStatusId] = @UserStatusId
		  ,[DateModified] = @DateMod
	 WHERE @Id = Id




END


