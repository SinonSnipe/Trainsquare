USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FaqCategories_SelectAll]    Script Date: 8/9/2022 4:11:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/12/22
-- Description: Select all paginated for faq
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[FaqCategories_SelectAll]
			


/*---------TEST--------

	
	Execute [dbo].[FaqCategories_SelectAll] 
		
	select * from dbo.faqs

*/---------------

as

BEGIN



SELECT Id
      ,Name

  FROM dbo.FaqCategories


  ORDER by Id

 


END


