USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Advertisements_Inserts]    Script Date: 8/9/2022 2:19:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Charles, Steven
-- Create date: 20220401
-- Description: This is simple Insert proc that inserts the values inside of the advertisements table.
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: Stephanie Zavala
-- Note: Looks good
-- =============================================


ALTER Proc [dbo].[Advertisements_Inserts]


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

			@Id int = 0
           ,@WorkShopId int = 7
           ,@OwnerId int = 1
           ,@Title nvarchar(100) = 'This is going to be a test'
           ,@AdMainImage nvarchar(400) = 'https://bit.ly/3ufCTFI'
           ,@Details nvarchar(MAX) = 'Test for advertisements'
		   ,@CreatedBy int = 2
           ,@DateStart datetime2(7) = GETDATE()
           ,@DateEnd datetime2(7) = GETDATE()

		    EXECUTE dbo.Advertisements_Inserts

			@Id OUTPUT
		   ,@WorkShopId
           ,@OwnerId
           ,@Title
           ,@AdMainImage
           ,@Details
		   ,@CreatedBy
           ,@DateStart
           ,@DateEnd

		   SELECT Id, WorkshopId, OwnerId, Title, AdMainImage, Details, CreatedBy 
		   FROM dbo.Advertisements

  ======================================= */

As

Begin

INSERT INTO [dbo].[Advertisements]
           ([WorkShopId]
           ,[OwnerId]
           ,[TItle]
           ,[AdMainImage]
           ,[Details]
		   ,[CreatedBy]
          
           ,[DateStart]
           ,[DateEnd])
     VALUES
           (@WorkShopId
           ,@OwnerId
           ,@Title
           ,@AdMainImage
           ,@Details
		   ,@CreatedBy
           ,@DateStart
           ,@DateEnd)

	  SET @Id = SCOPE_IDENTITY()

End