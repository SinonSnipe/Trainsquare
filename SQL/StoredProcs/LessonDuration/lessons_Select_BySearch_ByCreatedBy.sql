USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[lessons_Select_BySearch_ByCreatedBy]    Script Date: 8/9/2022 4:34:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Nathan Ortiz
-- Create date: 05/09/2022
-- Description: Returns a paginated list of records
--				from lessons table based on a 
--				search query and by creator.
				
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[lessons_Select_BySearch_ByCreatedBy]
		@Query nvarchar(100)
		,@User int
		,@pageIndex int
		,@pageSize int

/*

---------Test Code------------
	DECLARE @Query nvarchar(100) = 'lesson';
	DECLARE @User int = 266;
	DECLARE @pageIndex int = 0;
	DECLARE @pageSize int = 20;

	Execute lessons_Select_BySearch_ByCreatedBy @Query
		,@User
		,@pageIndex
		,@pageSize
*/

as 

BEGIN

	Declare @offset int = @pageIndex * @pageSize

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
		  ,TotalCount = COUNT (1) OVER ()
	  FROM [dbo].[Lessons] as l INNER JOIN [dbo].[LessonDuration] as ld
							ON l.[DurationTypeId] = ld.[Id]

	  WHERE CreatedBy = @User AND ([Title] LIKE '%' + @Query + '%' or [Description] 
				LIKE '%' + @Query + '%')

		Order by SortOrder

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY;

END