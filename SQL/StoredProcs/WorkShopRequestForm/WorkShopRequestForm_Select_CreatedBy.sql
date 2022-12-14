USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopRequestForm_Select_CreatedBy]    Script Date: 8/15/2022 12:08:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[WorkShopRequestForm_Select_CreatedBy]
			@Request int
			,@pageIndex int
			,@pageSize int

/*---------Test Code------------

	Declare 	@Request int = 19
			,@pageIndex int = 0
			,@pageSize int = 10

	EXECUTE [dbo].[WorkShopRequestForm_Select_CreatedBy]
				@Request
			,@pageIndex
			,@pageSize

*/

as

BEGIN


	Declare @offset int = @pageIndex * @pageSize;

SELECT  InstructorId
        ,Name
	  ,Email
      ,Topic
      ,ShortDescription
      ,DateCreated
      ,DateModified
	
 FROM [dbo].[WorkshopRequestForm]
  Where InstructorId = @Request
   ORDER BY [DateCreated]

	  OFFSET @offset Rows
	  FETCH NEXT @pageSize Rows ONLY


END