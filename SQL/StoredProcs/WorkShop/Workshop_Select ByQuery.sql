USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Workshop_Select ByQuery]    Script Date: 8/15/2022 11:12:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Abel Amezcua
-- Create date: 04/28/2022
-- Description: workshop search
-- Code Reviewer: 
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[Workshop_Select ByQuery]
				@pageIndex int
				,@pageSize int
				,@Query nvarchar(100)
/* ------------------------------TEST----------------------------------

Declare @pageIndex int = 0;
Declare @pageSize int = 10;
Declare @Query nvarchar(100) = 'html';



Execute [dbo].[Workshop_Select ByQuery]	@pageIndex
										,@pageSize
										,@Query


*/

as



BEGIN




Declare @offset int = @pageIndex*@pageSize

	Select ws.[Id]
			,ws.[Name]
			,ws.[Summary]
			,ws.[ShortDescription]
			,ws.[VenueId]
			,u.Id
			,u.FirstName 
			,u.LastName
			,u.AvatarUrl
			,wst.Name as workShopType
			,wss.Name workShopStatus
			,ws.[ImageUrl]
			,ws.[ExternalSiteUrl]
			,ws.[LanguageId]
			,ws.[IsFree]
			,ws.[NumberOfSessions]
			,ws.[DateStart]
			,ws.[DateEnd]
			,ws.[DateCreated]
			,ws.[DateModified]
			,TotalCount = COUNT(1) OVER()

				FROM dbo.WorkShop as ws INNER JOIN dbo.Venues as v
						on ws.VenueId = v.Id
						INNER JOIN dbo.WorkShopStatus as wss
						on ws.WorkShopStatusId = wss.Id
						INNER JOIN dbo.WorkShopTypes as wst
						on ws.WorkShopTypeId = wst.Id
						INNER JOIN dbo.UserProfiles as u
						on ws.HostId = u.UserId

				Where (
						ws.[Name] LIKE '%' + @Query + '%' OR
						ws.[Summary] LIKE '%' + @Query + '%' OR
						ws.[ShortDescription] LIKE '%' + @Query + '%'  
						)

				Order by ws.Id
	Offset @offset Rows
	FETCH NEXT @pageSize Rows ONLY 



END