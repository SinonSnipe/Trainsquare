USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Files_Insert]    Script Date: 8/9/2022 4:20:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Insert Proc for Files
-- Code Reviewer: Nathan Ortiz


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================
ALTER proc [dbo].[Files_Insert]
					@Url nvarchar(255)
					,@FileTypeId int
					,@CreatedBy int
					,@Id int OUTPUT

AS

/* TEST CODE

			Declare @Url nvarchar(255) = 'https://notgoogle.com'
					,@FileTypeId int = 3
					,@CreatedBy int = 69
					,@Id int

			Execute dbo.Files_Insert
					 @Url
					,@FileTypeId 
					,@CreatedBy
					,@Id OUTPUT

			Select *
			From dbo.Files
			Where Id = @Id

*/

BEGIN

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


