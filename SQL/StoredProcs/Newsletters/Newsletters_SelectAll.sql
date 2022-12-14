USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Newsletters_SelectAll]    Script Date: 8/14/2022 11:44:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <05/10/2022>
-- Description:	<Newsletters SelectAll (Paginated) >
-- Code Reviewer: Elizabeth Phung


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

ALTER PROC [dbo].[Newsletters_SelectAll]

				@PageIndex int
				,@PageSize int
											


AS


/*

   DECLARE 
							@PageIndex int = 0, 
							@PageSize int = 10

   EXECUTE dbo.Newsletters_SelectAll

							@PageIndex,
							@PageSize
						

*/

BEGIN

   Declare @offset int = @PageIndex * @PageSize

SELECT 
			n.Id
			,n.TemplateId
			,n.Name
			,n.CoverPhoto
			,n.DateToPublish
			,n.DateToExpire
			,n.DateCreated
			,n.DateModified
			,n.CreatedBy
			,up.FirstName
			,up.LastName
			,up.AvatarUrl
			, TotalCount = COUNT (1) OVER() 

FROM [dbo].[Newsletters] as n inner join dbo.UserProfiles as up
  on up.UserId = n.CreatedBy

     --WHERE n.Id = @Id   
	
		ORDER BY Id

			OFFSET @offset Rows
			Fetch Next @PageSize Rows ONLY
			
  
END