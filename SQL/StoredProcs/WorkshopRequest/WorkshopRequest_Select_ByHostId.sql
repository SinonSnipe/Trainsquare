USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRequest_Select_ByHostId]    Script Date: 8/15/2022 12:01:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [dbo].[WorkshopRequest_Select_ByHostId]
	@InstructorId int

as
/*=====Test Code======
Declare @InstructorId int = 10;

Execute dbo.WorkshopRequest_Select_ByHostId
*/
Begin

SELECT [InstructorId]
      ,[Name]
      ,[Email]
      ,[Topic]
      ,[BriefDescription]
      ,[DateCreated]
      ,[DateModified]
  FROM [dbo].[WorkShopRequest]

End


