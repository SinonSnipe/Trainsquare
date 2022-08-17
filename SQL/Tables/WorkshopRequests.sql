USE [Trainsquare]
GO

/****** Object:  Table [dbo].[WorkshopRequests]    Script Date: 8/15/2022 4:49:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkshopRequests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[HostId] [int] NOT NULL,
	[Topic] [nvarchar](150) NOT NULL,
	[BriefDescription] [nvarchar](1000) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_WorkshopRequests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WorkshopRequests] ADD  CONSTRAINT [DF_WorkshopRequests_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[WorkshopRequests] ADD  CONSTRAINT [DF_WorkshopRequests_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[WorkshopRequests]  WITH CHECK ADD  CONSTRAINT [FK_WorkshopRequests_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[WorkshopRequests] CHECK CONSTRAINT [FK_WorkshopRequests_Users]
GO


