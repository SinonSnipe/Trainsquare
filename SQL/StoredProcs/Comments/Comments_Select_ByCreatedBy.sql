USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Select_ByCreatedBy]    Script Date: 8/9/2022 2:41:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/23/2022,,>
-- Description: <Select Comment by CreatedBy - Paginated,,>
-- Code Reviewer: Changwoo Lee

-- MODIFIED BY: Charles Oh
-- MODIFIED DATE:03/23/2022
-- Code Reviewer: Changwoo Lee
-- Note:
-- =============================================


ALTER proc [dbo].[Comments_Select_ByCreatedBy]
			@CreatedBy int
			,@pageIndex int
			,@pageSize int

/*

	Declare @CreatedBy int = 2
			,@pageIndex int = 0
			,@pageSize int = 5

	Execute [dbo].[Comments_Select_ByCreatedBy] @CreatedBy
												,@pageIndex
												,@pageSize

*/

as
BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

		SELECT  c.[Id]
				,[Subject]
				,[Text]
				,[ParentId]
				,e.[Name] as EntityType
				,[EntityId]
				,[DateCreated]
				,[DateModified]
				,[CreatedBy]
				,[IsDeleted]
				, TotalCount = COUNT(1) OVER()
		FROM [dbo].[Comments] as c inner join [dbo].[EntityTypes] as e
							on c.EntityTypeId = e.Id
		WHERE CreatedBy = @CreatedBy
		ORDER BY c.Id DESC

	OFFSET @offset Rows
	FETCH NEXT @pageSize Rows ONLY

END
