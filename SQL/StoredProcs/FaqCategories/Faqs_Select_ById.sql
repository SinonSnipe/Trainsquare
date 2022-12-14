USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Faqs_Select_ById]    Script Date: 8/9/2022 4:11:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/8/22
-- Description: Select a FAQ by ID 
-- Code Reviewer: Elizabeth Phung 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================



ALTER proc [dbo].[Faqs_Select_ById]
				@Id int


/*---------TEST--------

	Declare @Id int = 22

	Execute [dbo].[Faqs_Select_ById] 
		   @Id 
		   
		   select * from dbo.faqs
*/---------------

as

BEGIN

SELECT f.Id
      ,Question
      ,Answer
      ,CategoryId --using 'fc.Name as CategoryName' caused conversion error
      ,SortOrder
      ,f.DateCreated
      ,f.DateModified
      ,u.Id as CreatedBy
      ,u.Id as ModifiedBy

	FROM dbo.Faqs as f 
	inner join dbo.Users as u
	ON f.CreatedBy = u.Id
	inner join dbo.FaqCategories as fc
	ON f.CategoryId = fc.Id
  
 WHERE f.Id = @Id

END

