USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Sessions_DeleteV2]    Script Date: 8/14/2022 1:30:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/24/22
-- Description:	Deletes a record from dbo.Sessions including all
--				related records from dbo.SessionAvailabilities.
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
ALTER proc [dbo].[Sessions_DeleteV2]
						@Id int
					

as

/*
		Declare @Id int = 5

		Execute dbo.Sessions_Select_ByIdV2 @Id
		
		Execute [dbo].[Sessions_DeleteV2] 
						@Id

		Execute dbo.Sessions_Select_ByIdV2 @Id

		Select *
		from dbo.SessionAvailabilities
		where SessionId = 5


*/

BEGIN

		Delete
		From dbo.SessionAvailabilities
		Where SessionId = @Id

		Delete
		From dbo.Sessions
		Where Id = @Id

END