USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[TwoFactorAuthentication_Select_ByUserId]    Script Date: 8/14/2022 1:49:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROC [dbo].[TwoFactorAuthentication_Select_ByUserId]
				@UserId int
/*-------------------------TEST---------------------

Declare @UserId int = 262;

Execute dbo.TwoFactorAuthentication_Select_ByUserId @UserId




*/

as



BEGIN


			Select tfA.Id
					,tFA.UserId
					,uP.FirstName
					,uP.LastName
					,uP.AvatarUrl
					,tFA.PhoneNumber
					,tFA.StatusId
					,tFS.Name as UserStatus
					,tFA.IsTwoFactorEnabled
					,tFA.TwoFactorTypeId
					,tFAT.Name as AuthenticationType
					,tFAC.Code
					--,AttemptCode = (select tFACT.Id
					--			from dbo.TwoFactorAuthenticationCodeTypes tFACT	 INNER JOIN dbo.TwoFactorAuthenticationCodes as tFAC									
					--			on tFACT.Id = tFAC.AttemptId
					--			where tFAC.UserId = tFA.UserId
					--			)
					,Attempt = (select tFACT.name
								from dbo.TwoFactorAuthenticationCodeTypes tFACT	 INNER JOIN dbo.TwoFactorAuthenticationCodes as tFAC									
								on tFACT.Id = tFAC.AttemptId
								where tFAC.UserId = tFA.UserId
								)
					
					,tFA.DateCreated
					,tFA.DateModified
					

			FROM dbo.TwoFactorAuthentication as tFA INNER JOIN dbo.UserProfiles as uP
											on tFA.UserId = uP.UserId
													INNER JOIN dbo.TwoFactorStatusType as tFS
											on tFA.StatusId = tFS.Id
													INNER JOIN dbo.TwoFactorAuthenticationTypes as tFAT
											on tFA.TwoFactorTypeId = tFAT.Id
													FULL OUTER JOIN dbo.TwoFactorAuthenticationCodes as tFAC
											on tFA.UserId = tFAC.UserId

			WHERE tFA.UserId = @UserId

			 --dbo.TwoFactorAuthenticationCodes INNER JOIN dbo.TwoFactorAuthenticationCodesTypes as tFACT
				--							on tFAC.AttemptId = tFACT.Id										
			

			


END