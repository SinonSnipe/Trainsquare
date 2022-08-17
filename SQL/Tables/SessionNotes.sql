USE [Trainsquare]
GO

/****** Object:  Table [dbo].[SessionNotes]    Script Date: 8/15/2022 4:41:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SessionNotes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WorkshopName] [nvarchar](50) NOT NULL,
	[TagsTypeId] [int] NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[SessionDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SessionNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[SessionNotes] ADD  CONSTRAINT [DF_SessionNotes_SessionDate]  DEFAULT (getutcdate()) FOR [SessionDate]
GO


