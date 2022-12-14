USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Notes_Insert]    Script Date: 8/14/2022 11:50:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Maria Quintana
-- Create date: 04/02/2022
-- Description: Insert proc for Notes
-- Code Reviewer: Tawni M.
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[Notes_Insert]
			
		    @Notes nvarchar(max)
		   ,@WorkShopId int
		   ,@TagsTypeId int
		   ,@DateCreated datetime2(7)
		   ,@CreatedBy int
		   ,@Id int OUTPUT
as
/*---TEST CODE--
DECLARE		@Id int;

DECLARE	    @Notes nvarchar(max) = 'TESTING'
		   ,@WorkShopId int = 5
		   ,@TagsTypeId int = 46
		   ,@DateCreated datetime2(7) = getutcdate()
		   ,@CreatedBy int = 260

EXECUTE dbo.Notes_Insert
				
			    @Notes
			   ,@WorkShopId
			   ,@TagsTypeId
			   ,@DateCreated
			   ,@CreatedBy
			   ,@Id OUTPUT

		   select *
		   from dbo.Notes


*/

BEGIN
	
	INSERT INTO [dbo].[Notes]
			(
			    Notes
			   ,WorkShopId
			   ,TagsTypeId
			   ,DateCreated
			   ,CreatedBy  
			   ,ModifiedBy)	
     VALUES
			   (
			    @Notes
			   ,@WorkShopId
			   ,@TagsTypeId
			   ,@DateCreated
			   ,@CreatedBy
			   ,@CreatedBy)

	SET @Id = SCOPE_IDENTITY()

END


