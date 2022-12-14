USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplates_Insert]    Script Date: 8/14/2022 11:48:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/01/2022>
-- Description:	<NewsletterTemplates Insert>
-- Code Reviewer: 


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[NewsletterTemplates_Insert]
				@Id int OUTPUT
				,@Name nvarchar(100)
				,@Description nvarchar(200)
				,@PrimaryImage nvarchar(255)
				,@CreatedBy int


AS
/* 

DECLARE			@Id int = 0
				,@Name nvarchar(100) = 'Newsletter Template'
				,@Description nvarchar(200) = 'Newsletter Template 8'
				,@PrimaryImage nvarchar(255) = 'test'
				,@CreatedBy int = 9

EXECUTE [dbo].[NewsletterTemplates_Insert] @Id OUTPUT
											,@Name 
											,@Description 
											,@PrimaryImage 
											,@CreatedBy 

EXECUTE [dbo].[NewsletterTemplates_Select_ById] @Id



*/

BEGIN

INSERT INTO [dbo].[NewsletterTemplates]
           ([Name]
           ,[Description]
           ,[PrimaryImage]
           ,[CreatedBy])
     VALUES
           (@Name 
           ,@Description
           ,@PrimaryImage 
           ,@CreatedBy) 
	
	SET		@Id = SCOPE_IDENTITY()

END



