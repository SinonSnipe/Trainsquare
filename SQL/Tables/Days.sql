USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Days]    Script Date: 8/15/2022 3:24:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Days](
	[Id] [int] NOT NULL,
	[Day] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_DaysOfWeek] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Days]  WITH CHECK ADD  CONSTRAINT [FK_Days_Days] FOREIGN KEY([Id])
REFERENCES [dbo].[Days] ([Id])
GO

ALTER TABLE [dbo].[Days] CHECK CONSTRAINT [FK_Days_Days]
GO


