USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectPass_ByEmail]    Script Date: 8/14/2022 2:12:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description:	A select proc to select a Password by email. Used for password recovery via email
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 




ALTER PROC [dbo].[Users_SelectPass_ByEmail]
			@Email nvarchar(100) 
AS
/*

	DECLARE @Email nvarchar(100) = 'Testuser2@gmail.com'

	EXECUTE [dbo].[Users_SelectPass_ByEmail]
			@Email

*/
BEGIN 


	SELECT [Password]
	  FROM [dbo].[Users]
	  WHERE @Email = [Email]




END


