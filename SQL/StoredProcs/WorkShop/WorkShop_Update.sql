USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShop_Update]    Script Date: 8/15/2022 11:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/1/22,,>
-- Description: <Update WorkShop,,>
-- Code Reviewer: Jared Williams

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/1/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShop_Update]
			@Id int 
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
	Declare @Id int = 1
			,@Name nvarchar(255) = ''
			,@Summary nvarchar(255) = ''
			,@ShortDescription nvarchar(4000) = ''
			,@VenueId int =
			,@HostId int =
			,@WorkShopTypeId int =
			,@WorkShopStatusId int =
			,@ImageUrl nvarchar(400) = ''
			,@ExternalSiteUrl nvarchar(400) = ''
			,@LanguageId int =
			,@IsFree bit =
			,@NumberOfSessions
			,@DateStart datetime2 =
			,@DateEnd datetime2 = 

	Execute dbo.WorkShop_Update 
			@Id 
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


	UPDATE dbo.WorkShop
	SET		[Name] = @Name
			,[Summary] = @Summary
			,[ShortDescription] =@ShortDescription
			,[VenueId] = @VenueId
			,[HostId] = @HostId
			,[WorkShopTypeID] = @WorkShopTypeId
			,[WorkShopStatusId] = @WorkShopStatusId
			,[ImageUrl] = @ImageUrl
			,[ExternalSiteUrl] = @ExternalSiteUrl
			,[LanguageId] = @LanguageId			
			,[IsFree] = @IsFree
			,[NumberOfSessions] = @NumberOfSessions
			,[DateStart] = @DateStart
			,[DateEnd] = @DateEnd

	WHERE Id = @Id 

END