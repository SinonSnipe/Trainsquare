USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Insert]    Script Date: 8/14/2022 1:34:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/9/22
-- Description:	Insert proc for SurveyAnswers
-- Code Reviewer:


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyAnswers_Insert]
									@InstanceId int
									,@QuestionId int
									,@AnswerOptionId int
									,@Answer nvarchar(500)
									,@AnswerNumber int
									,@Id int OUTPUT

AS

/* TEST CODE

			Declare @InstanceId int = 1
					,@QuestionId int = 1
					,@AnswerOptionId int = 1
					,@Answer nvarchar(500) = 'This is a test Answer'
					,@AnswerNumber int 
					,@Id int

			Execute dbo.SurveyAnswers_Insert
									@InstanceId
									,@QuestionId
									,@AnswerOptionId 
									,@Answer
									,@AnswerNumber
									,@Id OUTPUT

			Execute dbo.SurveyAnswers_Select_ById @Id

*/

BEGIN

			INSERT INTO [dbo].[SurveyAnswers]
						([InstanceId]
						,[QuestionId]
						,[AnswerOptionId]
						,[Answer]
						,[AnswerNumber])

				 VALUES
						(@InstanceId
						,@QuestionId
						,@AnswerOptionId 
						,@Answer
						,@AnswerNumber)

				 SET @Id = SCOPE_IDENTITY()

END


