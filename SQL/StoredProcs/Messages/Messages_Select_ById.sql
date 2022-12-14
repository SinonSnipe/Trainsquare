USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Messages_Select_ById]    Script Date: 8/10/2022 3:47:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Arreguin, Guillermo
-- Create date: 03/25/2022
-- Description: Select Message by Id
-- Code Reviewer: Elizabeth Phung

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Messages_Select_ById]
				@Id int

/*

	Declare @Id int = 4

	Execute [dbo].[Messages_Select_ById] @Id

*/

as
BEGIN

	SELECT  [Id]
			,[Message]
			,[Subject]
			,[RecipientId]
			,[SenderId]
			,[DateSent]
			,[DateRead]
			,[DateCreated]
			,[DateModified]
	FROM	[dbo].[Messages]
	WHERE Id = @Id

END
