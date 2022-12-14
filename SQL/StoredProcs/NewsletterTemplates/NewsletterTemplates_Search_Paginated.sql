USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterTemplates_Search_Paginated]    Script Date: 8/14/2022 11:49:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/09/2022>
-- Description:	<NewsletterTemplates Search (Paginated) >
-- Code Reviewer: 


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[NewsletterTemplates_Search_Paginated]
			 @pageIndex int 
            ,@pageSize int
			,@Query nvarchar(100)

AS


/*
DECLARE
			@pageIndex int = 0
			,@pageSize int = 10
			,@Query nvarchar(100) = 'test'
	

EXECUTE [dbo].[NewsletterTemplates_Search_Paginated]
	
			@pageIndex 
			,@pageSize
			,@Query 

select*
from dbo.newslettertemplates
			

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

	

	

WHERE	( Name LIKE '%' + @Query + '%')
		 
			
		ORDER BY Id 
		OFFSET @Offset ROWS
		FETCH NEXT @PageSize ROWS ONLY; 

END


