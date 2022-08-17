USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Attendance_Update]    Script Date: 8/9/2022 2:23:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author: <Shalene Brooks>
-- Create date: <04/01/2022>
-- Description: <Update proc for Attendance>
-- Code Reviewer: <Alicia Moreno>

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Attendance_Update]


@Id int OUTPUT
,@SessionId int
,@UserId int
,@isPresent bit

as

/*
SELECT * 

FROM 
	dbo.Attendance

Declare @Id int = 4;

Declare @SessionId int = 194
		,@UserId int = 4
		,@isPresent bit = 0

Execute dbo.Attendance_Update 
						@Id OUTPUT
						,@SessionId
						,@UserId
						,@isPresent



SELECT * 

FROM 
	dbo.Attendance



*/
BEGIN

UPDATE 
[dbo].[Attendance]

SET
	[SessionId] = @SessionId
	,[UserId] = @UserId
	,[isPresent] = @isPresent

WHERE
	Id = @Id

END




