USE [Trainsquare]
GO

/****** Object:  Table [dbo].[SurveyQuestionAnswerOptions]    Script Date: 8/15/2022 4:42:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SurveyQuestionAnswerOptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Text] [nvarchar](500) NULL,
	[Value] [nvarchar](100) NULL,
	[AdditionalInfo] [nvarchar](200) NULL,
	[CreatedBy] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SurveyQuestionAnswerOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SurveyQuestionAnswerOptions] ADD  CONSTRAINT [DF_SurveyQuestionAnswerOptions_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[SurveyQuestionAnswerOptions] ADD  CONSTRAINT [DF_SurveyQuestionAnswerOptions_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[SurveyQuestionAnswerOptions]  WITH CHECK ADD  CONSTRAINT [FK_SurveyQuestionAnswerOptions_SurveyQuestions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[SurveyQuestions] ([Id])
GO

ALTER TABLE [dbo].[SurveyQuestionAnswerOptions] CHECK CONSTRAINT [FK_SurveyQuestionAnswerOptions_SurveyQuestions]
GO

ALTER TABLE [dbo].[SurveyQuestionAnswerOptions]  WITH CHECK ADD  CONSTRAINT [FK_SurveyQuestionAnswerOptions_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[SurveyQuestionAnswerOptions] CHECK CONSTRAINT [FK_SurveyQuestionAnswerOptions_Users]
GO


