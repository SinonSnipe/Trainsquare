USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Lessons_Select_ById]    Script Date: 8/9/2022 4:34:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Nathan Ortiz
-- Create date: 03/24/2022
-- Description: Selects a single record by Id 
--				from the Lessons table.
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Lessons_Select_ById]
			@Id int

/*---------Test Code------------

	Declare @Id int = 30;

	EXECUTE [dbo].[Lessons_Select_ById] @Id

*/

as

BEGIN


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

	  FROM [dbo].[Lessons] as l INNER JOIN [dbo].[LessonDuration] as ld
							ON l.[DurationTypeId] = ld.[Id]
	  WHERE l.[Id] = @Id


END



