USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_Select_ByCreatedBy_V2]    Script Date: 8/14/2022 2:21:38 PM ******/
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
ALTER   proc [dbo].[Venues_Select_ByCreatedBy_V2] 
				@User int
				,@PageIndex int 
				,@PageSize int 
				
AS


/*---Test Code---


		DECLARE @User int = 260
				,@PageIndex int = 0
				,@PageSize int = 10
		
		EXEC dbo.Venues_Select_ByCreatedBy_V2
				@User
				,@PageIndex
				,@PageSize
		  

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
			
				
		WHERE v.CreatedBy = @User
		ORDER BY v.CreatedBy

		OFFSET @offset ROWS
		FETCH NEXT @pageSize Rows ONLY
END

