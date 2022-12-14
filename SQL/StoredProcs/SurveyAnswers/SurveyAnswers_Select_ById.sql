USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Select_ById]    Script Date: 8/14/2022 1:34:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/9/22
-- Description:	Select By ID for SurveyAnswers 
-- Code Reviewer: 


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyAnswers_Select_ById]
									@Id int
AS

/* TEST CODE

			Declare 
				@Id int = 1

			Execute dbo.SurveyAnswers_Select_ById
					@Id 

*/

BEGIN

			SELECT [Id]
				  ,[InstanceId]
				  ,[QuestionId]
				  ,[AnswerOptionId]
				  ,[Answer]
				  ,[AnswerNumber]
				  ,[DateCreated]
				  ,[DateModified]
			  FROM [dbo].[SurveyAnswers]

			  WHERE Id = @Id

END


