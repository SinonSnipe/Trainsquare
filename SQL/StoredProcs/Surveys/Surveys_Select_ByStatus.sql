USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_Select_ByStatus]    Script Date: 8/14/2022 1:40:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER proc [dbo].[Surveys_Select_ByStatus]
				@pageIndex int
				,@pageSize int
				,@Query nvarchar(100)
/* ------------------------------TEST----------------------------------

Declare @pageIndex int = 0;
Declare @pageSize int = 10;
Declare @Query nvarchar(100) = '3';



Execute dbo.[Surveys_Select_ByStatus]	@pageIndex
										,@pageSize
										,@Query


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

				Where (
						s.StatusId LIKE '%' + @Query + '%' 
						)

				order by s.DateModified DESC

				OFFSET @offset ROWS
				FETCH NEXT @pageSize ROWS ONLY;



END