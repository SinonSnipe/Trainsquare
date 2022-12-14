USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Select_ByUserId]    Script Date: 8/14/2022 2:00:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Imocha, Parith
-- Create date: 04/27/2022
-- Description:	Select by User Id for UserProfiles
-- Code Reviewer: Changwoo Lee


-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_Select_ByUserId]
					@UserId int 

AS
/*
	DECLARE @UserId int = 262

	EXECUTE [dbo].[UserProfiles_Select_ByUserId]
					@UserId
*/
BEGIN 

	SELECT [Id]
		  ,[UserId]
		  ,[FirstName]
		  ,[LastName]
		  ,[Mi]
		  ,[AvatarUrl]
		  ,[DateCreated]
		  ,[DateModified]
	  FROM [dbo].[UserProfiles]
	  WHERE @UserId = UserId

END