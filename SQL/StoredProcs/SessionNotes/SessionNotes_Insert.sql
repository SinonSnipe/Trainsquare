USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionNotes_Insert]    Script Date: 8/14/2022 1:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Joseph Rayos
-- Create date: 
-- Description: Insert proc for Notes
-- Code Reviewer: Hauerlang
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER proc [dbo].[SessionNotes_Insert]
		@WorkshopName nvarchar(50),
		@TagsTypeId int, 
		@Notes nvarchar(max),
		@SessionDate datetime2(7),
		@ID int OUTPUT

as

/*

Declare @Id int;

Declare @WorkshopName nvarchar(50) = 'Master',
		@TagsTypeId int = 46,
		@Notes nvarchar(max) = 'Jedi Master',
		@SessionDate datetime2(7) = getutcdate()

		execute dbo.SessionNotes_Insert

		@WorkshopName,
		@TagsTypeId,
		@Notes,
		@SessionDate,
		@Id OUTPUT


		select * from dbo.SessionNotes

*/

BEGIN 

	INSERT INTO [dbo].[SessionNotes]
           (WorkshopName
           ,TagsTypeId
           ,Notes
           ,SessionDate)
     VALUES
           (@WorkshopName
           ,@TagsTypeId
           ,@Notes
           ,@SessionDate)
END 