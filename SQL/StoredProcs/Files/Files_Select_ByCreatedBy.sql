USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Files_Select_ByCreatedBy]    Script Date: 8/9/2022 4:20:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 4/8/22
-- Description:	Select By Created By Proc for Files
-- Code Reviewer: Nathan Ortiz

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Files_Select_ByCreatedBy]
						@pageIndex int 
                        ,@pageSize int
						,@UserId int

AS

/* TEST CODE
	
			Declare @pageIndex int = 0
					,@pageSize int = 5
					,@UserId int = 8
		
			Execute dbo.Files_Select_ByCreatedBy
											@pageIndex 
											,@pageSize 
											,@UserId

*/

BEGIN

		Declare @offset int = @pageIndex * @pageSize

		SELECT f.[Id]
			  ,[Url]
			  ,t.Name as FileType
			  ,[CreatedBy]
			  ,[DateCreated]
			  ,[DateModified]
			  ,[TotalCount] = COUNT(1) OVER()

		FROM [dbo].[Files] as f inner join [dbo].FileTypes as t
							on t.Id = f.FileTypeId
		WHERE CreatedBy = @UserId
		ORDER BY id

		OFFSET @offset Rows
		Fetch Next @pageSize Rows ONLY

END


