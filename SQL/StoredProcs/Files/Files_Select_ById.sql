USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Files_Select_ById]    Script Date: 8/9/2022 4:20:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alan George
-- Create date: 3/23/22
-- Description:	Select By ID Proc for Files
-- Code Reviewer: Nathan Ortiz


-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================
ALTER proc [dbo].[Files_Select_ById]
						@Id int 

AS

/* TEST CODE
	
			Declare @Id int = 7
		
			Execute dbo.Files_Select_ById
						@Id 

*/

BEGIN

		  	 Select f.[Id]
					,[Url]
					,t.name as FileType
					,[CreatedBy]
					,[DateCreated]
					,[DateModified]

			 FROM [dbo].[Files] as f inner join [dbo].FileTypes as t
							on t.Id = f.FileTypeId
			 Where f.Id = @Id

END


