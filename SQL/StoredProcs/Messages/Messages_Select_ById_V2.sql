USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Select_ById_V2]    Script Date: 8/10/2022 3:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description: Select Message by Id
-- Code Reviewer: Shalene Brooks

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_Select_ById_V2]
				@Id int

/*

	Declare @Id int = 17

	Execute [dbo].[Messages_Select_ById_V2] @Id

*/

as
BEGIN

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

	FROM	[dbo].[Messages] AS m Left JOIN dbo.UserProfiles AS r
								ON m.RecipientId = r.UserId
								Left JOIN dbo.UserProfiles AS s
								ON m.SenderId = s.UserId
								Left Join dbo.Users AS ur
								ON m.RecipientId = ur.Id
								Left Join dbo.Users AS us
								ON m.SenderId = us.Id
	WHERE m.Id = @Id

END
