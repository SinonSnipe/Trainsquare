USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Insert]    Script Date: 8/14/2022 1:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Insert proc for SurveyQuestions
-- Code Reviewer:


-- MODIFIED BY: Ethan Englert
-- MODIFIED DATE: 6/2/22
-- Code Reviewer: 
-- Note: Changed SectionId to SurveyId
-- =============================================

ALTER proc [dbo].[SurveyQuestions_Insert]
					@UserId int
				   ,@Question nvarchar(500)
				   ,@HelpText nvarchar(255) 
				   ,@IsRequired bit
				   ,@IsMultipleAllowed bit
				   ,@QuestionTypeId int
				   ,@SurveyId int
				   ,@StatusId int
				   ,@SortOrder int
				   ,@Id int OUTPUT

AS

/* TEST CODE

			Declare @UserId int = 1
				    ,@Question nvarchar(500) = 'This is a Test Question'
				    ,@HelpText nvarchar(255)  = 'Help Text'
				    ,@IsRequired bit = 1
				    ,@IsMultipleAllowed bit = 1
				    ,@QuestionTypeId int = 2
				    ,@SurveyId int = 67
				    ,@StatusId int = 2
				    ,@SortOrder int = 1
				    ,@Id int

			Execute dbo.SurveyQuestions_Insert
					@UserId 
					,@Question
					,@HelpText
					,@IsRequired
					,@IsMultipleAllowed
					,@QuestionTypeId
					,@SurveyId
					,@StatusId
					,@SortOrder
					,@Id OUTPUT

			Execute dbo.SurveyQuestions_Select_ById @Id

*/

BEGIN

		INSERT INTO [dbo].[SurveyQuestions]
				   ([UserId]
				   ,[Question]
				   ,[HelpText]
				   ,[IsRequired]
				   ,[IsMultipleAllowed]
				   ,[QuestionTypeId]
				   ,[SurveyId]
				   ,[StatusId]
				   ,[SortOrder])

			 VALUES
				   (@UserId 
				   ,@Question
				   ,@HelpText
				   ,@IsRequired
				   ,@IsMultipleAllowed
				   ,@QuestionTypeId
				   ,@SurveyId
				   ,@StatusId
				   ,@SortOrder)

			SET @Id = SCOPE_IDENTITY()
			
END
