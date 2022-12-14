USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Notes_SelectAll]    Script Date: 8/14/2022 11:50:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Maria Quintana
-- Create date: 04/02/2022
-- Description: SelectAll (Paginated) proc for Notes
-- Code Reviewer: Tawni M.
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER PROC [dbo].[Notes_SelectAll]
			 @PageIndex int
			,@PageSize int

AS
/*---TEST CODE---

DECLARE		 @PageIndex int= 0
			,@PageSize int= 5

EXECUTE [dbo].[Notes_SelectAll]
			 @PageIndex
			,@PageSize


*/

BEGIN

	DECLARE	@offset int =  @PageIndex * @PageSize

		  SELECT	 n.Id as noteId
					,n.Notes
					,n.WorkShopId
					,ws.ImageUrl
					,ws.Name
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
										
  
  ORDER BY n.Id

  OFFSET @offSet Rows
  Fetch Next @pageSize Rows ONLY

END


