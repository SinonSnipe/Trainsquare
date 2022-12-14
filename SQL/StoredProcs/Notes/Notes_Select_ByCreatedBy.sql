USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Notes_Select_ByCreatedBy]    Script Date: 8/14/2022 11:50:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maria Quintana
-- Create date: 4/4/22
-- Description:	Select By Created By Proc for Notes
-- Code Reviewer: Tawni M.


-- MODIFIED BY: author
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:  
-- =============================================
ALTER PROC [dbo].[Notes_Select_ByCreatedBy]
					 @CreatedBy int
					,@PageIndex int
					,@PageSize int
					

AS
/*-----------TEST CODE-----------
		DECLARE		 @CreatedBy int = 260
					,@PageIndex int = 0
					,@PageSize int = 5
					
					

EXECUTE [dbo].[Notes_Select_ByCreatedBy]
										 @CreatedBy
										,@PageIndex
										,@PageSize



	
*/

BEGIN	

	DECLARE @offset int = @pageIndex * @pageSize
	
			 SELECT		 n.Id as noteId
						,n.Notes
						,n.WorkShopId
						,ws.ImageUrl
						,t.Id as tagId
						,t.Name as tagName
						,n.DateCreated
						,n.DateModified
						,n.CreatedBy
						,n.ModifiedBy
						,[TotalCount] = COUNT(1) OVER()

					FROM dbo.WorkShop   AS ws INNER JOIN dbo.Notes AS n
										ON ws.Id = n.WorkShopId
										INNER JOIN dbo.TagsTypes AS t
										ON n.TagsTypeId = t.Id
			  WHERE n.CreatedBy = @CreatedBy
			  ORDER BY CreatedBy

	OFFSET @offset Rows
		FETCH NEXT 10 Rows ONLY

END


