USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionNotes_SelectAll]    Script Date: 8/14/2022 1:29:31 PM ******/
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
ALTER proc [dbo].[SessionNotes_SelectAll]
			@PageIndex int
			,@PageSize int

as

/*
DECLARE		 @PageIndex int= 0
			,@PageSize int= 5

			
EXECUTE [dbo].[SessionNotes_SelectAll]
			 @PageIndex
			,@PageSize
*/

begin

DECLARE	@offset int =  @PageIndex * @PageSize

SELECT sn.Id as sessionNoteId,
		   sn.WorkshopName,
		   tt.Id as TagId,
		   tt.Name as TagName,
		   sn.Notes,
		   sn.SessionDate,
		   [TotalCount] = COUNT(1) OVER()

		   from dbo.SessionNotes as sn inner join dbo.TagsTypes as tt
		   on sn.TagsTypeId = tt.Id

		   order by sn.Id

		   
  OFFSET @offSet Rows
  Fetch Next @pageSize Rows ONLY

end 