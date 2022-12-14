USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Notes_SelectBy_HostId]    Script Date: 8/14/2022 11:50:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   Proc [dbo].[Notes_SelectBy_HostId]
				@HostId int,
				@pageSize int,
				@pageIndex int

As
/*
Declare @HostId int = 266,
		@pageSize int = 10,
		@pageIndex int = 0

Execute dbo.Notes_SelectBy_HostId
		@HostId,
		@pageSize,
		@pageIndex
*/
Begin

DECLARE @offset int = @pageIndex * @pageSize
Select
						 n.Id as noteId
						,n.Notes
						,n.WorkShopId
						,ws.ImageUrl
						,t.Id as tagId
						,t.Name as tagName
						,n.DateCreated
						,n.DateModified
						,n.CreatedBy as HostId
						,n.ModifiedBy
						,[TotalCount] = COUNT(1) OVER()

					FROM dbo.WorkShop   AS ws INNER JOIN dbo.Notes AS n
										ON ws.Id = n.WorkShopId
										INNER JOIN dbo.TagsTypes AS t
										ON n.TagsTypeId = t.Id
			  WHERE n.CreatedBy = @HostId
			  ORDER BY CreatedBy

End