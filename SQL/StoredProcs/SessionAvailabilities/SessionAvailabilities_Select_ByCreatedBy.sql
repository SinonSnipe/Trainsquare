USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionAvailabilities_Select_ByCreatedBy]    Script Date: 8/14/2022 12:36:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Returns a paginated selection of records from dbo.SessionAvailabilities thats filtered by creator
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
ALTER proc [dbo].[SessionAvailabilities_Select_ByCreatedBy]
						@pageIndex int
						,@pageSize int
						,@createdBy int


as

/*	
		Declare @pageIndex int = 0
				,@pageSize int = 10
				,@createdBy int = 14283

		Execute [dbo].[SessionAvailabilities_Select_ByCreatedBy]
						@pageIndex 
						,@pageSize
						,@createdBy

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
				,total = Count(1) Over()
		From dbo.SessionAvailabilities
		Where CreatedBy = @createdBy

		Order By Id
		Offset @offset Rows
		Fetch Next @pageSize Rows Only

END