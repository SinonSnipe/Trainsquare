USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Select_ByCreatedBy]    Script Date: 8/14/2022 1:47:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Ethan Englert
-- Create date: 5/17/2022
-- Description: Select_ByCreatedBy proc for SurveysInstances
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROC [dbo].[SurveysInstances_Select_ByCreatedBy]
				 @pageIndex int
				,@pageSize  int
				,@UserId    int

AS
/*------ TEST CODE ------
	
	DECLARE @pageIndex  int = 0
		   ,@pageSize   int = 10
		   ,@UserId     int = 240

	EXECUTE dbo.SurveysInstances_Select_ByCreatedBy 
			@pageIndex
		   ,@pageSize
		   ,@UserId

*/


BEGIN

		Declare @offset int = @pageIndex*@pageSize
		
		SELECT   [Id]
				,Survey = (SELECT s.[Name]
						   FROM dbo.Surveys AS s
						   WHERE s.Id = si.SurveyId)
				,[User] = (SELECT u.Email
						   FROM dbo.Users as u
						   WHERE u.Id = si.UserId)
				,SurveyAnswer = (SELECT sa.Answer
								 FROM dbo.SurveyAnswers AS sa
								 WHERE sa.InstanceId = si.Id)
				,[DateCreated]
				,[DateModified]
				,TotalCount = COUNT(1)OVER()
	

		FROM [dbo].[SurveysInstances] AS si
		WHERE si.UserId = @UserId

		ORDER BY si.DateModified DESC
		
		OFFSET @offSet Rows
		Fetch Next @PageSize Rows ONLY

END