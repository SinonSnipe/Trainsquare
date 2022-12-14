USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Locations_Select_ByCreatedBy]    Script Date: 8/9/2022 4:37:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--AUTHOR: FRANK VILARDI
--CREATE DATE: 3/24/2022
--DESCRIPTION: Locations could hold a variety of location based data. 
--The most obvious would be a valid Address, but it could also just hold a City/State combination or maybe just a zip code (which would imply we could have a State/City).
--Since we want the table to be flexible we need to have many of the columns Nullable.
--CODE REVIEWER: Elizabeth Phung

--MODIFIED BY: Matthew Golben
--MODIFIED DATE: 4/11/2022
--CODE REVIEWER: Stephanie Zavala
--NOTE:
--SELECT FROM statements added for LocationTypeId, StateId, and ModifedBy
--Modifications on JOIN with dbo.Users for retrieval of User.Id on CreatedBy


ALTER proc [dbo].[Locations_Select_ByCreatedBy] @pageIndex int
												,@pageSize int
												,@Id int
as

/*

		Declare @pageIndex int = 0
				,@pageSize int = 10

		Declare @Id int = 1

		Declare @offset int = @pageIndex * @pageSize


		Execute dbo.Locations_Select_ByCreatedBy @pageIndex
												,@pageSize
												,@Id
*/

BEGIN

Declare @offset int = @pageIndex * @pageSize

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
		,u.Id AS CreatedBy
		,l.ModifiedBy
		,TotalCount = COUNT(1) OVER()
	  

		FROM dbo.Locations AS l
		INNER JOIN dbo.Users AS u
		ON l.CreatedBy = u.Id
		INNER JOIN dbo.LocationTypes AS lt
		ON l.LocationTypeId = lt.Id
		INNER JOIN dbo.States AS s
		ON l.StateId = s.Id
		WHERE u.Id = @Id

		ORDER BY u.Id 
		OFFSET @offSet Rows
		FETCH NEXT @pageSize ROWS ONLY

  END
