USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[CommentsAndReplies]    Script Date: 8/9/2022 2:42:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <04/19/2022,,>
-- Description: <Select Comment and Replies,>
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note:
-- =============================================


ALTER PROC [dbo].[CommentsAndReplies]
			@pageIndex int
			,@pageSize int

/*

	Declare @pageIndex int = 0
			,@pageSize int = 10

	EXECUTE [dbo].[CommentsAndReplies] @pageIndex
										,@pageSize

*/
as

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize;

	CREATE TABLE #Primary_Comments (Id int
									,Subject nvarchar(50)
									,Text nvarchar(3000)
									,ParentId int
									,EntityTypeId nvarchar(50)
									,EntityId int
									,DateCreated datetime2
									,DateModified datetime2
									,CreatedBy nvarchar(MAX)
									,IsDeleted bit
									)
	INSERT INTO #Primary_Comments
		SELECT  c.Id
				,c.[Subject]
				,c.[Text]
				,c.ParentId
				,e.[Name] as EntityType
				,c.EntityId
				,c.DateCreated
				,c.DateModified
				,CreatedBy = (select Id
									,FirstName
									,LastName
									,AvatarUrl
							from   dbo.UserProfiles
							WHERE  c.CreatedBy = up.Id
							for JSON AUTO)
				,c.IsDeleted
		FROM	dbo.Comments as c inner join [dbo].[EntityTypes] as e
					on c.EntityTypeId = e.Id
								  inner join [dbo].[UserProfiles] as up
					on c.CreatedBy = up.UserId
		WHERE	c.ParentId = 0

	CREATE TABLE #Reply_Comments	(Id int
									,Subject nvarchar(50)
									,Text nvarchar(3000)
									,ParentId int
									,EntityTypeId nvarchar(50)
									,EntityId int
									,DateCreated datetime2
									,DateModified datetime2
									,CreatedBy nvarchar(MAX)
									,IsDeleted bit
									)

	INSERT INTO #Reply_Comments  
		SELECT  c.Id
				,c.[Subject]
				,c.[Text]
				,c.ParentId
				,e.[Name] as EntityType
				,c.EntityId
				,c.DateCreated
				,c.DateModified
				,CreatedBy = (select Id
									 ,FirstName
									 ,LastName
									 ,AvatarUrl
								from   dbo.UserProfiles
								WHERE  c.CreatedBy = up.Id
								for JSON AUTO)
				,c.IsDeleted
		FROM	dbo.Comments as c inner join [dbo].[EntityTypes] as e
					on c.EntityTypeId = e.Id
								  inner join [dbo].[UserProfiles] as up
					on c.CreatedBy = up.UserId

		WHERE c.ParentId > 0


	SELECT		 p.Id
				,p.[Subject]
				,p.[Text]
				,p.ParentId
				,e.[Name] as EntityType
				,p.EntityId
				,p.DateCreated
				,p.DateModified
				,CreatedBy = (select Id
									 ,FirstName
									 ,LastName
									 ,AvatarUrl
								from   dbo.UserProfiles AS up
								WHERE p.CreatedBy = up.Id
								for JSON AUTO)
				,p.IsDeleted
				,Replies =( SELECT * FROM #Reply_Comments as rc 
							WHERE rc.ParentId = P.Id
							ORDER BY rc.Id DESC
							for JSON AUTO
							)
				, TotalCount = COUNT(1) OVER()

	FROM #Primary_Comments as p inner join [dbo].[EntityTypes] as e
					on p.EntityId = e.Id
								inner join [dbo].[UserProfiles] as up
					on p.CreatedBy = up.UserId

	ORDER BY  p.Id DESC
	OFFSET @offset Rows
	FETCH NEXT @pageSize Rows ONLY

	DROP Table #Primary_Comments
	DROP Table #Reply_Comments

END