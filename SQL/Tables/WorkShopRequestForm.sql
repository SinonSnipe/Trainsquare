USE [Trainsquare]
GO

/****** Object:  Table [dbo].[WorkShopRequestForm]    Script Date: 8/15/2022 4:49:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkShopRequestForm](
	[InstructorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Topic] [nvarchar](50) NOT NULL,
	[ShortDescription] [nvarchar](200) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_WorkShopRequest] PRIMARY KEY CLUSTERED 
(
	[InstructorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WorkShopRequestForm] ADD  CONSTRAINT [DF_WorkShopRequest_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[WorkShopRequestForm] ADD  CONSTRAINT [DF_WorkShopRequest_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO


