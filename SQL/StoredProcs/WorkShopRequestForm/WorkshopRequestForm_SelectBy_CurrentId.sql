USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkshopRequestForm_SelectBy_CurrentId]    Script Date: 8/15/2022 12:08:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Enrique Lozano>
-- Create date: <4/6/22,,>
-- Description: <Created an Select Proc for WorkShopRequest,,>
-- Code Reviewer: Eliabeth Phung

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================
ALTER   Proc [dbo].[WorkshopRequestForm_SelectBy_CurrentId]
		@InstructorId int

As
/*
Declare @InstructorId int = 1

Execute dbo.WorkShopRequestForm_SelectBy_CurrentId @InstructorId
*/
Begin
SELECT  form.InstructorId
        ,form.Name
       
	  ,u.Email
      ,form.Topic
      ,form.ShortDescription
      ,form.DateCreated
      ,form.DateModified
	  ,up.FirstName
	  ,up.LastName
 FROM [dbo].[WorkshopRequestForm] as form inner join users as u
										on form.InstructorId = u.Id
									  inner join UserProfiles as up
										on u.Id = up.UserId
  Where form.InstructorId = @InstructorId
End