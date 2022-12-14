USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Faqs_Insert]    Script Date: 8/9/2022 4:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Stephanie Zavala
-- Create date: 4/8/22
-- Description: Insert into faq
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================



ALTER proc [dbo].[Faqs_Insert]
			@Question nvarchar(255)
           ,@Answer nvarchar(2000)
           ,@CategoryId int
           ,@SortOrder int
           ,@CreatedBy int
           ,@ModifiedBy int
		   ,@Id int OUTPUT

/*---------TEST--------
    SELECT *
	FROM dbo.Faqs

	Declare @Question nvarchar(255) = 'Test faq question 31'
           ,@Answer nvarchar(2000) = 'Test faq answer 31'
           ,@CategoryId int = 2
           ,@SortOrder int = 10
           ,@CreatedBy int = 226
           ,@ModifiedBy int = 226
		   ,@ID int

	Execute [dbo].[Faqs_Insert] 
		   @Question 
           ,@Answer 
           ,@CategoryId 
           ,@SortOrder 
           ,@CreatedBy 
           ,@ModifiedBy 
		   ,@ID OUTPUT

	SELECT *
	FROM dbo.Faqs

	Select * from dbo.users
*/---------------

as

BEGIN


INSERT INTO [dbo].[Faqs]
           ([Question]
           ,[Answer]
           ,[CategoryId]
           ,[SortOrder]
           ,[CreatedBy]
           ,[ModifiedBy])
     VALUES
           (@Question
           ,@Answer
           ,@CategoryId
           ,@SortOrder
           ,@CreatedBy
           ,@ModifiedBy)

	SET @Id = SCOPE_IDENTITY()
END
