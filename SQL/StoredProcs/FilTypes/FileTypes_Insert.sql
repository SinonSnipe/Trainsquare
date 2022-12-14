USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FileTypes_Insert]    Script Date: 8/9/2022 4:20:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Insert Proc for FileTypes
-- Code Reviewer: Nathan Ortiz


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[FileTypes_Insert]
						@Name nvarchar(50)
						,@Id int OUTPUT

AS

/* TEST CODE
	
			Declare @Name nvarchar(50) = 'TXT'
						,@Id int
		
			Execute dbo.FileTypes_Insert
						@Name
						,@Id OUTPUT

			Execute dbo.FileTypes_Select_ById @Id

*/


BEGIN

			INSERT INTO [dbo].[FileTypes]
					   ([Name])
			SELECT LOWER(@Name)
			WHERE NOT EXISTS ( SELECT 1 
								FROM [dbo].[FileTypes]
								WHERE [Name] = @Name);

			SET @id = SCOPE_IDENTITY()

END


