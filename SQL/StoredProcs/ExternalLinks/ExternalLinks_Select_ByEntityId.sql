USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_Select_ByEntityId]    Script Date: 8/9/2022 4:08:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================================================
-- Author: Jesus I. Vargas
-- Create date: 04/23/2022
-- Description: Select ExternalLink by EntityId
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 
-- ============================================================================================================

ALTER PROC [dbo].[ExternalLinks_Select_ByEntityId]
				@EntityId int

/* ============================================================================================================

	Declare @EntityId int = 3

	Execute [dbo].[ExternalLinks_Select_ByEntityId] 
													@EntityId

============================================================================================================ */

AS
BEGIN
	SELECT  e.[Id]
			,u.[Id] AS "UserId"
			,usrProf.[FirstName] AS "User FirstName"
			,usrProf.[LastName] AS "User LastName"
			,usrProf.[AvatarUrl] AS "User Avatar"
			,urlType.[Id] AS "TypeId"
			,urlType.[Name] AS "Type"
			,e.[Url]
			,e.[EntityId]
			,eType.[Id] AS "EntityTypeId"
			,eType.[Name] AS "EntityType"
			,e.[DateCreated]
			,e.[DateModified]
	FROM	[dbo].[ExternalLinks] AS e INNER JOIN [dbo].[Users] AS u
							ON e.UserId = u.Id
						INNER JOIN [dbo].[UserProfiles] AS usrProf
							ON e.UserId = usrProf.UserId
						INNER JOIN [dbo].[UrlTypes] AS urlType
							ON e.UrlTypeId = urlType.Id
						INNER JOIN [dbo].[EntityTypes] AS eType
							ON e.EntityTypeId = eType.Id
	WHERE	e.[EntityId] = @EntityId

END