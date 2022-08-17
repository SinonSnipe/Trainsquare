USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Faqs]    Script Date: 8/15/2022 3:28:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Faqs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](255) NOT NULL,
	[Answer] [nvarchar](2000) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_Faq] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Faqs] ADD  CONSTRAINT [DF_Faq_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Faqs] ADD  CONSTRAINT [DF_Faq_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[Faqs]  WITH CHECK ADD  CONSTRAINT [FK_Faqs_FaqCategories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[FaqCategories] ([Id])
GO

ALTER TABLE [dbo].[Faqs] CHECK CONSTRAINT [FK_Faqs_FaqCategories]
GO

ALTER TABLE [dbo].[Faqs]  WITH NOCHECK ADD  CONSTRAINT [FK_Faqs_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Faqs] CHECK CONSTRAINT [FK_Faqs_Users]
GO

ALTER TABLE [dbo].[Faqs]  WITH NOCHECK ADD  CONSTRAINT [FK_Faqs_Users1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Faqs] CHECK CONSTRAINT [FK_Faqs_Users1]
GO


