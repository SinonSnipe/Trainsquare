USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[TwoFactorAuthenticationCodes_Insert]    Script Date: 8/14/2022 1:50:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[TwoFactorAuthenticationCodes_Insert]
			@UserId int
			,@Code nvarchar(6)			
			,@Id int OUTPUT
/*-------------------TEST----------------

SELECT *
From dbo.TwoFactorAuthenticationCodes


Declare @Id int = 0;

Declare @UserId int				='261'
		,@Code nvarchar(6)		='111111'
		

Execute dbo.TwoFactorAuthenticationCodes_Insert @UserId
												,@Code												
												,@Id OUTPUT

SELECT *
From dbo.TwoFactorAuthenticationCodes

*/
as



IF EXISTS(Select * from dbo.TwoFactorAuthenticationCodes Where UserId = @UserId)

BEGIN  	
		

		UPDATE dbo.TwoFactorAuthenticationCodes
		SET [Code] = @Code
			,[AttemptId] = AttemptId + 1				
		Where [UserId] = @UserId		

		IF EXISTS(select * from dbo.TwoFactorAuthenticationCodes where AttemptId = 4)
		BEGIN
		UPDATE dbo.TwoFactorAuthentication
		SET [StatusId] = 4
		Where [UserId] = @UserId
		END

		
END


ELSE


BEGIN
		INSERT INTO dbo.TwoFactorAuthenticationCodes
					([UserId]
					,[Code]
					)

		VALUES		(@UserId
					,@Code
					)

		SET @Id = SCOPE_IDENTITY()

		UPDATE dbo.TwoFactorAuthentication
		SET [StatusId] = 1
		Where [UserId] = @UserId
END



		--INSERT INTO dbo.TwoFactorAuthenticationCodes
		--			([UserId]
		--			,[Code]
		--			)

		--VALUES		(@UserId
		--			,@Code
		--			)
		--ON DUPLICATE KEY UPDATE AttemptId = @AttemptId + 1

		--SET @Id = SCOPE_IDENTITY()
