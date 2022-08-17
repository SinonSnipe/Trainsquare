USE [Trainsquare]
GO

/****** Object:  Table [dbo].[WorkshopLesson]    Script Date: 8/15/2022 4:49:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkshopLesson](
	[WorkshopId] [int] NOT NULL,
	[LessonId] [int] NOT NULL,
 CONSTRAINT [PK_WorkshopLesson] PRIMARY KEY CLUSTERED 
(
	[WorkshopId] ASC,
	[LessonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WorkshopLesson]  WITH CHECK ADD  CONSTRAINT [FK_WorkshopLesson_Lessons] FOREIGN KEY([LessonId])
REFERENCES [dbo].[Lessons] ([Id])
GO

ALTER TABLE [dbo].[WorkshopLesson] CHECK CONSTRAINT [FK_WorkshopLesson_Lessons]
GO

ALTER TABLE [dbo].[WorkshopLesson]  WITH CHECK ADD  CONSTRAINT [FK_WorkshopLesson_WorkShop] FOREIGN KEY([WorkshopId])
REFERENCES [dbo].[WorkShop] ([Id])
GO

ALTER TABLE [dbo].[WorkshopLesson] CHECK CONSTRAINT [FK_WorkshopLesson_WorkShop]
GO


