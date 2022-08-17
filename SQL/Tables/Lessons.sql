USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Lessons]    Script Date: 8/15/2022 4:32:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Lessons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[ImageUrl] [nvarchar](150) NULL,
	[DurationTypeId] [int] NOT NULL,
	[FileUrl] [nvarchar](125) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Lessons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Lessons] ADD  CONSTRAINT [DF_Lessons_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Lessons] ADD  CONSTRAINT [DF_Lessons_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [FK_Lessons_DurationType_Id] FOREIGN KEY([DurationTypeId])
REFERENCES [dbo].[LessonDuration] ([Id])
GO

ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [FK_Lessons_DurationType_Id]
GO

ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [FK_Lessons_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [FK_Lessons_Users]
GO

ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [FK_Lessons_Users1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [FK_Lessons_Users1]
GO


