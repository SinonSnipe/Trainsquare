USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Ratings]    Script Date: 8/15/2022 4:41:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Ratings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [tinyint] NOT NULL,
	[CommentId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[EntityId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Ratings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Ratings] ADD  CONSTRAINT [DF_Ratings_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Ratings] ADD  CONSTRAINT [DF_Ratings_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO


