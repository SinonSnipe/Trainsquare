USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Files_Upload]    Script Date: 8/9/2022 4:20:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Insert Proc for File Uploads
-- Code Reviewer: 


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[Files_Upload]
					@Url nvarchar(255)
					,@FileType nvarchar(50)
					,@CreatedBy int
					,@Id int OUTPUT
					
AS

/* TEST CODE

			Declare @Url nvarchar(255) = 'https://notgoogle.com'
					,@FileType nvarchar(50) = 'file'
					,@CreatedBy int = 69
					,@Id int = 1 

			Execute dbo.Files_Upload
					 @Url
					,@FileType
					,@CreatedBy
					,@Id OUTPUT


			Select *
			From dbo.Files
			Where Id = @Id

			Select *
			From dbo.FileTypes

*/

BEGIN

			DECLARE @FileTypeId int = 0

			INSERT INTO dbo.FileTypes 
						([Name])
			SELECT LOWER(@FileType)
			WHERE NOT EXISTS (SELECT 1 
							  FROM [dbo].[FileTypes] 
							  WHERE [Name] = @FileType);

			SELECT @FileTypeId = Id 
			FROM dbo.FileTypes WHERE [Name] = @FileType	

			INSERT INTO [dbo].[Files]
					   ([Url]
					   ,[FileTypeId]
					   ,[CreatedBy])

			VALUES
					   (@Url
						,@FileTypeId
						,@CreatedBy)

			SET @Id = SCOPE_IDENTITY()

END


