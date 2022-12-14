USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Locations_Select_ByGeo]    Script Date: 8/9/2022 4:37:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Matthew Golben
-- Create date: 4/11/2022
-- Description: Procedure to retrieve instances in Locations table that are within the circular area of the specified point according to Latitude and Longitude.
--		NOTE: Radius is in Meters  
-- Code Reviewer: Stephanie Zavala

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


		ALTER   PROC [dbo].[Locations_Select_ByGeo]
				@Radius int
				,@Latitude float
				,@Longitude float

AS 

/* ========== Test Code ==========

		DECLARE @Radius int = 1000
				,@Latitude float = 25.1972
				,@Longitude float = 55.2745

		EXECUTE dbo.Locations_Select_ByGeo
				@Radius
				,@Latitude  
				,@Longitude
*/


BEGIN 

		DECLARE @point GEOGRAPHY = GEOGRAPHY::Point(@Latitude, @Longitude, 4326);

		SELECT l.Id      
		,lt.[Name] AS LocationType
		,LineOne
		,LineTwo
		,City
		,Zip
		,s.[Name] AS [State] 
		,Latitude
		,Longitude
		,l.DateCreated
		,l.DateModified
		,l.CreatedBy 
		,l.ModifiedBy

		FROM dbo.Locations AS l
		INNER JOIN dbo.Users AS u
		ON l.CreatedBy = u.Id
		INNER JOIN dbo.LocationTypes AS lt
		ON l.LocationTypeId = lt.Id
		INNER JOIN dbo.States AS s
		ON l.StateId = s.Id
		WHERE @point.STDistance(GEOGRAPHY::Point(Latitude, Longitude, 4326)) <= @Radius;



END
