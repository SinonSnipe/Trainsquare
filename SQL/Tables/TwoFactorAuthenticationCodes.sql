USE [Trainsquare]
GO

/****** Object:  Table [dbo].[TwoFactorAuthenticationCodes]    Script Date: 8/15/2022 4:46:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TwoFactorAuthenticationCodes](
	[UserId] [int] NOT NULL,
	[Code] [nvarchar](6) NULL,
	[AttemptId] [int] NOT NULL,
 CONSTRAINT [PK_TwoFactorAuthenticationCodes] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TwoFactorAuthenticationCodes] ADD  CONSTRAINT [DF_TwoFactorAuthenticationCodes_AttemptId]  DEFAULT ((1)) FOR [AttemptId]
GO

ALTER TABLE [dbo].[TwoFactorAuthenticationCodes]  WITH CHECK ADD  CONSTRAINT [FK_TwoFactorAuthenticationCodes_TwoFactorAuthenticationCodeTypes] FOREIGN KEY([AttemptId])
REFERENCES [dbo].[TwoFactorAuthenticationCodeTypes] ([Id])
GO

ALTER TABLE [dbo].[TwoFactorAuthenticationCodes] CHECK CONSTRAINT [FK_TwoFactorAuthenticationCodes_TwoFactorAuthenticationCodeTypes]
GO


