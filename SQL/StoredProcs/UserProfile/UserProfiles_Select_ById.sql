USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Select_ById]    Script Date: 8/14/2022 2:00:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Amezcua, Abel
-- Create date: 03/25/2022
-- Description:	Select by Id for UserProfiles
-- Code Reviewer: Changwoo


-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_Select_ById]
					@Id int 

AS
/*
	DECLARE @Id int = 18

	EXECUTE [dbo].[UserProfiles_Select_ById]
					@Id

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
	  WHERE @Id = Id

END