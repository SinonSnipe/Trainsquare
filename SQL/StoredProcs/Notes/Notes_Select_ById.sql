USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Notes_Select_ById]    Script Date: 8/14/2022 11:50:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Maria Quintana
-- Create date: 04/02/2022
-- Description: Select_ById proc for Notes
-- Code Reviewer:  Tawni M.
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[Notes_Select_ById]
					@Id int
as
/*---TEST CODE---
DECLARE @Id int = 120

EXECUTE [dbo].[Notes_Select_ById] @Id

select *
from notes



*/
BEGIN
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

 WHERE n.Id = @Id
  ORDER BY n.Id
 
END


