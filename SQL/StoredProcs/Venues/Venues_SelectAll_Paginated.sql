USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_SelectAll_Paginated]    Script Date: 8/14/2022 2:21:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER proc [dbo].[Venues_SelectAll_Paginated]
				@pageIndex int 
				,@pageSize int 
as
/*
Declare			@pageIndex int = 0,
				@pageSize int = 5

EXEC dbo.Venues_SelectAll_Paginated
				@pageIndex,
				@pageSize
*/

BEGIN

	Declare @offset int = @pageIndex * @pageSize 

		SELECT 
				v.Id 
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

		
		FROM dbo.Venues as v 
		inner join dbo.Locations as l
		on v.LocationId = l.Id
				
				
		
		ORDER BY v.CreatedBy

		OFFSET @offset ROWS
		FETCH NEXT @pageSize Rows ONLY

END