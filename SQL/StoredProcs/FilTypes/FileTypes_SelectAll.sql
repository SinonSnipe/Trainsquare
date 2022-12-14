USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FileTypes_SelectAll]    Script Date: 8/9/2022 4:20:49 PM ******/
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

ALTER proc [dbo].[FileTypes_SelectAll]
						@pageIndex int 
                        ,@pageSize int

AS

/* TEST CODE
	
			Declare @pageIndex int = 0
					,@pageSize int = 5
		
			Execute FileTypes_SelectAll
						@pageIndex 
                        ,@pageSize 

*/

BEGIN

		Declare @offset int = @pageIndex * @pageSize

		SELECT [Id]
			  ,[Name]
			  ,[TotalCount] = COUNT(1) OVER()

		FROM [dbo].[FileTypes]
		ORDER BY id

		OFFSET @offset Rows
		Fetch Next @pageSize Rows ONLY

END


