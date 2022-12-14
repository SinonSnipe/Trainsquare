USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Select_ByLastMessageAllUsers]    Script Date: 8/10/2022 3:47:28 PM ******/
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


ALTER proc [dbo].[Messages_Select_ByLastMessageAllUsers]
			@activeUserId int
			,@pageIndex int
			,@pageSize int

/*

	Declare @activeUserId int = 261
			,@pageIndex int = 0
			,@pageSize int = 10

	Execute [dbo].[Messages_Select_ByLastMessageAllUsers] @activeUserId
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

		Join
			(select max(Id) As Id
					,userId
				from (
				(select Id
						  ,RecipientId AS [userId]
					from dbo.[Messages]
					Where SenderId = @activeUserId)
					UNION
					(select Id
							,SenderId AS [userId]
					from dbo.[Messages]
					Where RecipientId = @activeUserId)) AS t1
				Group By userId) AS t2
		on m.Id = t2.Id
	Order By m.Id desc

  	OFFSET @offset Rows
	FETCH NEXT @pageSize Rows ONLY
END
