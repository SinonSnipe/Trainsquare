USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Faqs_Select_ByCreatedBy]    Script Date: 8/9/2022 4:11:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/11/22
-- Description: select a faq by its creator
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================



ALTER proc [dbo].[Faqs_Select_ByCreatedBy]
			@CreatedBy int
			,@PageIndex int
			,@PageSize int

/*---------TEST--------

	Declare @CreatedBy int = 218
			,@pageIndex int = 0
			,@pageSize int = 10

	Execute [dbo].[Faqs_Select_ByCreatedBy] 
			@CreatedBy
			,@pageIndex
			,@pageSize

			select * from dbo.faqs

			select * from dbo.Users

*/---------------

as
BEGIN

DECLARE @offset int = @pageIndex * @pageSize

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

  WHERE CreatedBy = @CreatedBy				
  ORDER by Id

  OFFSET @OffSet ROWS 
  Fetch Next @PageSize ROWS ONLY
END

