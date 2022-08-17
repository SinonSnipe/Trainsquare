USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Messages]    Script Date: 8/15/2022 4:33:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Message] [nchar](1000) NOT NULL,
	[Subject] [nchar](100) NULL,
	[RecipientId] [int] NOT NULL,
	[SenderId] [int] NOT NULL,
	[DateSent] [datetime2](7) NULL,
	[DateRead] [datetime2](7) NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Sender] FOREIGN KEY([SenderId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Sender]
GO

ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users] FOREIGN KEY([RecipientId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users]
GO


