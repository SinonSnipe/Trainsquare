USE [Trainsquare]
GO

/****** Object:  Table [dbo].[AdImages]    Script Date: 8/15/2022 3:15:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AdImages](
	[AdvertisementId] [int] NOT NULL,
	[MediaId] [int] NOT NULL,
 CONSTRAINT [PK_AdImages] PRIMARY KEY CLUSTERED 
(
	[AdvertisementId] ASC,
	[MediaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AdImages]  WITH CHECK ADD  CONSTRAINT [FK_AdImages_Advertisements] FOREIGN KEY([AdvertisementId])
REFERENCES [dbo].[Advertisements] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AdImages] CHECK CONSTRAINT [FK_AdImages_Advertisements]
GO

ALTER TABLE [dbo].[AdImages]  WITH CHECK ADD  CONSTRAINT [FK_AdImages_Files] FOREIGN KEY([MediaId])
REFERENCES [dbo].[Files] ([Id])
GO

ALTER TABLE [dbo].[AdImages] CHECK CONSTRAINT [FK_AdImages_Files]
GO


