USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplates_SelectAll]    Script Date: 8/14/2022 11:49:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/01/2022>
-- Description:	<NewsletterTemplates SelectAll (Paginted) >
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[NewsletterTemplates_SelectAll]
			 @pageIndex int 
            ,@pageSize int

AS


/*
DECLARE
			@pageIndex int = 0
			,@pageSize int = 4
	

EXECUTE [dbo].[NewsletterTemplates_SelectAll]	
	
			@pageIndex 
			,@pageSize

			

*/

BEGIN

  Declare @offset int = @pageIndex * @pageSize

SELECT [Id]
      ,[Name]
      ,[Description]
      ,[PrimaryImage]
      ,[DateCreated]
      ,[DateModified]
      ,[CreatedBy]
	  , TotalCount = COUNT (1) OVER() 

  FROM [dbo].[NewsletterTemplates]

	ORDER BY Id

	OFFSET @offSet Rows
	Fetch Next @pageSize Rows ONLY

END


