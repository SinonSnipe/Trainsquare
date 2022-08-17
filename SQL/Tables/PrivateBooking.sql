USE [Trainsquare]
GO

/****** Object:  Table [dbo].[PrivateBooking]    Script Date: 8/15/2022 4:38:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PrivateBooking](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[NumberOfPeopleAttending] [int] NOT NULL,
	[Description] [nvarchar](700) NULL,
	[NumberOfSessions] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[WorkshopId] [int] NULL,
	[UserId] [int] NULL,
	[WorkshopRequestId] [int] NULL,
 CONSTRAINT [PK_PrivateBooking] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PrivateBooking] ADD  CONSTRAINT [DF_PrivateBooking_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[PrivateBooking] ADD  CONSTRAINT [DF_PrivateBooking_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[PrivateBooking]  WITH CHECK ADD  CONSTRAINT [FK_PrivateBooking_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[PrivateBooking] CHECK CONSTRAINT [FK_PrivateBooking_Users]
GO

ALTER TABLE [dbo].[PrivateBooking]  WITH CHECK ADD  CONSTRAINT [FK_PrivateBooking_WorkShop] FOREIGN KEY([WorkshopId])
REFERENCES [dbo].[WorkShop] ([Id])
GO

ALTER TABLE [dbo].[PrivateBooking] CHECK CONSTRAINT [FK_PrivateBooking_WorkShop]
GO

ALTER TABLE [dbo].[PrivateBooking]  WITH CHECK ADD  CONSTRAINT [FK_PrivateBooking_WorkshopRequests] FOREIGN KEY([WorkshopRequestId])
REFERENCES [dbo].[WorkshopRequests] ([Id])
GO

ALTER TABLE [dbo].[PrivateBooking] CHECK CONSTRAINT [FK_PrivateBooking_WorkshopRequests]
GO


