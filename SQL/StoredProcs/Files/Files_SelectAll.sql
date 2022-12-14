USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Files_SelectAll]    Script Date: 8/9/2022 4:20:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Select All Proc for Files
-- Code Reviewer:Nathan Ortiz


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Files_SelectAll]
						@pageIndex int 
                        ,@pageSize int

AS

/* TEST CODE
	
			Declare @pageIndex int = 0
					,@pageSize int = 5
		
			Execute dbo.Files_SelectAll
						@pageIndex 
                        ,@pageSize 

*/

BEGIN

		Declare @offset int = @pageIndex * @pageSize

		SELECT F.[Id]
			  ,[Url]
			  ,t.Name as FileType
			  ,[CreatedBy]
			  ,[DateCreated]
			  ,[DateModified]
			  ,[TotalCount] = COUNT(1) OVER()

		FROM [dbo].[Files] as f inner join [dbo].FileTypes as t
							on t.Id = f.FileTypeId
		ORDER BY id

		OFFSET @offset Rows
		Fetch Next @pageSize Rows ONLY

END


