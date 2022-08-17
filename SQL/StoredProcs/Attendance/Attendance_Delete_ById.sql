USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Attendance_Delete_ById]    Script Date: 8/9/2022 2:23:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: <Shalene Brooks>
-- Create date: <04/01/2022>
-- Description: <Delete by ID proc for Attendance>
-- Code Reviewer:<Alicia Moreno>

-- MODIFIED BY:
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[Attendance_Delete_ById]

@Id int

as

/*

Select *
FROM dbo.Attendance


Declare @Id Int = 1;
Execute dbo.Attendance_Delete_ById @Id

Select *
FROM dbo.Attendance

*/
BEGIN

DELETE
FROM
	[dbo].[Attendance]

WHERE
	Id = @Id
END


