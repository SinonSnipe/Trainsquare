USE [Trainsquare]
GO

/****** Object:  Table [dbo].[TokenTypes]    Script Date: 8/15/2022 4:46:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TokenTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TokenTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TokenTypes]  WITH CHECK ADD  CONSTRAINT [FK_TokenTypes_TokenTypes] FOREIGN KEY([Id])
REFERENCES [dbo].[TokenTypes] ([Id])
GO

ALTER TABLE [dbo].[TokenTypes] CHECK CONSTRAINT [FK_TokenTypes_TokenTypes]
GO


