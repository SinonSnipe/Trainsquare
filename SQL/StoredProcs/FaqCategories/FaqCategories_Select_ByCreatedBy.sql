USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FaqCategories_Select_ByCreatedBy]    Script Date: 8/9/2022 4:11:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/12/22
-- Description: select a faq by its creator
-- Code Reviewer: 
-- Note: Needs work. Does not return any data

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[FaqCategories_Select_ByCreatedBy]
			@CreatedBy int
			,@PageIndex int
			,@PageSize int

/*---------TEST--------

	Declare @CreatedBy int = 5
			,@pageIndex int = 0
			,@pageSize int = 10

	Execute [dbo].[FaqCategories_Select_ByCreatedBy] 
			@CreatedBy
			,@pageIndex
			,@pageSize

*/---------------

as
BEGIN

DECLARE @offset int = @pageIndex * @pageSize

SELECT fc.Id
      ,Name
	  ,u.Id as CreatedBy
	  ,TotalCount = COUNT(1) OVER()

  FROM dbo.FaqCategories as fc
  inner join dbo.Users as u
  ON fc.Id = u.Id

  WHERE u.Id = @CreatedBy				
  ORDER by Id

  OFFSET @OffSet ROWS 
  Fetch Next @PageSize ROWS ONLY

END


