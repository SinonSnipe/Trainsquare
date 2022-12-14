USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShop_Insert]    Script Date: 8/15/2022 11:12:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/1/22,,>
-- Description: <Insert a WorkShop,,>
-- Code Reviewer: Jared Williams

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/1/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShop_Insert]
		@Id int OUTPUT
		,@Name nvarchar(255)
		,@Summary nvarchar(255)
		,@ShortDescription nvarchar(4000)
		,@VenueId int
		,@HostId int
		,@WorkShopTypeId int
		,@WorkShopStatusId int
		,@ImageUrl nvarchar(400)
		,@ExternalSiteUrl nvarchar(400)
		,@LanguageId int
		,@IsFree bit
		,@NumberOfSessions int
		,@DateStart datetime2
		,@DateEnd datetime2

/*
Declare @Id int = 0

	Declare @Name nvarchar(255) = 'Gaming'
			,@Summary nvarchar(255) = 'Learn to Game'
			,@ShortDescription nvarchar(4000) = 'This course will teach you everything about gaming'
			,@VenueId int = 5
			,@HostId int = 1
			,@WorkShopTypeId int = 4
			,@WorkShopStatusId int = 4
			,@ImageUrl nvarchar(400) = NULL
			,@ExternalSiteUrl nvarchar(400) = NULL
			,@LanguageId int = 4
			,@IsFree bit = 'false'
			,@NumberOfSessions int = 1
			,@DateStart datetime2 = '2022-04-02' 
			,@DateEnd datetime2 =  '2022-04-02'

	Execute dbo.WorkShop_Insert @Id OUTPUT
								,@Name 
								,@Summary 
								,@ShortDescription 
								,@VenueId 
								,@HostId 
								,@WorkShopTypeId 
								,@WorkShopStatusId
								,@ImageUrl 
								,@ExternalSiteUrl 
								,@LanguageId 
								,@IsFree 
								,@NumberOfSessions
								,@DateStart  
								,@DateEnd 

*/

as
BEGIN

	INSERT INTO dbo.WorkShop
		([Name] 
			,[Summary] 
			,[ShortDescription] 
			,[VenueId] 
			,[HostId] 
			,[WorkShopTypeID] 
			,[WorkShopStatusId] 
			,[ImageUrl] 
			,[ExternalSiteUrl] 
			,[LanguageId] 
			,[IsFree] 
			,[NumberOfSessions]
			,[DateStart] 
			,[DateEnd])
		VALUES
			(@Name
			,@Summary
			,@ShortDescription
			,@VenueId
			,@HostId
			,@WorkShopTypeId
			,@WorkShopStatusId
			,@ImageUrl
			,@ExternalSiteUrl
			,@LanguageId
			,@IsFree
			,@NumberOfSessions
			,@DateStart
			,@DateEnd)

		SET @Id = SCOPE_IDENTITY()

END