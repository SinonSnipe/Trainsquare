USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionAvailabilities_Select_ById]    Script Date: 8/14/2022 12:36:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Returns a record from dbo.SessionAvailabilities that matches the given @Id
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
ALTER proc [dbo].[SessionAvailabilities_Select_ById]
						@Id int


as

/*	
		Declare @Id int = 8
		Execute [dbo].[SessionAvailabilities_Select_ById]
						@Id

*/

BEGIN
		
		Select Id
				,SessionId
				,[DayOfWeek]
				,StartTime
				,EndTime
				,DateCreated
				,DateModified
				,CreatedBy
				,ModifiedBy
		From dbo.SessionAvailabilities
		Where Id = @Id

END