USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_SelectAll_Paginated_V2]    Script Date: 8/14/2022 2:21:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Matthew Golben
-- Create date: 05/09/2022
-- Description: Full Venue information selction to include latitude and longitude data location data 
-- Code Reviewer: Jared Williams
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER   PROC [dbo].[Venues_SelectAll_Paginated_V2]
				@pageIndex int 
				,@pageSize int 

AS

/*
			DECLARE		
			@pageIndex int = 0,
			@pageSize int = 5


		EXEC dbo.Venues_SelectAll_Paginated_V2
				@pageIndex,
				@pageSize
*/

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize 


					SELECT v.Id 
							,v.Name 
							,Description 
							,lt.Name AS LocationType
							,LineOne
							,LineTwo
							,City
							,Zip
							,s.Name AS State 
							,Latitude
							,Longitude
							,Url
							,v.CreatedBy 
							,v.ModifiedBy 
							,v.DateCreated 
							,v.DateModified
							,ImageUrl
							,TotalCount = COUNT(1) OVER()

			   
								FROM dbo.Venues AS v
								INNER JOIN dbo.Locations AS l
								ON v.LocationId = l.Id

								INNER JOIN dbo.LocationTypes AS lt
								ON l.LocationTypeId = lt.Id

								INNER JOIN dbo.States AS s
								ON l.StateId = s.Id
				
				
		
		ORDER BY v.CreatedBy

		OFFSET @offset ROWS
		FETCH NEXT @pageSize Rows ONLY

END
