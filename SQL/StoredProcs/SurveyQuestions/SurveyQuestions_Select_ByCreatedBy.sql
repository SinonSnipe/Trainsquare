USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestions_Select_ByCreatedBy]    Script Date: 8/14/2022 1:37:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Select By CreatedBy for SurveyQuestions 
-- Code Reviewer: 


-- MODIFIED BY: Ethan Englert
-- MODIFIED DATE: 6/2/22
-- Code Reviewer: 
-- Note: Changed SectionId to SurveyId
-- =============================================

ALTER proc [dbo].[SurveyQuestions_Select_ByCreatedBy]
									@UserId int
									,@pageIndex int 
									,@pageSize int

AS

/* TEST CODE

			Declare 
				@UserId int = 2
				,@pageIndex int = 0
				,@pageSize int = 10

			Execute dbo.SurveyQuestions_Select_ByCreatedBy
					@UserId
					,@pageIndex
					,@pageSize

*/

BEGIN

		Declare @offset int = @pageIndex * @pageSize

		SELECT sq.[Id]
			  ,[UserId]
			  ,[Question]
			  ,[HelpText]
			  ,[IsRequired]
			  ,[IsMultipleAllowed]
			  ,sqt.[Name] as [QuestionType]
			  ,[SurveyId]
			  ,ss.[Name] as [Status]
			  ,[SortOrder]
			  ,[DateCreated]
			  ,[DateModified]
			  ,[TotalCount] = COUNT(1) OVER()

		  FROM [dbo].[SurveyQuestions] as sq inner join dbo.SurveyStatus as ss 
					on sq.StatusId = ss.Id
				inner join dbo.SurveyQuestionTypes as sqt
					on sq.QuestionTypeId = sqt.Id

		  WHERE sq.UserId = @UserId
		  ORDER BY id

			OFFSET @offset Rows
			Fetch Next @pageSize Rows ONLY

END


