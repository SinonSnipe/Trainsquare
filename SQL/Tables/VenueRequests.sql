USE [Trainsquare]
GO

/****** Object:  Table [dbo].[VenueRequests]    Script Date: 8/15/2022 4:48:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VenueRequests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VenueId] [int] NOT NULL,
	[EventDescription] [nvarchar](4000) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[Requester] [int] NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_VenueRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[VenueRequests] ADD  CONSTRAINT [DF_VenueRequests_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[VenueRequests] ADD  CONSTRAINT [DF_VenueRequests_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[VenueRequests]  WITH CHECK ADD  CONSTRAINT [FK_VenueRequests_Users] FOREIGN KEY([Requester])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[VenueRequests] CHECK CONSTRAINT [FK_VenueRequests_Users]
GO

ALTER TABLE [dbo].[VenueRequests]  WITH CHECK ADD  CONSTRAINT [FK_VenueRequests_Venues] FOREIGN KEY([VenueId])
REFERENCES [dbo].[Venues] ([Id])
GO

ALTER TABLE [dbo].[VenueRequests] CHECK CONSTRAINT [FK_VenueRequests_Venues]
GO


