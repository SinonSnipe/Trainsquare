USE [Trainsquare]
GO

/****** Object:  Table [dbo].[TwoFactorAuthenticationCodeTypes]    Script Date: 8/15/2022 4:46:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TwoFactorAuthenticationCodeTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](15) NOT NULL,
 CONSTRAINT [PK_TwoFactorAuthenticationCodeStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


