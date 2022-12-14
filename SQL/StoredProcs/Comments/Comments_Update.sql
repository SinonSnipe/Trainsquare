USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Update]    Script Date: 8/9/2022 2:42:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/23/2022,,>
-- Description: <Update a Comment,,>
-- Code Reviewer: Changwoo Lee

-- MODIFIED BY: Charles Oh
-- MODIFIED DATE:03/23/2022
-- Code Reviewer: Changwoo Lee
-- Note:
-- =============================================


ALTER proc [dbo].[Comments_Update]
			@Id int
			,@Subject nvarchar(50)
			,@Text nvarchar(3000)
			,@ParentId int
			,@EntityTypeId int
			,@EntityId int
			,@CreatedBy int
			,@IsDeleted bit

/*

	Declare @Id int = 62
			,@Subject nvarchar(50) = 'updated'
			,@Text nvarchar(3000) = 'updated comment - ParentId 0'
			,@ParentId int = 0
			,@EntityTypeId int = 2
			,@EntityId int = 2
			,@CreatedBy int = 2
			,@IsDeleted bit = 0

	Execute [dbo].[Comments_Update] @Id
									,@Subject
									,@Text
									,@ParentId
									,@EntityTypeId
									,@EntityId
									,@CreatedBy
									,@IsDeleted

*/

as
BEGIN

	DECLARE @date datetime2 = getutcdate();

	UPDATE [dbo].[Comments]

		SET [Subject] = @Subject
			,[Text] = @Text
			,[ParentId] = @ParentId
			,[EntityTypeId] = @EntityTypeId
			,[EntityId] = @EntityId
			,[CreatedBy] = @CreatedBy
			,[IsDeleted] = @IsDeleted

		WHERE Id = @Id

END
