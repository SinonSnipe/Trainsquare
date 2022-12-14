USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Select_ById]    Script Date: 8/9/2022 2:42:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/23/2022,,>
-- Description: <Select Comment by Id,,>
-- Code Reviewer: Changewoo Lee

-- MODIFIED BY: Charles Oh
-- MODIFIED DATE:03/23/2022
-- Code Reviewer: Changewoo Lee
-- Note:
-- =============================================


ALTER proc [dbo].[Comments_Select_ById]
				@Id int

/*

	Declare @Id int = 5

	Execute [dbo].[Comments_Select_ById] @Id

*/

as
BEGIN

	SELECT  c.[Id]
			,c.[Subject]
			,c.[Text]
			,c.[ParentId]
			,e.[Name] as EntityType
			,c.[EntityId]
			,c.[DateCreated]
			,c.[DateModified]
			,c.[CreatedBy]
			,c.[IsDeleted]
	FROM	[dbo].[Comments] as c inner join [dbo].[EntityTypes] as e
							 on c.EntityTypeId = e.Id
	WHERE	c.Id = @Id

END
