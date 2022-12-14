USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_SelectById]    Script Date: 8/14/2022 2:21:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jared Williams
-- Create date: 04/04/2022
-- Description: Select By Id proc for Venues
-- Code Reviewer:Sagan Jackson
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER proc [dbo].[Venues_SelectById] 
			@Id int 

as 
/*---Test Code---
Declare @Id int = 68

EXEC dbo.Venues_SelectById 
			@Id
*/
BEGIN 
		SELECT v.Id 
			  ,v.Name 
			  ,v.Description 
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
				inner join dbo.Users as u
					on v.CreatedBy = u.Id
				inner join dbo.Users
					on v.ModifiedBy = u.Id
				

		WHERE v.Id = @Id 
END
