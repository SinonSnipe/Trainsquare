USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionTypes_SelectAll]    Script Date: 8/14/2022 1:39:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/7/22
-- Description:	Select All Proc for SurveyQuestionTypes
-- Code Reviewer:


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionTypes_SelectAll]


AS

/* TEST CODE
		
			Execute SurveyQuestionTypes_SelectAll

*/


BEGIN

		SELECT [Id]
			  ,[Name]

		FROM [dbo].[SurveyQuestionTypes]
		ORDER BY id

END


