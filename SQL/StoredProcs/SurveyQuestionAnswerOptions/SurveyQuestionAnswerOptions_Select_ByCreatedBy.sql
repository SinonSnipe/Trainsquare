USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionAnswerOptions_Select_ByCreatedBy]    Script Date: 8/14/2022 1:35:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Select By Created By for SurveyQuestionAnswerOptions 
-- Code Reviewer: 


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionAnswerOptions_Select_ByCreatedBy]
											@Id int
											,@pageIndex int 
											,@pageSize int
AS

/* TEST CODE

			Declare 
					@Id int = 1
					,@pageIndex int = 0
					,@pageSize int = 10

			Execute dbo.SurveyQuestionAnswerOptions_Select_ByCreatedBy
					@Id 
					,@pageIndex
					,@pageSize

*/

BEGIN
			Declare @offset int = @pageIndex * @pageSize

			SELECT [Id]
				  ,[QuestionId]
				  ,[Text]
				  ,[Value]
				  ,[AdditionalInfo]
				  ,[CreatedBy]
				  ,[DateCreated]
				  ,[DateModified]
				  ,[TotalCount] = COUNT(1) OVER()

			  FROM [dbo].[SurveyQuestionAnswerOptions]

			Where Id = @Id

			ORDER BY id

			OFFSET @offset Rows
			Fetch Next @pageSize Rows ONLY

END


