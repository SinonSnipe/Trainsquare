USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopRequestForm_Select_BySearch]    Script Date: 8/15/2022 12:08:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[WorkShopRequestForm_Select_BySearch]
		@Query nvarchar(100)
		,@pageIndex int
		,@pageSize int

/*

---------Test Code------------
	DECLARE @Query nvarchar(100) = 'anime';
	
	DECLARE @pageIndex int = 0;
	DECLARE @pageSize int = 20;

	Execute [dbo].[WorkShopRequestForm_Select_BySearch] @Query
		,@pageIndex
		,@pageSize

		select *
		from dbo.WorkShopRequestForm
*/

as 

BEGIN

	Declare @offset int = @pageIndex * @pageSize

	SELECT  InstructorId
        ,Name
	  ,Email
      ,Topic
      ,ShortDescription
      ,DateCreated
      ,DateModified
	
 FROM [dbo].[WorkshopRequestForm]
  


	  WHERE ([Topic] LIKE '%' + @Query + '%' or [ShortDescription] 
				LIKE '%' + @Query + '%')
   ORDER BY [DateCreated]
		

		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY;

END




