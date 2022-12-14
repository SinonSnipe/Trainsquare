USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterSubscriptions_Unsubscribe]    Script Date: 8/14/2022 11:46:09 AM ******/
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

ALTER PROC [dbo].[NewsletterSubscriptions_Unsubscribe]
			@Email nvarchar(255)
			,@IsSubscribed bit = 0

AS

/*

DECLARE @Email nvarchar(255) = 'test1@email.com'
		,@IsSubscribed bit = 0

EXECUTE dbo.NewsletterSubscriptions_Unsubscribe @Email
												,@IsSubscribed
												
SELECT *
FROM dbo.NewsletterSubscriptions
WHERE Email = @Email


*/

BEGIN

UPDATE [dbo].[NewsletterSubscriptions]
		SET [Email] = @Email
		,[IsSubscribed] = @IsSubscribed
		WHERE Email = @Email

END