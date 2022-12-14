USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Update]    Script Date: 8/10/2022 3:47:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description: Update a Message
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_Update]
			@Id int
			,@Message nvarchar(1000)
			,@Subject nvarchar(100)
			,@RecipientId int
			,@SenderId int
			,@DateSent date
			,@DateRead date

/*

	Declare @Id int = 4
			,@Message nvarchar(1000) = 'Hello Bob'
			,@Subject nvarchar(100) = 'Updating'
			,@RecipientId int = 12
			,@SenderId int = 13
			,@DateSent date = '2022-03-24'
			,@DateRead date = '2022-03-25'

	Execute [dbo].[Messages_Update] @Id
									,@Message
									,@Subject
									,@RecipientId
									,@SenderId
									,@DateSent
									,@DateRead

	Execute dbo.Messages_Select_ById @Id





*/

as
BEGIN

	DECLARE @date datetime2 = getutcdate();

	UPDATE [dbo].[Messages]

		SET [Message] = @Message
			,[Subject] = @Subject
			,[RecipientId] = @RecipientId
			,[SenderId] = @SenderId
			,[DateSent] = @DateSent
			,[DateRead] = @DateRead
			,[DateModified] = @date
		WHERE Id = @Id

END
