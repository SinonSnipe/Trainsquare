USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Select_ByCreatedBy]    Script Date: 8/10/2022 3:47:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description: Select Message by CreatedBy - Paginated
-- Code Reviewer: Elizabeth Phung 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_Select_ByCreatedBy]
			@SenderId int
			,@pageIndex int
			,@pageSize int

/*

	Declare @SenderId int = 13
			,@pageIndex int = 0
			,@pageSize int = 10

	Execute [dbo].[Messages_Select_ByCreatedBy] @SenderId
												,@pageIndex
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
	WHERE SenderId = @SenderId
	ORDER BY Id
				

		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY
		

END
