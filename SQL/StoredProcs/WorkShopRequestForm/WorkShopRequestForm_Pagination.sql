USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopRequestForm_Pagination]    Script Date: 8/15/2022 12:08:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[WorkShopRequestForm_Pagination]

    @Index int
   ,@PageSize int

AS

/*-------TEST CODE--------



Declare @Index int  = 0
      ,@PageSize int = 10
	  
	

Execute  [dbo].[WorkShopRequestForm_Pagination] 
                       @Index 
					   ,@pageSize 
					
					  

select *
From dbo.WorkShopRequestForm



*/


BEGIN

 Declare @offset int = @Index * @pageSize

       
		SELECT form.InstructorId

     
	  ,up.FirstName
	  ,up.LastName
	  ,u.Email
      ,form.Topic
      ,form.ShortDescription
      ,form.DateCreated
      ,form.DateModified

  FROM [dbo].[WorkshopRequestForm] as form inner join users as u
										on form.InstructorId = u.Id
									  inner join UserProfiles as up
										on u.Id = up.UserId
  --Where form.InstructorId = @HostId
		
	
		
		
        ORDER BY InstructorId

	OFFSET @offSet Rows
	Fetch Next @pageSize Rows ONLY











END