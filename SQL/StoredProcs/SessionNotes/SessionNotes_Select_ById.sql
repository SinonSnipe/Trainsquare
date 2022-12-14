USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionNotes_Select_ById]    Script Date: 8/14/2022 1:29:28 PM ******/
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
ALTER proc [dbo].[SessionNotes_Select_ById]
			@Id int

as

/*
Declare @Id int = 1

execute dbo.SessionNotes_Select_ById @Id


*/

begin

	SELECT sn.Id as sessionNoteId,
		   sn.WorkshopName,
		   tt.Id as TagId,
		   tt.Name as TagName,
		   sn.Notes,
		   sn.SessionDate,
		   [TotalCount] = COUNT(1) OVER()

		   from dbo.SessionNotes as sn inner join dbo.TagsTypes as tt
		   on sn.TagsTypeId = tt.Id

		   where sn.Id = @Id
		   order by sn.Id


end