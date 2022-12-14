USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[FileTypes_Select_ById]    Script Date: 8/9/2022 4:20:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Select By ID Proc for FileTypes
-- Code Reviewer:


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER proc [dbo].[FileTypes_Select_ById]
						@Id int 

AS

/* TEST CODE
	
			Declare @Id int = 2
		
			Execute dbo.FileTypes_Select_ById
						@Id 

*/

BEGIN

			Select [Id]
			   	   ,[Name]

			From dbo.FileTypes
			Where Id = @Id

END


