USE [Trainsquare]
GO

/****** Object:  Table [dbo].[TwoFactorAuthentication]    Script Date: 8/15/2022 4:46:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TwoFactorAuthentication](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
	[StatusId] [int] NOT NULL,
	[IsTwoFactorEnabled] [bit] NOT NULL,
	[TwoFactorTypeId] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_TwoFactorAuthentication] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TwoFactorAuthentication] ADD  CONSTRAINT [DF_TwoFactorAuthentication_StatusId]  DEFAULT ((3)) FOR [StatusId]
GO

ALTER TABLE [dbo].[TwoFactorAuthentication] ADD  CONSTRAINT [DF_TwoFactorAuthentication_IsTwoFactorEnabled]  DEFAULT ((0)) FOR [IsTwoFactorEnabled]
GO

ALTER TABLE [dbo].[TwoFactorAuthentication] ADD  CONSTRAINT [DF_TwoFactorAuthentication_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[TwoFactorAuthentication] ADD  CONSTRAINT [DF_TwoFactorAuthentication_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[TwoFactorAuthentication]  WITH CHECK ADD  CONSTRAINT [FK_TwoFactorAuthentication_TwoFactorAuthenticationTypes] FOREIGN KEY([TwoFactorTypeId])
REFERENCES [dbo].[TwoFactorAuthenticationTypes] ([Id])
GO

ALTER TABLE [dbo].[TwoFactorAuthentication] CHECK CONSTRAINT [FK_TwoFactorAuthentication_TwoFactorAuthenticationTypes]
GO

ALTER TABLE [dbo].[TwoFactorAuthentication]  WITH CHECK ADD  CONSTRAINT [FK_TwoFactorAuthentication_TwoFactorStatusType] FOREIGN KEY([StatusId])
REFERENCES [dbo].[TwoFactorStatusType] ([Id])
GO

ALTER TABLE [dbo].[TwoFactorAuthentication] CHECK CONSTRAINT [FK_TwoFactorAuthentication_TwoFactorStatusType]
GO


