USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Advertisements_Update]    Script Date: 8/9/2022 2:19:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Charles, Steven
-- Create date: 20220401
-- Description: This proc is for making any necessary updates to current records.
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: Stephanie Zavala
-- Note: Agreed that a batch update is not necessary as only 1 thing might change
-- =============================================



ALTER Proc [dbo].[Advertisements_Update]

            @Id int OUTPUT
           ,@WorkShopId int
           ,@OwnerId int
           ,@Title nvarchar(100)
           ,@AdMainImage nvarchar(400)
           ,@Details nvarchar(MAX)
		   ,@CreatedBy int
		   ,@DateStart datetime2(7)
		   ,@DateEnd datetime2(7)
          

/* ============== Test Code ==============

			DECLARE	
			
		    @Id int = 1
           ,@WorkShopId int = 3
           ,@OwnerId int = 2
           ,@Title nvarchar(100) = 'This record has been updated'
           ,@AdMainImage nvarchar(400) = 'https://bit.ly/3qAF0TO'
           ,@Details nvarchar(MAX) = 'Record was successfully updated'
		   ,@CreatedBy int = 2
		   ,@DateStart datetime2(7) = '2022-01-06T13:00:00'
		   ,@DateEnd datetime2(7) = '2022-01-06T10:00:00'
           

		   SELECT Id, WorkShopId, OwnerId, Title, AdMainImage, Details, CreatedBy
		   FROM dbo.Advertisements
		   WHERE Id = @Id

		   EXECUTE dbo.Advertisements_Update

		    @Id OUTPUT
           ,@WorkShopId 
           ,@OwnerId 
           ,@Title 
           ,@AdMainImage 
           ,@Details
		   ,@CreatedBy
		   ,@DateStart
		   ,@DateEnd
          

		   SELECT @Id

		   SELECT Id, WorkShopId, OwnerId, Title, AdMainImage, Details, CreatedBy
		   FROM dbo.Advertisements
		   WHERE Id = @Id


  ======================================= */

AS

BEGIN

DECLARE @DATENOW DATETIME2 = GETDATE()

UPDATE [dbo].[Advertisements]
   SET [WorkShopId] = @WorkShopId
      ,[OwnerId] = @OwnerId
      ,[Title] = @Title
      ,[AdMainImage] = @AdMainImage
      ,[Details] = @Details
	  ,[CreatedBy] = @CreatedBy
      ,[DateStart] = @DateStart
      ,[DateEnd] = @DateEnd

 WHERE @Id = Id

END