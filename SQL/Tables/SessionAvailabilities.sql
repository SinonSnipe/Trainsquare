USE [Trainsquare]
GO

/****** Object:  Table [dbo].[SessionAvailabilities]    Script Date: 8/15/2022 4:41:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SessionAvailabilities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [int] NOT NULL,
	[DayOfWeek] [int] NOT NULL,
	[StartTime] [time](0) NOT NULL,
	[EndTime] [time](0) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_SessionAvailability] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SessionAvailabilities] ADD  CONSTRAINT [DF_SessionAvailability_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[SessionAvailabilities] ADD  CONSTRAINT [DF_SessionAvailability_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[SessionAvailabilities]  WITH CHECK ADD  CONSTRAINT [FK_SessionAvailabilities_Days] FOREIGN KEY([DayOfWeek])
REFERENCES [dbo].[Days] ([Id])
GO

ALTER TABLE [dbo].[SessionAvailabilities] CHECK CONSTRAINT [FK_SessionAvailabilities_Days]
GO

ALTER TABLE [dbo].[SessionAvailabilities]  WITH CHECK ADD  CONSTRAINT [FK_SessionAvailabilities_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[SessionAvailabilities] CHECK CONSTRAINT [FK_SessionAvailabilities_Users]
GO

ALTER TABLE [dbo].[SessionAvailabilities]  WITH CHECK ADD  CONSTRAINT [FK_SessionAvailabilities_Users1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[SessionAvailabilities] CHECK CONSTRAINT [FK_SessionAvailabilities_Users1]
GO


