USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectAll]    Script Date: 8/14/2022 1:40:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








ALTER proc [dbo].[Surveys_SelectAll]
		@pageIndex int
		,@pageSize int

/*--------------------TEST----------------------


Declare @pageIndex int = 0;

Declare @pageSize int = 10;

Execute dbo.Surveys_SelectAll @pageIndex
							  ,@pageSize

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


					  
ORDER BY Id

OFFSET @offset ROWS -- This indicates how many records to skip
FETCH NEXT @pageSize ROWS ONLY; -- this number indicated how many records to return.


END