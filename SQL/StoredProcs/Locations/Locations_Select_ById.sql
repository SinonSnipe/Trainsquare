USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Locations_Select_ById]    Script Date: 8/9/2022 4:37:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--AUTHOR: FRANK VILARDI
--CREATE DATE: 3/24/2022
--DESCRIPTION: Locations could hold a variety of location based data. 
--The most obvious would be a valid Address, but it could also just hold a City/State combination or maybe just a zip code (which would imply we could have a State/City).
--Since we want the table to be flexible we need to have many of the columns Nullable.
--CODE REVIEWER: Changwoo Lee

--MODIFIED BY: Matthew Golben
--MODIFIED DATE: 4/10/2022
--CODE REVIEWER: Stephanie Zavala
--NOTE:
-- State Codes retrieved from https://www.iso.org/obp/ui/#iso:code:3166:AE
--SELECT FROM statements added for LocationTypeId, StateId, CreatedBy, and ModifedBy

ALTER PROC [dbo].[Locations_Select_ById]
		@Id int 

AS

/* ======= Test Code =======

	Declare @Id int = 5

	Execute dbo.Locations_Select_ById 
			@Id

*/

BEGIN

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
		WHERE l.Id = @Id

END


