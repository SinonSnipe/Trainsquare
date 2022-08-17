USE [Trainsquare]
GO

/****** Object:  Table [dbo].[FavoriteHosts]    Script Date: 8/15/2022 3:29:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FavoriteHosts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HostId] [int] NOT NULL,
	[WorkshopId] [int] NOT NULL,
 CONSTRAINT [PK_FavoriteHosts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


