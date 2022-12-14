USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterSubscriptions_SelectAll_Subscribed]    Script Date: 8/14/2022 11:46:01 AM ******/
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

ALTER PROC [dbo].[NewsletterSubscriptions_SelectAll_Subscribed]
			@PageIndex int
			,@PageSize int

AS

/*

	DECLARE @PageIndex int = 0
			,@PageSize int = 30

	EXECUTE [dbo].[NewsletterSubscriptions_SelectAll_Subscribed] @PageIndex 
																,@PageSize 


*/

BEGIN  

	DECLARE @Offset int = @PageIndex * @PageSize

	SELECT [Email]
			,[IsSubscribed]
			,[DateCreated]
			,[DateModified]
			,TotalCount = COUNT(1) OVER()

	FROM dbo.NewsletterSubscriptions
	WHERE IsSubscribed = 1

	ORDER BY Email 

	OFFSET @Offset Rows
	FETCH NEXT @PageSize Rows ONLY

END