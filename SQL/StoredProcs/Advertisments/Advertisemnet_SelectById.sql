USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Advertisements_SelectById]    Script Date: 8/9/2022 2:19:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Charles, Steven
-- Create date: 20220401
-- Description: This SelectById proc is selecting the Id of the 
-- Advertisement that matches the workshop being held by the User. 
-- I have also implemented joins in order to be return the actual Owners email and the workshop the owner is hosting.
-- Code Reviewer:

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: Stephanie Zavala	
-- Note: looks good
-- =============================================


ALTER Proc [dbo].[Advertisements_SelectById]

	   @Id int 

/* ============== Test Code ==============

			DECLARE @Id int = 8;
          
		    EXECUTE dbo.Advertisements_SelectById @Id

  ======================================= */

AS

BEGIN

SELECT A.[Id]
      ,WS.Summary as Workshop
      ,[OwnerId]
      ,[Title]
      ,[AdMainImage]
      ,[Details]
      ,A.[DateStart]
      ,A.[DateEnd]
	  ,Images = ( SELECT f.Id as Id
						,f.Url as Url
					FROM dbo.Files as f inner join dbo.AdImages as i
									ON f.Id = i.MediaId
					WHERE i.AdvertisementId = A.Id
					FOR JSON AUTO)
	 
  FROM [dbo].[Advertisements] AS A inner join dbo.WorkShop AS WS
  ON A.WorkShopId = WS.Id 
  WHERE @Id = A.Id

END