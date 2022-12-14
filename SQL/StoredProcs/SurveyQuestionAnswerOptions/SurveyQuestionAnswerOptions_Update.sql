USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Update]    Script Date: 8/14/2022 1:35:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Update for SurveyQuestionAnswerOptions
-- Code Reviewer:


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionAnswerOptions_Update]
					@QuestionId int
					,@Text nvarchar(500)
					,@Value nvarchar(100)
					,@AdditionalInfo nvarchar(200)
					,@CreatedBy int
					,@Id int

AS

/* TEST CODE

			Declare @QuestionId int = 1
					,@Text nvarchar(500)
					,@Value nvarchar(100) = 'Value Update'
					,@AdditionalInfo nvarchar(100) = 'Add Info'
					,@CreatedBy int = 2
					,@Id int = 1

			Execute dbo.SurveyQuestionAnswerOptions_Select_ById @Id

			Execute dbo.SurveyQuestionAnswerOptions_Update
					@QuestionId
					,@Text
					,@Value
					,@AdditionalInfo
					,@CreatedBy 
					,@Id

			Execute dbo.SurveyQuestionAnswerOptions_Select_ById @Id

*/

BEGIN

			Declare @TimeNow datetime2 = GETUTCDATE()

			UPDATE [dbo].[SurveyQuestionAnswerOptions]
			   SET [QuestionId] = @QuestionId
				  ,[Text] = @Text
				  ,[Value] = @Value
				  ,[AdditionalInfo] = @AdditionalInfo
				  ,[CreatedBy] = @CreatedBy
				  ,[DateModified] = @TimeNow

			 WHERE Id = @Id

END


