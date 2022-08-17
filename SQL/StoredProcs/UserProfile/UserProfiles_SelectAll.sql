USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAll]    Script Date: 8/14/2022 2:00:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Amezcua, Abel
-- Create date: 03/25/2022
-- Description:	Select all for userProfiles
-- Code Reviewer: Changwoo


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_SelectAll]


AS
/*

	EXECUTE [dbo].[UserProfiles_SelectAll]


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


END