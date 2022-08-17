USE [Trainsquare]
GO

/****** Object:  Table [dbo].[PaymentAccounts]    Script Date: 8/15/2022 4:38:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PaymentAccounts](
	[VendorId] [int] NOT NULL,
	[AccountId] [nvarchar](50) NOT NULL,
	[AccountTypeId] [int] NOT NULL,
	[Fee] [decimal](18, 0) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PaymentAccounts] ADD  CONSTRAINT [DF_PaymentAccounts_Fee]  DEFAULT ((0.5)) FOR [Fee]
GO

ALTER TABLE [dbo].[PaymentAccounts]  WITH CHECK ADD  CONSTRAINT [FK_PaymentAccounts_Users] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[PaymentAccounts] CHECK CONSTRAINT [FK_PaymentAccounts_Users]
GO


