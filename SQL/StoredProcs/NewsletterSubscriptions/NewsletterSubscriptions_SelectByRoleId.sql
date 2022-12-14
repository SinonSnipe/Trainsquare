USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterSubscriptions_SelectByRoleId]    Script Date: 8/14/2022 11:46:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
--AUTHOR: FRANK VILARDI
--CREATE DATE: 04/16/2022
--DESCRIPTION: This is a simple email and subscription database table 
--where we can simply describe whether an email has a subscription or not.

--CODE REVIEWER: Tawni Magie
--MODIFIED BY:
--MODIFIED DATE:
--CODE REVIEWER:
--NOTE:
-- =============================================

ALTER PROC [dbo].[NewsletterSubscriptions_SelectByRoleId]
			@RoleId int

AS

/*

DECLARE @RoleId int = 1

SELECT u.Id 
	,ur.RoleId 
	,u.Email

	FROM dbo.Users as u inner join dbo.UserRoles as ur 
	ON u.Id = ur.UserId
	WHERE ur.RoleId = @RoleId

*/

BEGIN

 
  
SELECT u.Id 
	,ur.RoleId 
	,u.Email

	FROM dbo.Users as u inner join dbo.UserRoles as ur 
	ON u.Id = ur.UserId
	WHERE ur.RoleId = @RoleId
END