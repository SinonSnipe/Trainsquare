USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Faqs_Update]    Script Date: 8/9/2022 4:11:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/8/22
-- Description: updating faq. should pick ID of faq and update data within
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================



ALTER proc [dbo].[Faqs_Update]
				@Question nvarchar(255)
				,@Answer nvarchar(2000)
				,@CategoryId int
				,@SortOrder int
				,@CreatedBy int
				,@ModifiedBy int
				,@Id int
	
/*---------TEST--------

	SELECT *
	FROM dbo.Faqs

	Declare @Id int = 33

	Declare @Question nvarchar(255) = 'Test faq question 35'
           ,@Answer nvarchar(2000) = 'Test faq answer 35'
           ,@CategoryId int = 5
           ,@SortOrder int = 3
		   ,@CreatedBy int = 223
           ,@ModifiedBy int = 223
		   
		   

	Execute [dbo].[Faqs_Update] 
		   @Question
           ,@Answer 
           ,@CategoryId 
           ,@SortOrder 
		   ,@CreatedBy
           ,@ModifiedBy 
		   ,@Id
		    

	SELECT *
	FROM dbo.Faqs


*/---------------

as

BEGIN

DECLARE @date datetime2(7) = getutcdate();


UPDATE [dbo].[Faqs]
   SET [Question] = @Question
      ,[Answer] = @Answer
      ,[CategoryId] = @CategoryId
      ,[SortOrder] = @SortOrder
	  ,[CreatedBy] = @CreatedBy
      ,[ModifiedBy] = @ModifiedBy
	  ,[DateModified] = @date

 WHERE Id = @Id


 END