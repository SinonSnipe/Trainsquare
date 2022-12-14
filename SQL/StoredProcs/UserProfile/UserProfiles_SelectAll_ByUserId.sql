USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAll_ByUserId]    Script Date: 8/14/2022 2:01:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Jered Casuga
-- Create date: 05/25/2022
-- Description:	Select All Users by User Id for UserProfiles
-- Code Reviewer: 


-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_SelectAll_ByUserId]
					
AS
/*

	EXECUTE [dbo].[UserProfiles_SelectAll_ByUserId]
					
*/
BEGIN 

	SELECT [UserId]
		  ,[FirstName]
		  ,[LastName]
		  ,[Mi]
		  ,[AvatarUrl]
		  ,[DateCreated]
		  ,[DateModified]
	FROM [dbo].[UserProfiles]

END