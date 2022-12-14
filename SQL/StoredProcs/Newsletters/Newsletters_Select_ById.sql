USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Newsletters_Select_ById]    Script Date: 8/14/2022 11:44:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/01/2022>
-- Description:	<Newsletters Select By Id>
-- Code Reviewer:Elizabeth Phung


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER Proc [dbo].[Newsletters_Select_ById]	
				@Id int

AS

/*

		Declare @Id int = 41;
		
		Execute dbo.Newsletters_Select_ById @Id

*/

BEGIN

SELECT 
			n.Id
			,n.TemplateId
			,n.Name
			,n.CoverPhoto
			,n.DateToPublish
			,n.DateToExpire
			,n.DateCreated
			,n.DateModified
			,n.CreatedBy
			,up.FirstName
			,up.LastName
			,up.AvatarUrl
			

FROM [dbo].[Newsletters] as n inner join dbo.UserProfiles as up
  on up.UserId = n.CreatedBy

     WHERE n.Id = @Id   
	





END


