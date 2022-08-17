USE [Trainsquare]
GO

/****** Object:  Table [dbo].[NewsletterTemplates]    Script Date: 8/15/2022 4:34:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NewsletterTemplates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](200) NOT NULL,
	[PrimaryImage] [nvarchar](255) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_NewsletterTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[NewsletterTemplates] ADD  CONSTRAINT [DF_NewsletterTemplates_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[NewsletterTemplates] ADD  CONSTRAINT [DF_NewsletterTemplates_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[NewsletterTemplates]  WITH CHECK ADD  CONSTRAINT [FK_NewsletterTemplates_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[NewsletterTemplates] CHECK CONSTRAINT [FK_NewsletterTemplates_Users]
GO


