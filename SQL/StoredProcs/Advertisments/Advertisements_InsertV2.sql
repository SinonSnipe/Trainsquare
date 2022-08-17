USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Advertisements_InsertV2]    Script Date: 8/9/2022 2:19:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Charles, Steven
-- Create date: 20220401
-- Description: This proc includes a UDT that is adding multiple Image URL's 
-- into the Files table because Advertisements can have more than just one image per Ad.
-- Once those Advertisement and the image is created the Ids for both the Ad and the Images 
-- are captured inside of the AdImages composite table.
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: Stephanie Zavala
-- Note: Potentially incorporate owner/user name into createdBy
-- =============================================

ALTER Proc [dbo].[Advertisements_InsertV2]
@MediaFiles [dbo].[MediaTable] READONLY
				
           
			,@AdId int OUTPUT
			,@WorkShopId int
			,@OwnerId int
			,@Title nvarchar(100)
			,@AdMainImage nchar(400)
			,@Details nvarchar(MAX)
			,@CreatedBy int
			,@DateStart datetime2(7)
            ,@DateEnd datetime2(7)
					

/*

	DECLARE @MediaFiles [dbo].[MediaTable]

	INSERT INTO @MediaFiles (Url,FileTypeId, CreatedBy)
	VALUES('https://bit.ly/3NrdMsz', 2, 2)

	INSERT INTO @MediaFiles (Url,FileTypeId, CreatedBy)
	VALUES('https://bit.ly/3uu7b7S', 2, 3)
			 DECLARE 

			 @Id int = 1
			,@WorkShopId int = 3
			,@OwnerId int = 2
			,@Title nvarchar(100) = 'This is a test'
			,@AdMainImage nchar(400) = 'kasjfkljasdkl;fjlksdjlkfj'
			,@Details nvarchar(MAX) = 'jaklsdjflkajsdkljlkj'
			,@CreatedBy int = 2
            ,@DateStart datetime2(7) = GETDATE()
            ,@DateEnd datetime2(7) = GETDATE()
			
			EXECUTE dbo.Advertisements_InsertV2

			 @MediaFiles
			,@Id OUTPUT
			,@WorkShopId 
			,@OwnerId 
			,@Title 
			,@AdMainImage
			,@Details 
			,@CreatedBy 
			
            ,@DateStart 
            ,@DateEnd 
			

			SELECT

			 A.Title
			,A.AdMainImage
			,A.Details
			,A.CreatedBy
			,F.Url
			,F.FileTypeId


			FROM dbo.Advertisements AS A
			inner join dbo.Files As F
			ON A.Id = F.Id


*/

AS

BEGIN

DECLARE @FileId int = 0

INSERT INTO dbo.Files (Url, FileTypeId, CreatedBy)
SELECT m.Url, m.FileTypeId, m.CreatedBy
FROM @MediaFiles as m
WHERE NOT EXISTS (
					SELECT 1
					FROM dbo.Files as f
					WHERE f.Url = m.Url)

-- The 'WHERE NOT EXISTS' clause will allow me to insert records that DO NOT exists inside of the Files table.

EXECUTE dbo.Advertisements_Inserts
			
			 @AdId OUTPUT
			,@WorkShopId 
			,@OwnerId 
			,@Title 
			,@AdMainImage
			,@Details 
			,@CreatedBy 
            ,@DateStart
            ,@DateEnd 
			
			INSERT INTO dbo.AdImages(AdvertisementId, MediaId)
			SELECT @AdId, f.Id
			FROM @MediaFiles as m inner join dbo.Files as f
					ON m.Url = f.Url

			

-- Once the AdId is created, it is inserted into the AdImages tables under the AdvertisementId and the Id from the MediaFiles(UDT) is inserted into the MediaId from the AdImages table.
-- Where the URL from MediaFiles matches the URL from the Files table, there is an Id that is associated that is passed to the MediaId column in the AdImages table.
END



