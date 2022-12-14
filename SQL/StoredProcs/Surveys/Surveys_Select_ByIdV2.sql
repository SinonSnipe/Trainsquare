USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_Select_ByIdV2]    Script Date: 8/14/2022 1:40:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






ALTER proc [dbo].[Surveys_Select_ByIdV2]
			@Id int

/*----------------------------TEST-------------------------

Declare @Id int = 68;

Execute dbo.[Surveys_Select_ByIdV2] @Id


*/


as


BEGIN



Select s.Id
	   ,s.[Name]
	   ,s.[Description]
	   ,s.ImageUrl
	   ,s.StatusId
	   ,sS.[Name]
	   ,s.SurveyTypeId
	   ,sT.[Name]
	   ,s.CreatedBy
	   ,uP.FirstName
	   ,uP.LastName
	   ,uP.AvatarUrl
	   ,s.DateCreated
	   ,s.DateModified
	   ,TotalCount = COUNT(1) OVER()

FROM dbo.Surveys as s INNER JOIN dbo.SurveyStatus as ss
				on s.StatusId = ss.Id
					  INNER JOIN dbo.SurveyTypes as st
				on s.SurveyTypeId = st.Id
					  INNER JOIN dbo.UserProfiles as up
				on s.CreatedBy = up.Id

WHERE s.Id = @Id



END