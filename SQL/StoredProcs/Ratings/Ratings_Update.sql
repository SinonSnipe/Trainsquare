USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Ratings_Update]    Script Date: 8/14/2022 11:58:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




	-- =============================================
	-- Author: Jake Lowrance
	-- Create date: 5/19/2022
	-- Description: Upadate Proc for Ratings
	-- Code Reviewer: Rafael Lynch

	-- MODIFIED BY:
	-- MODIFIED DATE:
	-- Code Reviewer:
	-- Note:
	-- =============================================



ALTER PROC [dbo].[Ratings_Update]
				@Id int
				,@Rating tinyint
				,@CommentId int
				,@EntityTypeId int
				,@EntityId int
				,@CreatedBy int
				,@IsDeleted bit

AS
	/* ----TEST CODE----
	
	DECLARE @Id int = 2

	DECLARE @Rating tinyint = 3
			,@CommentId int = 3
			,@EntityTypeId int = 2
			,@EntityId int = 5
			,@CreatedBy int = 1 
			,@IsDeleted bit = 1

	SELECT * FROM [dbo].[Ratings]
	WHERE Id = @Id

	EXECUTE [dbo].[Ratings_Update]
			@Id
			,@Rating
			,@CommentId
			,@EntityTypeId
			,@EntityId
			,@CreatedBy
			,@IsDeleted

	SELECT * FROM [dbo].[Ratings]
	WHERE Id = @Id

	*/


BEGIN

	DECLARE @DateNow datetime2 = getutcdate()

	UPDATE [dbo].[Ratings]
	   SET [Rating] = @Rating
		  ,[CommentId] = @CommentId
		  ,[EntityTypeId] = @EntityTypeId
		  ,[EntityId] = @EntityId
		  ,[DateModified] = @DateNow
		  ,[CreatedBy] = @CreatedBy
		  ,[IsDeleted] = @IsDeleted

	 WHERE Id = @Id


END