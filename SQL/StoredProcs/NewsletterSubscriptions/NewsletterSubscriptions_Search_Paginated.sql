USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[NewsletterSubscriptions_Search_Paginated]    Script Date: 8/14/2022 11:45:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Frank Vilardi
-- CREATE DATE: 04/25/2022
-- DESCRIPTION:	NewsletterSubscriptions Search (Paginated) 
-- CODE REVIEWER: Abel Amezcua


-- MODIFIED BY: 
-- MODIFIED DATE:
-- CODE REVIEWER: 
-- NOTE: 
-- =============================================

ALTER PROC [dbo].[NewsletterSubscriptions_Search_Paginated]
			 @pageIndex int 
            ,@pageSize int
			,@Query nvarchar(100)

AS


/*
DECLARE @pageIndex int = 0
		,@pageSize int = 10
		,@Query nvarchar(100) = 'frank'

Declare @offset int = @pageIndex * @pageSize

EXECUTE [dbo].[NewsletterSubscriptions_Search_Paginated] @pageIndex 
														,@pageSize
														,@Query 
	
*/

BEGIN

Declare @Offset int = @PageIndex * @PageSize

SELECT [Email]
	  ,[IsSubscribed]
      ,[DateCreated]
      ,[DateModified]
	  ,TotalCount = COUNT (1) OVER() 

FROM [dbo].[NewsletterSubscriptions]

WHERE	( Email LIKE '%' + @Query + '%')
		 		
		ORDER BY Email 
		OFFSET @Offset ROWS
		FETCH NEXT @PageSize ROWS ONLY; 

END