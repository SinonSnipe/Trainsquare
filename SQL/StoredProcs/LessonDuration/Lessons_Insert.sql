USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Lessons_Insert]    Script Date: 8/9/2022 4:34:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Nathan Ortiz
-- Create date: 03/24/2022
-- Description: Inserts a single record to the Lessons table
--				and returns the Id.
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Lessons_Insert] 
	@Title nvarchar(50)
	,@Description nvarchar(500)
	,@DurationTypeId int
	,@ImageUrl nvarchar(150)
	,@FileUrl nvarchar(125)
	,@SortOrder int
	,@CreatedBy int
	,@ModifiedBy int
	,@Id int OUTPUT



/* ---------Test Code------------

	Declare @Id int;

	Declare @Title nvarchar(50) = 'Surging DDoS Attacks During a Pandemic'
			,@Description nvarchar(500) = ''
			,@DurationTypeId int = 1
			,@ImageUrl nvarchar(150) = ''
			,@FileUrl nvarchar(125) = 'https://file.url:/some/path'
			,@SortOrder int = 4
			,@CreatedBy int = 1
			,@ModifiedBy int = 1
		

	EXECUTE [dbo].[Lessons_Insert] 
		@Title 
		,@Description 
		,@DurationTypeId
		,@ImageUrl 
		,@FileUrl 
		,@SortOrder 
		,@CreatedBy 
		,@ModifiedBy 
		,@Id OUTPUT

	EXECUTE [dbo].[Lessons_Select_ById] @Id


*/

as

BEGIN


	INSERT INTO [dbo].[Lessons]
			   ([Title]
			   ,[Description]
			   ,[DurationTypeId]
			   ,[ImageUrl]
			   ,[FileUrl]
			   ,[SortOrder]
			   ,[CreatedBy]
			   ,[ModifiedBy])
		 VALUES
			   (@Title
			   ,@Description
			   ,@DurationTypeId
			   ,@ImageUrl
			   ,@FileUrl
			   ,@SortOrder
			   ,@CreatedBy
			   ,@ModifiedBy)

	SET @Id = SCOPE_IDENTITY()
			   	   
			 
END





