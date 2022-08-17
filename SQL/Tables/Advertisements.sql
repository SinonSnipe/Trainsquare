USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Advertisements]    Script Date: 8/15/2022 3:15:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Advertisements](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkShopId] [int] NOT NULL,
	[OwnerId] [int] NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[AdMainImage] [nchar](400) NULL,
	[Details] [nvarchar](max) NULL,
	[CreatedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateStart] [date] NOT NULL,
	[DateEnd] [date] NOT NULL,
 CONSTRAINT [PK_dbo.Advertisements] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Advertisements] ADD  CONSTRAINT [DF_Advertisements_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Advertisements] ADD  CONSTRAINT [DF_Advertisements_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[Advertisements]  WITH CHECK ADD  CONSTRAINT [FK_Advertisements_Advertisements] FOREIGN KEY([Id])
REFERENCES [dbo].[Advertisements] ([Id])
GO

ALTER TABLE [dbo].[Advertisements] CHECK CONSTRAINT [FK_Advertisements_Advertisements]
GO

ALTER TABLE [dbo].[Advertisements]  WITH CHECK ADD  CONSTRAINT [FK_Advertisements_Advertisements1] FOREIGN KEY([Id])
REFERENCES [dbo].[Advertisements] ([Id])
GO

ALTER TABLE [dbo].[Advertisements] CHECK CONSTRAINT [FK_Advertisements_Advertisements1]
GO

ALTER TABLE [dbo].[Advertisements]  WITH CHECK ADD  CONSTRAINT [FK_Advertisements_Users] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Advertisements] CHECK CONSTRAINT [FK_Advertisements_Users]
GO

ALTER TABLE [dbo].[Advertisements]  WITH CHECK ADD  CONSTRAINT [FK_Advertisements_WorkShop] FOREIGN KEY([WorkShopId])
REFERENCES [dbo].[WorkShop] ([Id])
GO

ALTER TABLE [dbo].[Advertisements] CHECK CONSTRAINT [FK_Advertisements_WorkShop]
GO


