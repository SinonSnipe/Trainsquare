USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[SessionAvailabilities_Insert]    Script Date: 8/14/2022 12:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Inserts a record to dbo.SessionAvailabilities and returns its new Id
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 


ALTER proc [dbo].[SessionAvailabilities_Insert]
					@Id int OUTPUT
					,@SessionId int
					,@DayOfWeek int
					,@StartTime time
					,@EndTime time
					,@User int

as

/*
			Declare @Id int = 0
					,@SessionId int = 6
					,@DayOfWeek int = 5
					,@StartTime time(0) = '7:00:00'
					,@EndTime time(0) = '12:00:00'
					,@CreatedBy int = 6
			Execute [dbo].[SessionAvailabilities_Insert]
							@Id output
							,@SessionId 
							,@DayOfWeek 
							,@StartTime 
							,@EndTime 
							,@CreatedBy 
			Execute [dbo].[SessionAvailabilities_Select_ById] @Id



*/

BEGIN

					Insert into [dbo].[SessionAvailabilities] (SessionId
																,[DayOfWeek]
																,StartTime
																,EndTime
																,CreatedBy
																,ModifiedBy)
					Values (@SessionId 
							,@DayOfWeek 
							,@StartTime 
							,@EndTime 
							,@User
							,@User)

					Set @Id = SCOPE_IDENTITY()
END