USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionAvailabilities_Update]    Script Date: 8/14/2022 12:37:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Updates a record from dbo.SessionAvailabilities by its Id
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
ALTER proc [dbo].[SessionAvailabilities_Update]
					@Id int 
					,@SessionId int
					,@DayOfWeek int
					,@StartTime time
					,@EndTime time
					,@User int

as

/*
			Declare @Id int = 8
					,@DayOfWeek int = 7
					,@StartTime time(0) = '1:00:00'
					,@EndTime time(0) = '5:00:00'
					,@ModifiedBy int = 6
			Execute [dbo].[SessionAvailabilities_Update]
							@Id 
							,@DayOfWeek 
							,@StartTime 
							,@EndTime 
							,@ModifiedBy 
			Execute [dbo].[SessionAvailabilities_Select_ById] @Id



*/

BEGIN
				Declare @dateMod datetime2(7) = getutcdate()
				Update dbo.SessionAvailabilities 
						Set [DayOfWeek] = @DayOfWeek 
							,SessionId = @SessionId
							,StartTime = @StartTime 
							,EndTime = @EndTime 
							,DateModified = @dateMod
							,ModifiedBy = @User
				Where Id = @Id

END