USE [Trainsquare]
GO

/****** Object:  Table [dbo].[VenueImages]    Script Date: 8/15/2022 4:48:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VenueImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [nchar](255) NOT NULL,
	[ImgName] [nvarchar](150) NULL,
 CONSTRAINT [PK_VenueImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


