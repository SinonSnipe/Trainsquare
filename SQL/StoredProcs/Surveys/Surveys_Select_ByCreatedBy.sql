USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_Select_ByCreatedBy]    Script Date: 8/14/2022 1:40:03 PM ******/
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

ALTER proc [dbo].[Surveys_Select_ByCreatedBy]
			@pageIndex int
			,@pageSize int
			,@CreatedBy int
/*-------------------------TEST-----------------------

Declare @pageIndex int = 0;
Declare @pageSize int = 10;
Declare @CreatedBy int = 2;

Execute Surveys_Select_ByCreatedBy  @pageIndex
									,@pageSize
									,@CreatedBy

*/

as



BEGIN

				Declare @offset int = @pageIndex*@pageSize

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

				Where @CreatedBy = CreatedBy

				order by Id

				OFFSET @offset ROWS
				FETCH NEXT @pageSize ROWS ONLY;





END