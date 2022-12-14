USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_Select_ById]    Script Date: 8/14/2022 1:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- Author: Changwoo Lee
-- Create date: 04/11/2022
-- Description:	Select All
-- Code Reviewer: Lia Archuleta


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 


ALTER proc [dbo].[Surveys_Select_ById]
			@Id int

/*----------------------------TEST-------------------------

Declare @Id int = 1;

Execute dbo.Surveys_Select_ById @Id


*/


as


BEGIN



				Select Id
					   ,Name
					   ,Description
					   ,StatusId					   
					   ,SurveyTypeId					   
					   ,CreatedBy 					   
					   ,DateCreated
					   ,DateModified
					   ,TotalCount = COUNT(1) OVER()

				FROM dbo.Surveys 



WHERE Id = @Id



END