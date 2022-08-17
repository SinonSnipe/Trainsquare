USE [Trainsquare]
GO

/****** Object:  Table [dbo].[WorkshopRegistrationStatus]    Script Date: 8/15/2022 4:49:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkshopRegistrationStatus](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationStatus] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_WorkshopRegistrationStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


