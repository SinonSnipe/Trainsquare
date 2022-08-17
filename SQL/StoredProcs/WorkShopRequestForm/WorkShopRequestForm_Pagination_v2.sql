USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopRequestForm_Pagination_v2]    Script Date: 8/15/2022 12:08:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[WorkShopRequestForm_Pagination_v2]

    @pageIndex int
   ,@pageSize int

AS

/*-------TEST CODE--------



Declare @pageIndex int  = 0
      ,@pageSize int = 10
	  
	

Execute  [dbo].[WorkShopRequestForm_Pagination_v2] 
                       @pageIndex 
					   ,@pageSize 
					
					  

select *
From dbo.WorkShopRequestForm



*/


BEGIN

 Declare @offset int = @pageIndex * @pageSize

       
		SELECT InstructorId

     
	,Name
	  ,Email
      ,Topic
      ,ShortDescription
      ,DateCreated
      ,DateModified

  FROM [dbo].[WorkshopRequestForm] 
  --Where form.InstructorId = @HostId
		
	
		
		
        ORDER BY InstructorId

	OFFSET @offSet Rows
	Fetch Next @pageSize Rows ONLY











END