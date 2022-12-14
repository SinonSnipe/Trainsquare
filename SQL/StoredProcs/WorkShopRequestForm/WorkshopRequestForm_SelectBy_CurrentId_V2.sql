USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRequestForm_SelectBy_CurrentId_V2]    Script Date: 8/15/2022 12:08:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   Proc [dbo].[WorkshopRequestForm_SelectBy_CurrentId_V2]
		@InstructorId int

As
/*
Declare @InstructorId int = 5

Execute dbo.WorkShopRequestForm_SelectBy_CurrentId @InstructorId

select *
from dbo.WorkShopRequestForm
*/
Begin
SELECT  InstructorId
        ,Name
	  ,Email
      ,Topic
      ,ShortDescription
      ,DateCreated
      ,DateModified
	
 FROM [dbo].[WorkshopRequestForm]
  Where InstructorId = @InstructorId
End