USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Select_ByConversation]    Script Date: 8/10/2022 3:47:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 
-- Description: 
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_Select_ByConversation]
			@activeUserId int
			,@selectedUserId int
			,@pageIndex int
			,@pageSize int

/*

	Declare @activeUserId int = 267
			,@selectedUserId int = 13
			,@pageIndex int = 0
			,@pageSize int = 10

	Execute [dbo].[Messages_Select_ByConversation] @activeUserId
												,@selectedUserId
												,@pageIndex
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
			,ur.Email
			,m.SenderId
			,s.FirstName
			,s.LastName
			,s.AvatarUrl
			,us.Email
			,m.DateSent
			,m.DateRead
			,m.DateCreated
			,m.DateModified
			, TotalCount = COUNT(1) OVER()

	FROM	[dbo].[Messages] AS m Left JOIN dbo.UserProfiles AS r
								ON m.RecipientId = r.UserId
								Left JOIN dbo.UserProfiles AS s
								ON m.SenderId = s.UserId
								Left Join dbo.Users AS ur
								ON m.RecipientId = ur.Id
								Left Join dbo.Users AS us
								ON m.SenderId = us.Id

	WHERE (m.SenderId = @activeUserId AND m.RecipientId = @selectedUserId)
	OR (m.SenderId = @selectedUserId  AND m.RecipientId = @activeUserId)
	ORDER BY m.Id desc
				

		OFFSET @offset Rows
		FETCH NEXT @pageSize Rows ONLY
		

END
