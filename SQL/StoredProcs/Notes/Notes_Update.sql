USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Notes_Update]    Script Date: 8/14/2022 11:50:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Maria Quintana
-- Create date: 04/02/2022
-- Description: Update proc for Notes
-- Code Reviewer: Tawni M.
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER PROC [dbo].[Notes_Update]
			@Id int
           ,@Notes nvarchar(max)
		   ,@WorkShopId int
		   ,@TagsTypeId int
		   ,@DateModified datetime2(7)
		   --,@CreatedBy int
		   ,@ModifiedBy int
as
/*---TEST CODE---
DECLARE		@Id int = 124
           ,@Notes nvarchar(max) = 'Notes For Yoga WorkShop'
		   ,@WorkShopId int = 5
		   ,@TagsTypeId int = 46
		   ,@DateModified datetime2(7) = getutcdate()
		   ,@ModifiedBy int = 260
SELECT *
FROM dbo.Notes
WHERE Id = @Id

EXECUTE dbo.Notes_Update
				@Id
			   ,@Notes
			   ,@WorkShopId
			   ,@TagsTypeId
		       ,@DateModified
			   ,@ModifiedBy
SELECT *
FROM dbo.Notes
WHERE Id = @Id



EXECUTE [dbo].[Notes_Select_ById] @Id
		
*/
BEGIN
	DECLARE @date datetime2 = getutcdate();

	UPDATE dbo.Notes

	   SET 
		   Notes = @Notes
		  ,WorkShopId = @WorkShopId
		  ,TagsTypeId = @TagsTypeId
		  ,DateModified = @DateModified
		  ,ModifiedBy = @ModifiedBy

	WHERE Id = @Id


 END


