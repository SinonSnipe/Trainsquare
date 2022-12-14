USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Lessons_Select_ByCreatedBy]    Script Date: 8/9/2022 4:34:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: 03/24/2022
-- Description: Returns a paginated selection of 
--				records by the User creator from
--				the Lessons table.
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Lessons_Select_ByCreatedBy]
			@User int
			,@pageIndex int
			,@pageSize int

/*---------Test Code------------

	Declare @User int = 212
			,@pageIndex int = 0
			,@pageSize int = 10

	EXECUTE [dbo].[Lessons_Select_ByCreatedBy]
			@User
			,@pageIndex
			,@pageSize

*/

as

BEGIN


	Declare @offset int = @pageIndex * @pageSize;

	SELECT l.[Id]
		  ,l.[Title]
		  ,l.[Description]
		  ,l.[DurationTypeId]
		  ,ld.[Name]
		  ,l.[ImageUrl]
		  ,l.[FileUrl]
		  ,l.[SortOrder]
		  ,l.[CreatedBy]
		  ,l.[ModifiedBy]
		  ,l.[DateCreated]
		  ,l.[DateModified]
		  ,TotalCount = COUNT(1) OVER()

	  FROM [dbo].[Lessons] as l INNER JOIN [dbo].[LessonDuration] as ld
							ON l.[DurationTypeId] = ld.[Id]
	  WHERE CreatedBy = @User
	  ORDER BY [SortOrder]

	  OFFSET @offset Rows
	  FETCH NEXT @pageSize Rows ONLY


END



