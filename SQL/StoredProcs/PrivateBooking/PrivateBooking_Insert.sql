USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[PrivateBooking_Insert]    Script Date: 8/14/2022 11:55:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Bianchi Mena
-- Create date: 05/17/2022
-- Description: Stored Procedure for INSERT for dbo.PrivateBooking Table 
-- Code Reviewer: Ethan Englert

-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer:
-- Note:
-- =============================================

ALTER PROC [dbo].[PrivateBooking_Insert]
			@Name nvarchar(50)
		   ,@Email nvarchar(100)
		   ,@NumberOfPeopleAttending int
		   ,@NumberOfSessions int 
		   ,@Id int OUTPUT

AS

/* --- TEST CODE ---
	
	DECLARE @Id int = 1
	DECLARE @Name nvarchar(50) = 'Rob Miller'
		   ,@Email nvarchar(100) = 'Miller993@gmail.com'
		   ,@NumberOfPeopleAttending int = 2
		   ,@NumberOfSessions int = 10

	EXECUTE dbo.PrivateBooking_Insert @Name
									 ,@Email	
								     ,@NumberOfPeopleAttending
									 ,@NumberOfSessions 
									 ,@Id OUTPUT

	SELECT *
	FROM dbo.PrivateBooking

	TRUNCATE TABLE dbo.PrivateBooking
*/  

BEGIN

INSERT INTO [dbo].[PrivateBooking]
           ([Name]
		   ,[Email]
		   ,[NumberOfPeopleAttending]
           ,[NumberOfSessions])
     VALUES
           (@Name
		   ,@Email
		   ,@NumberOfPeopleAttending
           ,@NumberOfSessions)
	SET @Id = SCOPE_IDENTITY()
END


