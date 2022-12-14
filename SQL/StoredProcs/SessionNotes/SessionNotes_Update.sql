USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionNotes_Update]    Script Date: 8/14/2022 1:29:34 PM ******/
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
ALTER proc [dbo].[SessionNotes_Update]
				@Id int,
				@WorkshopName nvarchar(50),
				@TagsTypeId int,
				@Notes nvarchar(max),
				@SessionDate datetime2(7)

as

/*


Declare @Id int = 1,
		@WorkshopName nvarchar(50) = 'Test',
		@TagsTypeId int = 46,
		@Notes nvarchar(max) = 'Update Proc...',
		@SessionDate datetime2(7) = getutcdate()

		select * 
		from dbo.SessionNotes

		execute dbo.SessionNotes_Update
		@Id, 
		@WorkshopName,
		@TagsTypeId,
		@Notes,
		@SessionDate
		 


		select * 
		from dbo.SessionNotes
		where Id = @Id

*/

begin 

DECLARE @date datetime2 = getutcdate();

UPDATE dbo.SessionNotes
   SET WorkshopName = @WorkshopName
      ,TagsTypeId = @TagsTypeId
      ,Notes = @Notes 
      ,SessionDate = @SessionDate
 WHERE Id = @Id




end