USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Host_SelectWorkshop_ById]    Script Date: 8/9/2022 4:28:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   Proc [dbo].[Host_SelectWorkshop_ById]
		@HostId int
		

As
/*
Declare @HostId int = 266
		

Execute Host_SelectWorkshop_ById
		@HostId
	
*/
Begin

Select  ws.Id,
		ws.Name,
		ws.Summary,
		ws.ShortDescription,
		ws.VenueId,
		ws.HostId,
		ws.DateCreated,
		ws.DateModified,
		ws.WorkShopStatusId,
		ws.DateStart,
		ws.DateEnd,
		ws.ImageUrl,
		TotalCount = Count(*)Over()
		
  FROM [dbo].[WorkShop] as ws inner join dbo.Users as u 
	on ws.HostId = u.Id
  Where @HostId = ws.HostId
  Order by ws.Name


End