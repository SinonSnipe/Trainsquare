USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterContent_Select_ById]    Script Date: 8/14/2022 11:43:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/18/2022>
-- Description:	<NewsletterContent Select By Id>
-- Code Reviewer: Lia Archuleta


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[NewsletterContent_Select_ById]

		@Id int
AS

/*

DECLARE @Id int = 3
EXECUTE dbo.NewsletterContent_Select_ById @Id


*/

BEGIN

SELECT nc.Id
      ,ntk.Id as TemplateKeyId
      ,n.Id as NewsletterId
      ,nc.Value
      ,nc.DateCreated
      ,nc.DateModified
      ,nc.CreatedBy
	  ,up.FirstName
	  ,up.LastName
	  ,up.AvatarUrl


  FROM [dbo].[NewsletterContent] as nc inner join dbo.NewsletterTemplateKeys as ntk
  on  ntk.id = nc.TemplateKeyId
  inner join dbo.Newsletters as n 
  on n.id = nc.NewsletterId
  inner join dbo.UserProfiles as up
  on up.UserId = nc.CreatedBy

  WHERE nc.Id = @Id

END


