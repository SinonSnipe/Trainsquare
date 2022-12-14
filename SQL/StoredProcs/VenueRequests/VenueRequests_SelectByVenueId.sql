USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[VenueRequests_SelectByVenueId]    Script Date: 8/14/2022 2:19:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Allen La Rosa>
-- Create date: <5/19/2022>
-- Description: <Select VenueRequest by VenueId>
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[VenueRequests_SelectByVenueId]
											@VenueId int
										   ,@pageIndex int
										   ,@pageSize int
as

/*


	Declare @VenueId int = 99
	       ,@pageIndex int = 0
		   ,@pageSize int = 10

	Execute dbo.VenueRequests_SelectByVenueId
											@VenueId
										   ,@pageIndex
										   ,@pageSize
*/

BEGIN
	Declare @offset int = @pageIndex * @pageSize
	SELECT [Id] 
	      ,[VenueId]
		  ,[EventDescription]
		  ,[StartDate]
		  ,[EndDate]
		  ,[Requester]
		  ,TotalCount = COUNT(1) OVER()

	  FROM dbo.VenueRequests

	  WHERE VenueId = @VenueId

	  ORDER BY VenueId
	  OFFSET @offset ROWS
	  FETCH NEXT 100 Rows ONLY
	  

END



