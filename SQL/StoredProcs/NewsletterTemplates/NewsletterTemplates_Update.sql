USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplates_Update]    Script Date: 8/14/2022 11:49:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/01/2022>
-- Description:	<NewsletterTemplates Update>
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================






ALTER proc [dbo].[NewsletterTemplates_Update]
							@Id int
							,@Name nvarchar(100)
							,@Description  nvarchar(200)
							,@PrimaryImage  nvarchar(255)
							,@CreatedBy int

AS

/*
Declare						 @Id int = 3
							,@Name nvarchar(100) = 'Newspaper Template'
							,@Description  nvarchar(200) = 'Newspaper Template 3003'
							,@PrimaryImage  nvarchar(255) = 'need screenshot of template here'
							,@CreatedBy int = 300

EXECUTE dbo.NewsletterTemplates_Update

							 @Id 
							,@Name 
							,@Description 
							,@PrimaryImage 
							,@CreatedBy



EXECUTE [dbo].[NewsletterTemplates_Select_ById] @Id




*/

BEGIN

DECLARE @DateNow datetime2(7) = getutcdate();

UPDATE [dbo].[NewsletterTemplates]


   SET [Name] = @Name
      ,[Description] = @Description
      ,[PrimaryImage] = @PrimaryImage
      ,[DateModified] = @DateNow
      ,[CreatedBy] = @CreatedBy


 WHERE Id = @Id


END

 
