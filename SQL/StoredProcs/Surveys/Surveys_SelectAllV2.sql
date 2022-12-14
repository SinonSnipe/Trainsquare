USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_SelectAllV2]    Script Date: 8/14/2022 1:40:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








ALTER proc [dbo].[Surveys_SelectAllV2]
		@pageIndex int
		,@pageSize int

/*--------------------TEST----------------------


Declare @pageIndex int = 0;

Declare @pageSize int = 100;

Execute dbo.[Surveys_SelectAllV2] @pageIndex
							  ,@pageSize

*/

as 



BEGIN

Declare @offset int = @pageIndex*@pageSize

Select s.Id
	   ,s.Name
	   ,s.Description
	   ,s.ImageUrl
	   ,s.StatusId
	   ,sS.Name
	   ,s.SurveyTypeId
	   ,sT.Name
	   ,s.CreatedBy
	   ,uP.FirstName
	   ,uP.LastName
	   ,uP.AvatarUrl
	   ,s.DateCreated
	   ,s.DateModified
	   ,TotalCount = COUNT(1) OVER()

FROM dbo.Surveys as s INNER JOIN dbo.SurveyStatus as sS
				on s.StatusId = sS.Id
					  INNER JOIN dbo.SurveyTypes as sT
				on s.SurveyTypeId = sT.Id
					  INNER JOIN dbo.UserProfiles as uP
				on s.CreatedBy = uP.UserId

ORDER BY s.DateModified DESC

OFFSET @offset ROWS -- This indicates how many records to skip
FETCH NEXT @pageSize ROWS ONLY; -- this number indicated how many records to return.


END