USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[TwoFactorAuthenticationCodes_Delete]    Script Date: 8/14/2022 1:50:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER proc [dbo].[TwoFactorAuthenticationCodes_Delete]
		@UserId int

/*-------------------------TEST----------------------------

SELECT *
From dbo.TwoFactorAuthenticationCodes

Declare @UserId int = 262;

Execute dbo.TwoFactorAuthenticationCodes_Delete @UserId

SELECT *
From dbo.TwoFactorAuthenticationCodes


Execute dbo.TwoFactorAuthentication_SelectAll

*/

as 

BEGIN TRY
			BEGIN TRAN

			DELETE from dbo.TwoFactorAuthenticationCodes
			Where UserId = @UserId

			UPDATE dbo.TwoFactorAuthentication
			SET [StatusId] = 3
			Where [UserId] = @UserId

			COMMIT TRAN
END TRY



BEGIN CATCH
			ROLLBACK Tran

END CATCH