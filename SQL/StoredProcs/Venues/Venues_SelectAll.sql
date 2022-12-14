USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_SelectAll]    Script Date: 8/14/2022 2:21:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jared Williams
-- Create date: 04/04/2022
-- Description: Select All proc for Venues
-- Code Reviewer:Sagan Jackson
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER proc [dbo].[Venues_SelectAll] 
as
/*
EXEC dbo.Venues_SelectAll

*/
BEGIN
		SELECT v.Id 
			  ,v.Name 
			  ,v.Description 
			  ,v.LocationId
			  ,l.LineOne
			  ,l.City
			  ,l.Zip
			  ,v.Url
			  ,v.CreatedBy 
			  ,v.ModifiedBy 
			  ,v.DateCreated 
			  ,v.DateModified
			  ,v.ImageUrl
			  ,TotalCount = COUNT(1) OVER()
			   
		
		FROM dbo.Venues as v inner join dbo.Locations as l
				on v.LocationId = l.Id
			
				

END