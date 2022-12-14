USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionTypes_Insert]    Script Date: 8/14/2022 1:39:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/7/22
-- Description:	Insert Proc for SurveyQuestionTypes
-- Code Reviewer:


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionTypes_Insert]
						@Name nvarchar(100)
						,@Id int OUTPUT

AS

/* TEST CODE
	
			Declare @Name nvarchar(100) = 'Number'
						,@Id int
		
			Execute SurveyQuestionTypes_Insert
						@Name
						,@Id OUTPUT

			Execute dbo.SurveyQuestionTypes_Select_ById 
						@Id

*/


BEGIN

			INSERT INTO [dbo].SurveyQuestionTypes
					   ([Name])
			SELECT @Name
			WHERE NOT EXISTS ( SELECT 1 
								FROM [dbo].[SurveyQuestionTypes]
								WHERE [Name] = @Name);

			SET @id = SCOPE_IDENTITY()

END