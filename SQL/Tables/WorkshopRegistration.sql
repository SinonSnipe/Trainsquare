USE [Trainsquare]
GO

/****** Object:  Table [dbo].[WorkshopRegistration]    Script Date: 8/15/2022 4:49:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkshopRegistration](
	[WorkshopId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_WorkshopRegistration] PRIMARY KEY CLUSTERED 
(
	[WorkshopId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WorkshopRegistration] ADD  CONSTRAINT [DF_WorkshopSignUp_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[WorkshopRegistration]  WITH CHECK ADD  CONSTRAINT [FK_WorkshopRegistration_WorkshopRegistrationStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[WorkshopRegistrationStatus] ([StatusId])
GO

ALTER TABLE [dbo].[WorkshopRegistration] CHECK CONSTRAINT [FK_WorkshopRegistration_WorkshopRegistrationStatus]
GO

ALTER TABLE [dbo].[WorkshopRegistration]  WITH CHECK ADD  CONSTRAINT [FK_WorkshopSignUp_Users1] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[WorkshopRegistration] CHECK CONSTRAINT [FK_WorkshopSignUp_Users1]
GO

ALTER TABLE [dbo].[WorkshopRegistration]  WITH CHECK ADD  CONSTRAINT [FK_WorkshopSignUp_WorkShop] FOREIGN KEY([WorkshopId])
REFERENCES [dbo].[WorkShop] ([Id])
GO

ALTER TABLE [dbo].[WorkshopRegistration] CHECK CONSTRAINT [FK_WorkshopSignUp_WorkShop]
GO


