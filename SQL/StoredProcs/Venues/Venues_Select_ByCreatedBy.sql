USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_Select_ByCreatedBy]    Script Date: 8/14/2022 2:21:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jared Williams
-- Create date: 04/04/2022
-- Description: Select By CreatedBy(Pagination) proc for Venues
-- Code Reviewer:Sagan Jackson
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER proc [dbo].[Venues_Select_ByCreatedBy] 
				@User int
				,@pageIndex int 
				,@pageSize int 
				
as 
/*---Test Code---
Declare @User int = 562
		,@pageIndex int = 0
		,@pageSize int = 10
		
EXEC dbo.Venues_Select_ByCreatedBy 
		@User
		,@pageIndex
		  ,@pageSize
		  
*/
BEGIN 
Declare @offset int = @pageIndex * @pageSize 

		SELECT 
				v.Id 
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
			
				
		Where v.CreatedBy = @User
		ORDER BY v.CreatedBy

		OFFSET @offset ROWS
		FETCH NEXT @pageSize Rows ONLY
END
