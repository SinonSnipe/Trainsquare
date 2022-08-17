USE [Trainsquare]
GO

/****** Object:  Table [dbo].[SurveyQuestions]    Script Date: 8/15/2022 4:42:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SurveyQuestions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Question] [nvarchar](500) NOT NULL,
	[HelpText] [nvarchar](255) NOT NULL,
	[IsRequired] [bit] NOT NULL,
	[IsMultipleAllowed] [bit] NOT NULL,
	[QuestionTypeId] [int] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SurveyQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SurveyQuestions] ADD  CONSTRAINT [DF_SurveyQuestions_DateCreated]  DEFAULT (getutcdate()) FOR [DateCreated]
GO

ALTER TABLE [dbo].[SurveyQuestions] ADD  CONSTRAINT [DF_SurveyQuestions_DateModified]  DEFAULT (getutcdate()) FOR [DateModified]
GO

ALTER TABLE [dbo].[SurveyQuestions]  WITH CHECK ADD  CONSTRAINT [FK_SurveyQuestions_SurveyQuestionTypes] FOREIGN KEY([QuestionTypeId])
REFERENCES [dbo].[SurveyQuestionTypes] ([Id])
GO

ALTER TABLE [dbo].[SurveyQuestions] CHECK CONSTRAINT [FK_SurveyQuestions_SurveyQuestionTypes]
GO

ALTER TABLE [dbo].[SurveyQuestions]  WITH CHECK ADD  CONSTRAINT [FK_SurveyQuestions_Surveys] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([Id])
GO

ALTER TABLE [dbo].[SurveyQuestions] CHECK CONSTRAINT [FK_SurveyQuestions_Surveys]
GO


