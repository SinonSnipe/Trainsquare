USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectId_ByEmail]    Script Date: 8/14/2022 2:12:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Abel Amezcua
-- Create date: <04/08/2022>
-- Description: Proc first checks if the email exists. This is the first step in the password recovery process. If the email exists then it will return that users Id.
-- Code Reviewer: 

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[Users_SelectId_ByEmail]
			@Email nvarchar(100)
AS
/*

	DECLARE @Email nvarchar(100) = 'abelamezcua68@gmail.com'

	EXECUTE [dbo].[Users_SelectId_ByEmail]
			@Email

*/
BEGIN 

If EXISTS (SELECT 1
			FROM dbo.Users
			WHERE @Email = Email)

	BEGIN

				SELECT [Id]

				FROM [dbo].[Users]
				WHERE @Email = Email 

	 END

	 	ELSE 
				Throw 51000, 'User account with this email not found.', 1

END