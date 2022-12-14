USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FileTypes_Update]    Script Date: 8/9/2022 4:20:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Update Proc for Files
-- Code Reviewer: Nathan Ortiz


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[FileTypes_Update]
					@Name nvarchar(50)
					,@Id int

AS

/* TEST CODE

			Declare @Name nvarchar(50) = 'JPG'
					,@Id int = 5

			Execute dbo.FileTypes_Select_ById @Id

			Execute dbo.FileTypes_Update
					 @Name
					,@Id

			Execute dbo.FileTypes_Select_ById @Id

*/

BEGIN

			UPDATE [dbo].[FileTypes]
			   SET [Name] = @Name

			WHERE Id = @Id

END


