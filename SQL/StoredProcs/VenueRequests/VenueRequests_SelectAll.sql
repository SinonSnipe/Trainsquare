USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[VenueRequests_SelectAll]    Script Date: 8/14/2022 2:19:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Allen La Rosa>
-- Create date: <5/19/2022>
-- Description: <GET ALL VenueRequests>
-- Code Reviewer: Rafael Lynch

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[VenueRequests_SelectAll]
			@pageIndex int
		   ,@pageSize int

as


/*
	Declare @pageIndex int = 0,
	        @pageSize int = 10
	Execute dbo.VenueRequests_SelectAll
										@pageIndex	
									   ,@pageSize

*/


BEGIN

	Declare @offset int = @pageIndex * @pageSize

	SELECT vr.Id
	      ,vr.VenueId
		  ,vr.EventDescription
		  ,vr.StartDate
		  ,vr.EndDate
		  ,vr.Requester
		  ,TotalCount = COUNT(1) OVER()
	  
	  FROM [dbo].[VenueRequests] as vr
			inner join dbo.Venues as v 
			on vr.VenueId = v.Id

	  ORDER BY VenueId
	  OFFSET @offset ROWS
	  FETCH NEXT @pageSize Rows ONLY

END





