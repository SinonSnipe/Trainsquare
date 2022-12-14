USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Select_ByEntityId]    Script Date: 8/9/2022 2:42:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/23/2022,,>
-- Description: <Select Comment by EntityId and EntityTypeId,,>
-- Code Reviewer: Changwoo Lee, Abel Amezcua

-- MODIFIED BY: Charles Oh
-- MODIFIED DATE:03/23/2022
-- Code Reviewer: Changwoo Lee, Abel Amezcua
-- Note:
-- =============================================


ALTER proc [dbo].[Comments_Select_ByEntityId]
				@EntityId int
				,@EntityTypeId int
				,@pageIndex int
				,@pageSize int

/*

	Declare @EntityId int = 7
			,@EntityTypeId int = 9
			,@pageIndex int = 0
			,@pageSize int = 5

	Execute [dbo].[Comments_Select_ByEntityId] @EntityId
											   ,@EntityTypeId
											   ,@pageIndex
											   ,@pageSize

*/
as
BEGIN

	DECLARE @offset int = @pageIndex * @pageSize

	CREATE TABLE #Primary_Comments (Id int
									,Subject nvarchar(50)
									,Text nvarchar(3000)
									,ParentId int
									,EntityTypeId int
									,EntityId int
									,DateCreated datetime2
									,DateModified datetime2
									,CreatedBy int
									,FirstName nvarchar(100)
									,Lastname nvarchar(100)
									,AvatarUrl nvarchar(300)
									,IsDeleted bit
									)
	INSERT INTO #Primary_Comments
		SELECT  c.Id
				,c.[Subject]
				,c.[Text]
				,c.ParentId
				,e.Id
				,c.EntityId
				,c.DateCreated
				,c.DateModified
				,up.UserId
				,up.FirstName
				,up.LastName
				,up.AvatarUrl
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
									,EntityTypeId int
									,EntityId int
									,DateCreated datetime2
									,DateModified datetime2
									,CreatedBy int
									,FirstName nvarchar(100)
									,Lastname nvarchar(100)
									,AvatarUrl nvarchar(300)
									,IsDeleted bit
									)

	INSERT INTO #Reply_Comments  
		SELECT  c.Id
				,c.[Subject]
				,c.[Text]
				,c.ParentId
				,e.Id
				,c.EntityId
				,c.DateCreated
				,c.DateModified
				,up.UserId
				,up.FirstName
				,up.LastName
				,up.AvatarUrl
				,c.IsDeleted
		FROM	dbo.Comments as c inner join [dbo].[EntityTypes] as e
					on c.EntityTypeId = e.Id
								  inner join [dbo].[UserProfiles] as up
					on c.CreatedBy = up.UserId

		Where c.ParentId > 0


	SELECT		 p.Id
				,p.[Subject]
				,p.[Text]
				,p.ParentId
				,e.Id
				,p.EntityId
				,p.DateCreated
				,p.DateModified
				,up.UserId 
				,up.FirstName
				,up.LastName
				,up.AvatarUrl
				,p.IsDeleted
				,Replies =( SELECT * FROM #Reply_Comments as rc 
							WHERE rc.ParentId = P.Id
							ORDER BY rc.Id DESC
							for JSON AUTO
							)
				,TotalCount = COUNT(1) OVER()

	FROM #Primary_Comments as p inner join [dbo].[EntityTypes] as e
					on p.EntityTypeId = e.Id
								inner join [dbo].[UserProfiles] as up
					on p.CreatedBy = up.UserId

	WHERE p.EntityId = @EntityId AND p.EntityTypeId = @EntityTypeId

	ORDER BY p.Id DESC
	OFFSET @offset Rows
	FETCH NEXT @pageSize Rows ONLY

	DROP Table #Primary_Comments
	DROP Table #Reply_Comments

END
