USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Advertisements_SelectByCreatedBy_Paginated]    Script Date: 8/9/2022 2:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Charles, Steven
-- Create date: 20220401
-- Description: This proc will return all records according to the Id of the user who created the advertisements
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: Stephanie Zavala
-- Note: What is the difference between Owner ID and Creadted By
-- =============================================


ALTER Proc [dbo].[Advertisements_SelectByCreatedBy_Paginated]

	  @Index int 
	 ,@PageSize int 
	 ,@CreatedBy int

/* ============== Test Code ==============

			DECLARE
						
		    @Index int = 0
		   ,@PageSize int = 5
		   ,@CreatedBy int = 3
           
		    EXECUTE dbo.Advertisements_SelectByCreatedBy_Paginated

		    @Index  
		   ,@PageSize 
		   ,@CreatedBy

  ======================================= */

AS

BEGIN

 DECLARE @offset int = @Index * @PageSize

SELECT A.[Id]
      ,WS.Summary as Workshop
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
  ORDER BY Id

  OFFSET @offset Rows
  Fetch Next @pageSize Rows ONLY

END