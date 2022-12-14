USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_SelectAll]    Script Date: 8/10/2022 3:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description: Select all Messages - Paginated
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_SelectAll]
			@pageIndex int
			,@pageSize int

/*

	Declare @pageIndex int = 0
			,@pageSize int = 5

	Execute [dbo].[Messages_SelectAll] @pageIndex
										,@pageSize

*/

as
BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

		SELECT  [Id]
			,[Message]
			,[Subject]
			,[RecipientId]
			,[SenderId]
			,[DateSent]
			,[DateRead]
			,[DateCreated]
			,[DateModified]
			, TotalCount = COUNT(1) OVER()
	FROM	[dbo].[Messages]
	ORDER BY Id

		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY
	

END
