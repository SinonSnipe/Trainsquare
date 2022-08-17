USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_Delete_ById]    Script Date: 8/14/2022 2:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description:	Delete user by Id proc
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 




ALTER PROC [dbo].[Users_Delete_ById]
				@Id int
AS
/*

	DECLARE @Id int = 3

	SELECT [Id]
		  ,[Email]
		  ,[Password]
	  FROM [dbo].[Users]
	  WHERE @Id = Id

	EXECUTE [dbo].[Users_Delete_ById]
			@Id

	SELECT [Id]
		  ,[Email]
		  ,[Password]
	  FROM [dbo].[Users]
	  WHERE @Id = Id

*/
BEGIN 



DELETE FROM [dbo].[Users]
      WHERE @Id = Id





END

