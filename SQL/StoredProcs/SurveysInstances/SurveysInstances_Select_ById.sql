USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Select_ById]    Script Date: 8/14/2022 1:47:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Ethan Englert
-- Create date: 5/17/2022
-- Description: Select_ById proc for SurveysInstances
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROC [dbo].[SurveysInstances_Select_ById]
				@Id int

AS
/*------ TEST CODE ------
	
	Declare @Id int = 14;

    Execute dbo.[SurveysInstances_Select_ById] @Id

*/


BEGIN

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
	

		FROM [dbo].[SurveysInstances] AS si
		WHERE si.Id = @Id

END