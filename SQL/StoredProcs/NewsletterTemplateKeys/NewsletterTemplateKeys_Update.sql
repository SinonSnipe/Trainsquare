USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplateKeys_Update]    Script Date: 8/14/2022 11:48:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/15/2022>
-- Description:	<NewsletterTemplateKeys Update>
-- Code Reviewer: Lia Archuleta


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER proc [dbo].[NewsletterTemplateKeys_Update]

								@Id int
								,@KeyTypeId int
								,@TemplateId int
								,@KeyName nvarchar(50)

AS

/*

Declare							@Id int = 1
								,@KeyTypeId int = 1
								,@TemplateId int = 3
								,@KeyName nvarchar(50) = 'Update works'

EXECUTE dbo.NewsletterTemplateKeys_Update
								@Id 
								,@KeyTypeId 
								,@TemplateId 
								,@KeyName 


SELECT							Id 
								,KeyTypeId 
								,TemplateId 
								,KeyName 	
								from dbo.NewsletterTemplateKeys

*/
BEGIN

DECLARE @DateNow datetime2(7) = getutcdate();

UPDATE [dbo].[NewsletterTemplateKeys]


   SET [KeyTypeId] = @KeyTypeId
      ,[TemplateId] = @TemplateId
      ,[KeyName] = @KeyName
      


 WHERE Id = @Id

 
 END