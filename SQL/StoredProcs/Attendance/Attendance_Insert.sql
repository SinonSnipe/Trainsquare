USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Attendance_Insert]    Script Date: 8/9/2022 2:23:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Shalene Brooks>
-- Create date: <04/01/2022>
-- Description: <Insert proc for Attendance>
-- Code Reviewer: <Alicia Moreno>

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Attendance_Insert]


@Id int OUTPUT
,@SessionId int
,@UserId int

as

/*
Declare @Id int = 0;

Declare @Session int = 142
		,@UserId int = 8

Execute dbo.Attendance_Insert 
						@Id OUTPUT
						,@SessionId
						,@UserId

SELECT
	*
FROM 
	dbo.Attendance



*/
BEGIN

INSERT INTO 
[dbo].[Attendance]
	([SessionId]
	,[UserId])

VALUES
	(
	@SessionId
	,@UserId)

SET
	@Id = SCOPE_IDENTITY()

END
	


