USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_Delete_ById]    Script Date: 8/14/2022 2:00:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Amezcua, Abel
-- Create date: 03/25/2022
-- Description:	Delete a UserProfile record
-- Code Reviewer: Changwoo


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[UserProfiles_Delete_ById]
					@Id int

AS
/*
	DECLARE @Id int = 0

	EXECUTE [dbo].[UserProfiles_Delete_ById]
					@Id

*/
BEGIN 


	DELETE FROM [dbo].[UserProfiles]
		  WHERE @Id = Id


END