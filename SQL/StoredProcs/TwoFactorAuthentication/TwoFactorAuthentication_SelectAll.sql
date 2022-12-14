USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[TwoFactorAuthentication_SelectAll]    Script Date: 8/14/2022 1:50:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROC [dbo].[TwoFactorAuthentication_SelectAll]

/*-------------------------TEST---------------------



Execute dbo.TwoFactorAuthentication_SelectAll




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
					,tFAC.Code as AuthenticationCode					
					,Attempt = (select tFACT.name
								from dbo.TwoFactorAuthenticationCodeTypes tFACT	 INNER JOIN dbo.TwoFactorAuthenticationCodes as tFAC									
								on tFACT.Id = tFAC.AttemptId
								where tFAC.UserId = tFA.UserId
								)
					,tFA.DateCreated
					,tFA.DateModified
					,TotalCount = COUNT(1) OVER() 

			FROM dbo.TwoFactorAuthentication as tFA INNER JOIN dbo.UserProfiles as uP
											on tFA.UserId = uP.UserId
													INNER JOIN dbo.TwoFactorStatusType as tFS
											on tFA.StatusId = tFS.Id
													INNER JOIN dbo.TwoFactorAuthenticationTypes as tFAT
											on tFA.TwoFactorTypeId = tFAT.Id
													FULL OUTER JOIN dbo.TwoFactorAuthenticationCodes as tFAC
											on tFA.UserId = tFAC.UserId
													



			ORDER BY tFA.Id


END