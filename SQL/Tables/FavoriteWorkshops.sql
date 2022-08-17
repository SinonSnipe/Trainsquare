USE [Trainsquare]
GO

/****** Object:  Table [dbo].[FavoriteWorkshops]    Script Date: 8/15/2022 3:29:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FavoriteWorkshops](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[WorkShopId] [int] NOT NULL,
 CONSTRAINT [PK_FavoriteWorkshops] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FavoriteWorkshops]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteWorkshops_FavoriteWorkshops] FOREIGN KEY([Id])
REFERENCES [dbo].[FavoriteWorkshops] ([Id])
GO

ALTER TABLE [dbo].[FavoriteWorkshops] CHECK CONSTRAINT [FK_FavoriteWorkshops_FavoriteWorkshops]
GO


