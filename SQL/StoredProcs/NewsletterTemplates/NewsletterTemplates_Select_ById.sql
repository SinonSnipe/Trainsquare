USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplates_Select_ById]    Script Date: 8/14/2022 11:49:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/01/2022>
-- Description:	<NewsletterTemplates Select By Id>
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[NewsletterTemplates_Select_ById]
			@Id int

AS

/*
DECLARE @Id int = 3 
EXECUTE [dbo].[NewsletterTemplates_Select_ById] @Id

*/

BEGIN

SELECT [Id]
      ,[Name]
      ,[Description]
      ,[PrimaryImage]
      ,[DateCreated]
      ,[DateModified]
      ,[CreatedBy]


  FROM [dbo].[NewsletterTemplates]
  WHERE Id = @Id

END


