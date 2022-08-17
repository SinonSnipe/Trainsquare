USE [Trainsquare]
GO

/****** Object:  Table [dbo].[WorkShop]    Script Date: 8/15/2022 4:49:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkShop](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Summary] [nvarchar](255) NOT NULL,
	[ShortDescription] [nvarchar](4000) NOT NULL,
	[VenueId] [int] NULL,
	[HostId] [int] NOT NULL,
	[WorkShopTypeId] [int] NOT NULL,
	[WorkShopStatusId] [int] NOT NULL,
	[ImageUrl] [nvarchar](400) NULL,
	[ExternalSiteUrl] [nvarchar](400) NULL,
	[LanguageId] [int] NOT NULL,
	[IsFree] [bit] NOT NULL,
	[NumberOfSessions] [int] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateStart] [datetime2](7) NOT NULL,
	[DateEnd] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_WorkShopTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WorkShop] ADD  CONSTRAINT [DF_WorkShopTypes_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[WorkShop] ADD  CONSTRAINT [DF_WorkShopTypes_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[WorkShop]  WITH NOCHECK ADD  CONSTRAINT [FK_WorkShop_Venues] FOREIGN KEY([VenueId])
REFERENCES [dbo].[Venues] ([Id])
GO

ALTER TABLE [dbo].[WorkShop] NOCHECK CONSTRAINT [FK_WorkShop_Venues]
GO

ALTER TABLE [dbo].[WorkShop]  WITH CHECK ADD  CONSTRAINT [FK_WorkShop_WorkshopLanguages_ID] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[WorkshopLanguages] ([Id])
GO

ALTER TABLE [dbo].[WorkShop] CHECK CONSTRAINT [FK_WorkShop_WorkshopLanguages_ID]
GO


