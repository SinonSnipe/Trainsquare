USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Files]    Script Date: 8/15/2022 3:29:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Files](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Url] [nvarchar](255) NOT NULL,
	[FileTypeId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Files] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Files] ADD  CONSTRAINT [DF_Files_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Files] ADD  CONSTRAINT [DF_Files_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Files', @level2type=N'COLUMN',@level2name=N'DateCreated'
GO


