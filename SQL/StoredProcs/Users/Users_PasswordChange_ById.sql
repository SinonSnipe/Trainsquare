USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_PasswordChange_ById]    Script Date: 8/14/2022 2:12:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- CREATED BY:
-- CREATED DATE:
-- Code Reviewer: 
-- Note: :)


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 


ALTER PROC [dbo].[Users_PasswordChange_ById]

			@Id int

AS

/*

	DECLARE @Id int = 305

	EXECUTE [dbo].[Users_PasswordChange_ById]
			@Id

*/

BEGIN 

	SELECT	[Password]
		  
	FROM	[dbo].[Users]
	WHERE	@Id = Id 

END


