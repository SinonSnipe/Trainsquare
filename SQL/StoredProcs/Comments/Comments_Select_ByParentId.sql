USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Select_ByParentId]    Script Date: 8/9/2022 2:42:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <04/12/2022,,>
-- Description: <Select Comment by ParentId (Meant to display reply comments)>
-- Code Reviewer: 

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER proc [dbo].[Comments_Select_ByParentId]
				@ParentId int

/*

	Declare @ParentId int = 3

	Execute [dbo].[Comments_Select_ByParentId] @ParentId

*/

as
BEGIN

	WITH	cte_commentsChildren as (

	SELECT  c.Id
			,c.[Subject]
			,c.[Text]
			,c.ParentId
			,e.[Name] as EntityType
			,c.EntityId
			,c.DateCreated
			,c.DateModified
			,c.CreatedBy
			,c.IsDeleted 
	FROM	dbo.Comments as c inner join dbo.EntityTypes as e
					on c.EntityTypeId = e.Id

	WHERE	ParentId = @ParentId

	UNION ALL 

	SELECT	c.Id
			,c.[Subject]
			,c.[Text]
			,c.ParentId
			,e.[Name] as EntityType
			,c.EntityId
			,c.DateCreated
			,c.DateModified
			,c.CreatedBy
			,c.IsDeleted 
	
	FROM	dbo.Comments as c inner join cte_commentsChildren as cc 
					on cc.Id = c.ParentId 
					inner join dbo.EntityTypes as e
					on c.EntityTypeId = e.Id
			)


	SELECT  Id,
			[Subject] ,
			[Text],
			[ParentId]
			
	FROM	cte_commentsChildren 
	WHERE	ParentId = @ParentId
	ORDER BY Id DESC

END


