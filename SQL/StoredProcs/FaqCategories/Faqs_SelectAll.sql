USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Faqs_SelectAll]    Script Date: 8/9/2022 4:11:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/8/22
-- Description: Select all paginated for faq
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================



ALTER proc [dbo].[Faqs_SelectAll]
			@pageIndex int
			,@pageSize int


/*---------TEST--------

	Declare @PageIndex int = 0
			,@PageSize int = 20

	Execute [dbo].[Faqs_SelectAll] 
		   @PageIndex 
			,@PageSize 

			select * from dbo.FaqCategories
			select * from dbo.User

*/---------------
as

BEGIN

Declare @OffSet int = @pageIndex * @pageSize

SELECT f.Id
      ,Question
      ,Answer
      ,CategoryId --using 'fc.Name as CategoryName' caused conversion error
      ,SortOrder
      ,f.DateCreated
      ,f.DateModified
      ,u.Id as CreatedBy
      ,u.Id as ModifiedBy
	  ,TotalCount = COUNT(1) OVER()

	FROM dbo.Faqs as f 
	inner join dbo.Users as u
	ON f.CreatedBy = u.Id
	inner join dbo.FaqCategories as fc
	ON f.CategoryId = fc.Id
					
  ORDER by f.Id

  OFFSET @OffSet ROWS 
  Fetch Next @pageSize ROWS ONLY


END