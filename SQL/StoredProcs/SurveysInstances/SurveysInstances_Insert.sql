USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Insert]    Script Date: 8/14/2022 1:47:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Ethan Englert
-- Create date: 5/17/2022
-- Description: Insert proc for SurveysInstances
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROC [dbo].[SurveysInstances_Insert]
							@SurveyId int
						   ,@UserId int
						   ,@Id int OUTPUT

AS
/*----- TEST CODE -----
	
	DECLARE @SurveyId int = 67
		   ,@UserId int = 240
		   ,@Id int = 1

	EXECUTE dbo.SurveysInstances_Insert
							@SurveyId
						   ,@UserId
						   ,@Id OUTPUT

	EXECUTE dbo.[SurveysInstances_Select_ById] @Id

*/

BEGIN


			INSERT INTO [dbo].[SurveysInstances]
						([SurveyId]
						,[UserId])
	
			VALUES		(@SurveyId
						,@UserId)
	
			SET @Id = SCOPE_IDENTITY()


END