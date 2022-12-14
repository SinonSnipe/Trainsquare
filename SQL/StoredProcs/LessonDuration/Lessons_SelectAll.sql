USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Lessons_SelectAll]    Script Date: 8/9/2022 4:34:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Nathan Ortiz
-- Create date: 03/24/2022
-- Description: Returns a paginated selection 
--				of all records from the
--				Lessons table.
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Lessons_SelectAll]
			@pageIndex int
			,@pageSize int


/* ---------Test Code------------

	Declare @pageIndex int = 0
			,@pageSize int = 10
	
	Execute [dbo].[Lessons_SelectAll]
			@pageIndex
			,@pageSize

			
	  SELECT (Select COUNT (*) from dbo.Lessons)

*/

as

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize;



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
	  ORDER BY [SortOrder]

	  OFFSET @offset Rows
	  FETCH NEXT @pageSize Rows ONLY



END
