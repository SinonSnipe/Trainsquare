USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplateKeys_Select_ByTemplateId]    Script Date: 8/14/2022 11:48:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/18/2022>
-- Description:	<NewsletterTemplateKeys_SelectByTemplateId>
-- Code Reviewer: Stephanie Zavala


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[NewsletterTemplateKeys_Select_ByTemplateId]
			@TemplateId int

AS

/*

DECLARE @TemplateId int = 3 
EXECUTE [dbo].[NewsletterTemplateKeys_Select_ByTemplateId] @TemplateId

*/

BEGIN

SELECT ntk.Id
	  ,ntk.KeyTypeId
	  ,nkt.Name as KeyTypeName
      ,nt.Id as TemplateId
      ,ntk.KeyName
	  ,TotalCount = COUNT(1) OVER()

  FROM dbo.NewsletterTemplateKeys as ntk inner join dbo.NewsletterKeyTypes  as nkt
		on ntk.KeyTypeId = nkt.Id
		inner join dbo.NewsletterTemplates as nt
		on ntk.TemplateId = nt.Id
		


  WHERE nt.Id = @TemplateId

END