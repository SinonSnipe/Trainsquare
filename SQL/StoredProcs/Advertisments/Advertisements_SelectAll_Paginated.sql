USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Advertisements_SelectAll_Paginated]    Script Date: 8/9/2022 2:19:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Charles, Steven
-- Create date: 20220401
-- Description: This SelectAll proc will return all the advertisements in a paginated format.
-- I have filtered 
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: Stephanie Zavala	
-- Note: Looks good
-- =============================================

ALTER Proc [dbo].[Advertisements_SelectAll_Paginated]

	  @Index int 
	 ,@PageSize int

/* ============== Test Code ==============
          
		    EXECUTE dbo.Advertisements_SelectAll_Paginated

  ======================================= */

AS

BEGIN

 DECLARE @offset int = @Index * @PageSize

SELECT A.[Id]
      ,WS.[Id]
      ,[OwnerId]
      ,[Title]
      ,[AdMainImage]
      ,[Details]
      ,A.[DateStart]
      ,A.[DateEnd]
	  ,Images = ( SELECT f.Url as Url
					FROM dbo.Files as f inner join dbo.AdImages as i
									ON f.Id = i.MediaId
					WHERE i.AdvertisementId = A.Id
					FOR JSON AUTO)
	  ,[TotalCount] = COUNT(1)OVER()
  FROM [dbo].[Advertisements] AS A inner join dbo.WorkShop AS WS
  ON A.WorkShopId = WS.Id 
  ORDER BY A.Id

  OFFSET @offset Rows
  Fetch Next @pageSize Rows ONLY

END