USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterContent_Update]    Script Date: 8/14/2022 11:43:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/18/2022>
-- Description:	<NewsletterContent Update>
-- Code Reviewer: Lia Archuleta


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================
ALTER proc [dbo].[NewsletterContent_Update]
						@Id int 
						,@TemplateKeyId int 
						,@NewsletterId int
						,@Value nvarchar(max)
						,@CreatedBy int

AS

/*

DECLARE			@Id int = 5
				,@TemplateKeyId int = 1
				,@NewsletterId int = 6
				,@Value nvarchar(max) = 'Insert Content Value Here'
				,@CreatedBy int = 10

EXECUTE dbo.NewsletterContent_Update
		
				@Id  
				,@TemplateKeyId 
				,@NewsletterId 
				,@Value 
				,@CreatedBy 

EXECUTE [dbo].[NewsletterContent_Select_ById] @Id



*/
BEGIN

DECLARE @DateNow datetime2(7) = getutcdate();

UPDATE dbo.NewsletterContent

   SET [TemplateKeyId] = @TemplateKeyId
      ,[NewsletterId] = @NewsletterId
      ,[Value] = @Value
      ,[DateModified] = @DateNow
      ,[CreatedBy] = @CreatedBy

 WHERE Id = @Id

END


