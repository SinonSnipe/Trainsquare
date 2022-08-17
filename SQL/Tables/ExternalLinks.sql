USE [Trainsquare]
GO

/****** Object:  Table [dbo].[ExternalLinks]    Script Date: 8/15/2022 3:26:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ExternalLinks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[UrlTypeId] [int] NOT NULL,
	[Url] [nvarchar](255) NOT NULL,
	[EntityId] [int] NULL,
	[EntityTypeId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ExternalLinks_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ExternalLinks] ADD  CONSTRAINT [DF_ExternalLinks_DateCreated_1]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[ExternalLinks] ADD  CONSTRAINT [DF_ExternalLinks_DateModified_1]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[ExternalLinks]  WITH CHECK ADD  CONSTRAINT [FK_ExternalLinks_EntityTypes] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityBusinessTypes] ([Id])
GO

ALTER TABLE [dbo].[ExternalLinks] CHECK CONSTRAINT [FK_ExternalLinks_EntityTypes]
GO

ALTER TABLE [dbo].[ExternalLinks]  WITH CHECK ADD  CONSTRAINT [FK_ExternalLinks_UrlTypes] FOREIGN KEY([UrlTypeId])
REFERENCES [dbo].[UrlTypes] ([Id])
GO

ALTER TABLE [dbo].[ExternalLinks] CHECK CONSTRAINT [FK_ExternalLinks_UrlTypes]
GO

ALTER TABLE [dbo].[ExternalLinks]  WITH CHECK ADD  CONSTRAINT [FK_ExternalLinks_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ExternalLinks] CHECK CONSTRAINT [FK_ExternalLinks_User]
GO


