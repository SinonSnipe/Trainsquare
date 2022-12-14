USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Faqs_Delete_ById]    Script Date: 8/9/2022 4:11:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/10/22
-- Description: delete faq by id
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================
ALTER proc [dbo].[Faqs_Delete_ById]
				@Id int


/*---------TEST--------

	SELECT *
	FROM dbo.Faqs

	Declare @Id int = 2
		   
	Execute [dbo].[Faqs_Delete_ById] 
		   @Id
		  
	SELECT *
	FROM dbo.Faqs


*/---------------

as

BEGIN

DELETE FROM [dbo].[Faqs]
      WHERE Id = @Id

END


