USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveysInstances_Update]    Script Date: 8/14/2022 1:47:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Ethan Englert
-- Create date: 5/17/2022
-- Description: Update proc for SurveysInstances
-- Code Reviewer:

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[SurveysInstances_Update]
			@SurveyId int
		   ,@UserId int
		   ,@Id int


AS
/*----- TEST CODE -----

	DECLARE @SurveyId int = 112
		   ,@UserId int = 264
		   ,@Id int = 5

	EXECUTE dbo.SurveysInstances_Select_ById @Id
	
	EXECUTE dbo.SurveysInstances_Update
			@SurveyId
		   ,@UserId
		   ,@Id

	EXECUTE dbo.SurveysInstances_Select_ById @Id


*/
BEGIN

		DECLARE @dateNow datetime2 = GETUTCDATE()

		UPDATE [dbo].[SurveysInstances]
		   SET [SurveyId] = @SurveyId
			  ,[UserId] = @UserId
			  ,[DateModified] = @dateNow
		 WHERE Id = @Id

END