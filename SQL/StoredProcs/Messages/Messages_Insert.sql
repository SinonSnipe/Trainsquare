USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Insert]    Script Date: 8/10/2022 3:47:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description:	Insert new Message proc. 
-- Code Reviewer: Elizabeth Phung


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 


ALTER PROC [dbo].[Messages_Insert]
				@Message nvarchar(1000)
			   ,@Subject nvarchar(100)
			   ,@RecipientId int
			   ,@SenderId int
			   ,@DateSent datetime2
			   ,@DateRead datetime2
			   ,@Id int OUTPUT

AS
/*


	DECLARE @Id int = 0
			,@Message nvarchar(1000) = 'Created a proc to bring back last message sent'
			,@Subject nvarchar(100) = null
			,@RecipientId int = 267
			,@SenderId int = 13
			,@DateSent datetime2 = '2022-05-05'
			,@DateRead datetime2 = null
	
	EXECUTE [dbo].[Messages_Insert]
			@Message
			,@Subject
			,@RecipientId
			,@SenderId
			,@DateSent
			,@DateRead
			,@Id OUTPUT

	SELECT *
	From dbo.Messages
	Where Id = @Id



*/
BEGIN 



	INSERT INTO [dbo].[Messages]
			   ([Message]
			   ,[Subject]
			   ,[RecipientId]
			   ,[SenderId]
			   ,[DateSent]
			   ,[DateRead])

		 VALUES
			   (@Message
			   ,@Subject
			   ,@RecipientId
			   ,@SenderId
			   ,@DateSent
			   ,@DateRead)

	SET @Id = SCOPE_IDENTITY()

END



