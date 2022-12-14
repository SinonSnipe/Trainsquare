USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Sessions_Select_ByHostId]    Script Date: 8/14/2022 1:30:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [dbo].[Sessions_Select_ByHostId]
					@HostId int
					,@pageIndex int
					,@pageSize int

as

/*
		Declare @HostId int = 266
				,@pageIndex int = 0
				,@pageSize int = 10
		
		Execute dbo.Sessions_Select_ByHostId @HostId
											,@pageIndex
											,@pageSize

*/

BEGIN
Declare  @offset int = @pageIndex * @pageSize
Select   s.Id
		,w.ImageUrl
		,w.Name
		,s.[Date]
		,s.TotalSlots
		,s.OpenSlots
		,s.StartTime
		,s.EndTime
		,TotalCount = Count(*)Over()
		From dbo.Sessions as s inner join dbo.WorkShop as w
			on s.WorkShopId = w.Id
			inner join dbo.UserProfiles as u
				on u.UserId = s.CreatedBy
			inner join dbo.UserProfiles as up
				on up.UserId = s.ModifiedBy
		Where s.CreatedBy = @HostId
		Order by s.Date
END