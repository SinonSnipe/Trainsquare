USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Update]    Script Date: 8/14/2022 1:34:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/9/22
-- Description:	Update proc for SurveyAnswers
-- Code Reviewer:


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyAnswers_Update]
									@InstanceId int
									,@QuestionId int
									,@AnswerOptionId int
									,@Answer nvarchar(500)
									,@AnswerNumber int
									,@Id int 

AS

/* TEST CODE

			Declare @InstanceId int = 2
					,@QuestionId int = 2
					,@AnswerOptionId int = 2
					,@Answer nvarchar(500) ='Answer Update'
					,@AnswerNumber int = 420069
					,@Id int = 4

			Execute dbo.SurveyAnswers_Select_ById @Id

			Execute dbo.SurveyAnswers_Update
									@InstanceId
									,@QuestionId
									,@AnswerOptionId 
									,@Answer
									,@AnswerNumber
									,@Id

			Execute dbo.SurveyAnswers_Select_ById @Id

*/

BEGIN

			Declare @TimeNow datetime2 = GETUTCDATE()

			UPDATE [dbo].[SurveyAnswers]
			   SET [InstanceId] = @InstanceId
				  ,[QuestionId] = @QuestionId
				  ,[AnswerOptionId] = @AnswerOptionId
				  ,[Answer] = @Answer
				  ,[AnswerNumber] = @AnswerNumber
				  ,[DateModified] = @TimeNow

			 WHERE Id = @Id

END


