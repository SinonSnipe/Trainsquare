USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_Select_AuthData]    Script Date: 8/14/2022 2:12:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Author: Amezcua, Abel
-- Create date: 03/28/2022
-- Description:	Proc for User Login. Proc verifies user has confirmed their email and verifies the user status
-- Code Reviewer: Frank


-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer: 
-- Note: 

ALTER PROC [dbo].[Users_Select_AuthData]
					@Email nvarchar(100)
AS

/*

	Declare @Email nvarchar(100) = 'ReactTest7@gmail.com'

	Execute dbo.Users_Select_AuthData
				@Email

*/

BEGIN

If Exists (select 1
			from dbo.Users
			where Email = @Email)
	BEGIN			
		Declare @IsConfirmed bit = (select u.IsConfirmed
									from dbo.Users as u
									where @Email = u.Email)				

		If (@IsConfirmed = 1)
		BEGIN

				Declare @UserStatusId int =(select u.UserStatusId
											from dbo.Users as u
											where @Email = u.Email)

				Declare @status nvarchar(50)  = 'Current account status: ' 
												+ (select us.Name
												from dbo.UserStatus as us
												where @UserStatusId = us.Id)


				If (@UserStatusId = 1)
					BEGIN

						SELECT 
								 Password
								,u.Id
								,u.Email
								,Roles = (
											Select r.Name as Name
											From dbo.Roles as r inner join dbo.UserRoles as ur
													on r.Id = ur.RoleId
											Where u.Id = ur.UserId
											For JSON Path
											)

						FROM dbo.Users as u
						Where Email = @Email

					END

				Else
					Throw 51000, @status, 1
		END
		Else 
			Throw 51000, 'User not confirmed', 1
	END		
Else
	THROW 51000, 'Record not found', 1





END