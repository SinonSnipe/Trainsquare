USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Comments_Insert]    Script Date: 8/9/2022 2:41:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/23/2022,,>
-- Description: <Insert new Comment,,>
-- Code Reviewer: Changewoo Lee

-- MODIFIED BY: Charles Oh
-- MODIFIED DATE:03/23/2022
-- Code Reviewer: Changewoo Lee
-- Note:
-- =============================================


ALTER proc [dbo].[Comments_Insert]
			@Id int OUTPUT
			,@Subject nvarchar(50)
			,@Text nvarchar(3000)
			,@ParentId int
			,@EntityTypeId int
			,@EntityId int
			,@CreatedBy int
			,@IsDeleted bit

/*

	Declare @Id int
			,@Subject nvarchar(50) = 'Comment'
			,@Text nvarchar(3000) = 'This is my Comment'
			,@ParentId int = 1
			,@EntityTypeId int = 1
			,@EntityId int = 1
			,@CreatedBy int = 1
			,@IsDeleted bit = 'false'

	Execute [dbo].[Comments_Insert] @Id OUTPUT
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

	INSERT INTO  [dbo].[Comments] 
				([Subject]
				,[Text]
				,[ParentId]
				,[EntityTypeId]
				,[EntityId]
				,[CreatedBy]
				,[IsDeleted])
		VALUES
				(@Subject
				,@Text
				,@ParentId
				,@EntityTypeId
				,@EntityId
				,@CreatedBy
				,@IsDeleted)

		SET		@Id = SCOPE_IDENTITY()

END
