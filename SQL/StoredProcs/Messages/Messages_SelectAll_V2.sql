USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_SelectAll_V2]    Script Date: 8/10/2022 3:47:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description: Select all Messages - Paginated
-- Code Reviewer: Shalene Brooks

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_SelectAll_V2]
			@pageIndex int
			,@pageSize int

/*

	Declare @pageIndex int = 0
			,@pageSize int = 40

	Execute [dbo].[Messages_SelectAll_V2] @pageIndex
										,@pageSize

*/

as
BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

		SELECT  m.Id
			,m.Message
			,m.Subject
			,m.RecipientId
			,r.FirstName
			,r.LastName
			,r.AvatarUrl
			,m.SenderId
			,s.FirstName
			,s.LastName
			,s.AvatarUrl
			,m.DateSent
			,m.DateRead
			,m.DateCreated
			,m.DateModified
			, TotalCount = COUNT(1) OVER()
	
	FROM	[dbo].[Messages] AS m Left JOIN dbo.UserProfiles AS r
								ON m.RecipientId = r.UserId
								Left JOIN dbo.UserProfiles AS s
								ON m.SenderId = s.UserId
	ORDER BY m.Id

		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY
	

END
