USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SurveyQuestionTypes_Update]    Script Date: 8/14/2022 1:39:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/7/22
-- Description:	Update Proc for SurveyQuestionTypes
-- Code Reviewer: 


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[SurveyQuestionTypes_Update]
					@Name nvarchar(50)
					,@Id int

AS

/* TEST CODE

			Declare @Name nvarchar(50) = 'TEST'
					,@Id int = 8

			Execute dbo.SurveyQuestionTypes_Select_ById 
					@Id

			Execute dbo.SurveyQuestionTypes_Update
					 @Name
					,@Id

			Execute dbo.SurveyQuestionTypes_Select_ById 
					@Id

*/

BEGIN

			UPDATE [dbo].SurveyQuestionTypes
			   SET [Name] = @Name

			WHERE Id = @Id

END


