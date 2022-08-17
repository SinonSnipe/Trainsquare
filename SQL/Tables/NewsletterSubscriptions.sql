USE [Trainsquare]
GO

/****** Object:  Table [dbo].[NewsletterSubscriptions]    Script Date: 8/15/2022 4:34:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NewsletterSubscriptions](
	[Email] [nvarchar](255) NOT NULL,
	[IsSubscribed] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[NewsletterSubscriptions] ADD  CONSTRAINT [DF_NewsletterSubscriptions_IsSubscribed]  DEFAULT ((1)) FOR [IsSubscribed]
GO

ALTER TABLE [dbo].[NewsletterSubscriptions] ADD  CONSTRAINT [DF_NewsletterSubscriptions_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[NewsletterSubscriptions] ADD  CONSTRAINT [DF_NewsletterSubscriptions_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO


