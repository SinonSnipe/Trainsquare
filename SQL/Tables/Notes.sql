USE [Trainsquare]
GO

/****** Object:  Table [dbo].[Notes]    Script Date: 8/15/2022 4:37:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Notes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[WorkShopId] [int] NOT NULL,
	[TagsTypeId] [int] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
 CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Notes] ADD  CONSTRAINT [DF_Notes_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[Notes] ADD  CONSTRAINT [DF_Notes_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_Notes_TagsTypes] FOREIGN KEY([TagsTypeId])
REFERENCES [dbo].[TagsTypes] ([Id])
GO

ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_TagsTypes]
GO

ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_Notes_WorkShop] FOREIGN KEY([WorkShopId])
REFERENCES [dbo].[WorkShop] ([Id])
GO

ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_WorkShop]
GO


