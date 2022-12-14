USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Lessons_Update]    Script Date: 8/9/2022 4:35:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Nathan Ortiz
-- Create date: 03/24/2022
-- Description: Updates a single record from 
--				the Lessons table and returns
--				the Lesson Id. 
-- Code Reviewer: Abel Amezcua

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Lessons_Update]
		@Title nvarchar(50)
		,@Description nvarchar(500)
		,@DurationTypeId int
		,@ImageUrl nvarchar(150)
		,@FileUrl nvarchar(125)
		,@SortOrder int
		,@ModifiedBy int
		,@Id int

/*
	
	Declare @Id int = 30;

	
	EXECUTE [dbo].[Lessons_Select_ById] @Id

	Declare @Title nvarchar(50) = 'How Safe Are Your Scripts?'
		,@Description nvarchar(500) = 'Protect your users from web skimming or form jacking attacks, hence avoiding GDPR violations.'
		,@DurationTypeId int = 1
		,@ImageUrl nvarchar(150) = 'https://freesvg.org/img/Placeholder.png'
		,@FileUrl nvarchar(125) = 'https://file.url:/some/path'
		,@SortOrder int = 3
		,@ModifiedBy int = 6

	EXECUTE [dbo].[Lessons_Update]
		@Title 
		,@Description 
		,@DurationTypeId
		,@ImageUrl 
		,@FileUrl 
		,@SortOrder 
		,@ModifiedBy
		,@Id 

	EXECUTE [dbo].[Lessons_Select_ById] @Id

*/

as

BEGIN

	Declare @dateMod datetime2(7) = GETUTCDATE()


	UPDATE [dbo].[Lessons]
	   SET [Title] = @Title
		  ,[Description] = @Description
		  ,[DurationTypeId] = @DurationTypeId
		  ,[ImageUrl] = @ImageUrl
		  ,[FileUrl] = @FileUrl
		  ,[SortOrder] = @SortOrder
		  ,[ModifiedBy] = @ModifiedBy
		  ,[DateModified] = @dateMod
	 WHERE Id = @Id


 END


