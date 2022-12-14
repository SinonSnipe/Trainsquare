USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Insert]    Script Date: 8/14/2022 1:35:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Insert proc for SurveyQuestionAnswerOptions
-- Code Reviewer:


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionAnswerOptions_Insert]
					@QuestionId int
					,@Text nvarchar(500)
					,@Value nvarchar(100)
					,@AdditionalInfo nvarchar(200)
					,@CreatedBy int
					,@Id int OUTPUT

AS

/* TEST CODE

			Declare @QuestionId int = 3
					,@Text nvarchar(500) = 'Test Text Answer'
					,@Value nvarchar(100) = 'what is this for?'
					,@AdditionalInfo nvarchar(200) ='Additional Info'
					,@CreatedBy int = 1
					,@Id int

			Execute dbo.SurveyQuestionAnswerOptions_Insert
					@QuestionId
					,@Text
					,@Value
					,@AdditionalInfo
					,@CreatedBy
					,@Id OUTPUT

			Execute dbo.SurveyQuestionAnswerOptions_Select_ById
					@Id 

*/

BEGIN

		INSERT INTO [dbo].[SurveyQuestionAnswerOptions]
				   ([QuestionId]
				   ,[Text]
				   ,[Value]
				   ,[AdditionalInfo]
				   ,[CreatedBy])

			 VALUES
				   (@QuestionId
				   ,@Text
				   ,@Value
				   ,@AdditionalInfo
				   ,@CreatedBy)

		SET @Id = SCOPE_IDENTITY()
END

