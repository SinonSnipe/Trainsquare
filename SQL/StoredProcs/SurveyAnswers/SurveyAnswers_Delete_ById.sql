USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyAnswers_Delete_ById]    Script Date: 8/14/2022 1:34:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/9/22
-- Description:	Delete By ID for SurveyAnswers
-- Code Reviewer: 


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyAnswers_Delete_ById]
									@Id int

AS

/* TEST CODE
	
			Declare @Id int = 3

			Execute dbo.SurveyAnswers_Select_ById 
									@Id 
		
			Execute dbo.SurveyAnswers_Delete_ById
									@Id 
											
			Execute dbo.SurveyAnswers_Select_ById 
									@Id 

*/

BEGIN

			DELETE FROM [dbo].[SurveyAnswers]
				  WHERE Id = @Id

END


