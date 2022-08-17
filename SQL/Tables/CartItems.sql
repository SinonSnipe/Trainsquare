USE [Trainsquare]
GO

/****** Object:  Table [dbo].[CartItems]    Script Date: 8/15/2022 3:24:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CartItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CartId] [int] NOT NULL,
	[InventoryId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CartItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CartItems] ADD  CONSTRAINT [DF_CartItems_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[CartItems] ADD  CONSTRAINT [DF_CartItems_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Inventory] FOREIGN KEY([InventoryId])
REFERENCES [dbo].[Inventory] ([Id])
GO

ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Inventory]
GO


