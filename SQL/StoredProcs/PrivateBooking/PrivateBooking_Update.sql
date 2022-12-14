USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[PrivateBooking_Update]    Script Date: 8/14/2022 11:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Bianchi Mena
-- Create date: 05/17/2022
-- Description: Stored Procedure for UPDATE for dbo.PrivateBooking Table 
-- Code Reviewer: Ethan Englert

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[PrivateBooking_Update]
			@Name nvarchar(50)
		   ,@Email nvarchar(100)
		   ,@NumberOfPeopleAttending int
		   ,@NumberOfSessions int 
		   ,@Id int OUTPUT

AS 

/* --- TEST CODE --- 

	DECLARE @Id int = 7
	
	DECLARE @Name nvarchar(50) = 'Test'
		   ,@Email nvarchar(100) = 'Test120@gmail.com'
		   ,@NumberOfPeopleAttending int = 6
		   ,@NumberOfSessions int = 70

	EXECUTE dbo.Privatebooking_Update @Name
									 ,@Email
								     ,@NumberOfPeopleAttending
									 ,@NumberOfSessions
									 ,@Id OUTPUT

	SELECT *
	FROM dbo.PrivateBooking

	

*/

BEGIN

UPDATE [dbo].[PrivateBooking]
   SET [Name] = @Name
      ,[Email] = @Email
	  ,[NumberOfPeopleAttending] = @NumberOfPeopleAttending
      ,[NumberOfSessions] = @NumberOfSessions
 WHERE Id = @Id

END


