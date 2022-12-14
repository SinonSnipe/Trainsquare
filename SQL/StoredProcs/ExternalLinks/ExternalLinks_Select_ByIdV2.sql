USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[ExternalLinks_Select_ByIdV2]    Script Date: 8/9/2022 4:08:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================================================================================
-- Author: Jesus I. Vargas
-- Create date: 04/22/2022
-- Description: Select ExternalLink by Id Join with Data from Lookup Tables
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 
-- ============================================================================================================

ALTER PROC [dbo].[ExternalLinks_Select_ByIdV2]
				@Id int

/* ============================================================================================================

	Declare @Id int = 4

	Execute [dbo].[ExternalLinks_Select_ByIdV2] @Id

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
	WHERE	e.Id = @Id
END