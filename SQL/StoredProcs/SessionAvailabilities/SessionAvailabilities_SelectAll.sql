USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionAvailabilities_SelectAll]    Script Date: 8/14/2022 12:36:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Returns a paginated selection from dbo.SessionAvailabilities
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
ALTER proc [dbo].[SessionAvailabilities_SelectAll]
						@pageIndex int
						,@pageSize int


as

/*	
		Declare @pageIndex int = 0
				,@pageSize int = 10

		Execute [dbo].[SessionAvailabilities_SelectAll]
						@pageIndex 
						,@pageSize

*/

BEGIN
		Declare @offset int = @pageIndex * @pageSize
		Select Id
				,SessionId
				,[DayOfWeek]
				,StartTime
				,EndTime
				,DateCreated
				,DateModified
				,CreatedBy
				,ModifiedBy
				,totalCount = Count(1) Over()
		From dbo.SessionAvailabilities
		Order By Id
		Offset @offset Rows
		Fetch Next @pageSize Rows Only

END