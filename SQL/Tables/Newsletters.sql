USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Newsletters]    Script Date: 8/15/2022 4:34:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Newsletters](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CoverPhoto] [nvarchar](255) NULL,
	[DateToPublish] [datetime2](7) NULL,
	[DateToExpire] [datetime2](7) NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_Newsletters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Newsletters] ADD  CONSTRAINT [DF_Newsletters_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Newsletters] ADD  CONSTRAINT [DF_Newsletters_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO


