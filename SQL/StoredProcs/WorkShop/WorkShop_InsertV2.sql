USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShop_InsertV2]    Script Date: 8/15/2022 11:12:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [dbo].[WorkShop_InsertV2]
		   @Id int OUTPUT,
		   @Name nvarchar(255),
           @Summary nvarchar(255),
           @ShortDescription nvarchar(4000),
           @VenueId int,
           @HostId int,
           @WorkShopTypeId int,
           @WorkShopStatusId int,
           @ImageUrl nvarchar(400),
           @ExternalSiteUrl nvarchar(400),
           @LanguageId int,
           @IsFree bit,
           @NumberOfSessions int,
           @DateCreated datetime2(7),
           @DateModified datetime2(7),
           @DateStart datetime2(7),
           @DateEnd datetime2(7)
		   
As
/*
Declare    @Id int = 0,
		   @Name nvarchar(255) = 'Badmitten Online',
           @Summary nvarchar(255) = 'Learn to play Badmitten online with your friends in the metaverse!',
           @ShortDescription nvarchar(4000) = 'two players hit a birdie back and forth until someone drops the birdie',
           @VenueId int = 42,
           @HostId int = 266,
           @WorkShopTypeId int = 1,
           @WorkShopStatusId int = 1,
           @ImageUrl nvarchar(400) = 'https://play-lh.googleusercontent.com/9_aLnlveE9feW7hGAWf-1ZrKTu2QOIpk7k7DgMbXRUfP9s68T-766Cn0BoT37OAZWGM=w412-h220-rw',
           @ExternalSiteUrl nvarchar(400) = NULL,
           @LanguageId int = 1,
           @IsFree bit = 0,
           @NumberOfSessions int = 4,
           @DateCreated datetime2(7) = getutcdate(),
           @DateModified datetime2(7) = getutcdate(),
           @DateStart datetime2(7) = '06/22/2022',
           @DateEnd datetime2(7) = '07/12/2022'

Execute dbo.WorkShop_InsertV2   
		   @Id,
		   @Name,
           @Summary,
           @ShortDescription,
           @VenueId,
           @HostId,
           @WorkShopTypeId,
           @WorkShopStatusId,
           @ImageUrl,
           @ExternalSiteUrl,
           @LanguageId,
           @IsFree,
           @NumberOfSessions,
           @DateCreated,
           @DateModified,
           @DateStart,
           @DateEnd

*/
Begin
INSERT INTO [dbo].[WorkShop]
           ([Name]
           ,[Summary]
           ,[ShortDescription]
           ,[VenueId]
           ,[HostId]
           ,[WorkShopTypeId]
           ,[WorkShopStatusId]
           ,[ImageUrl]
           ,[ExternalSiteUrl]
           ,[LanguageId]
           ,[IsFree]
           ,[NumberOfSessions]
           ,[DateCreated]
           ,[DateModified]
           ,[DateStart]
           ,[DateEnd])
     VALUES
           (@Name,
           @Summary,
           @ShortDescription, 
           @VenueId, 
           @HostId,
           @WorkShopTypeId, 
           @WorkShopStatusId, 
           @ImageUrl, 
           @ExternalSiteUrl, 
           @LanguageId,
           @IsFree, 
           @NumberOfSessions,
           @DateCreated, 
           @DateModified, 
           @DateStart, 
           @DateEnd) 

	SET @Id = SCOPE_IDENTITY()

End

