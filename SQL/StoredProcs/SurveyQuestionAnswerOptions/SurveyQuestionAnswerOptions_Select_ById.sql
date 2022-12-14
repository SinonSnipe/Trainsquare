USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Select_ById]    Script Date: 8/14/2022 1:35:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Select By ID for SurveyQuestionAnswerOptions 
-- Code Reviewer: 


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionAnswerOptions_Select_ById]
											@Id int
AS

/* TEST CODE

			Declare 
					@Id int = 1

			Execute dbo.SurveyQuestionAnswerOptions_Select_ById
					@Id 

*/

BEGIN

			SELECT [Id]
				  ,[QuestionId]
				  ,[Text]
				  ,[Value]
				  ,[AdditionalInfo]
				  ,[CreatedBy]
				  ,[DateCreated]
				  ,[DateModified]
			  FROM [dbo].[SurveyQuestionAnswerOptions]

			Where Id = @Id

END


