USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Cart]    Script Date: 8/15/2022 3:24:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cart](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CustomerId] [int] NOT NULL,
 CONSTRAINT [PK_Cart_1] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [DF_Cart_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO


