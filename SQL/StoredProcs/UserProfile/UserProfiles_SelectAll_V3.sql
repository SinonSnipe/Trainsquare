USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAll_V3]    Script Date: 8/14/2022 2:01:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[UserProfiles_SelectAll_V3]
				@PageIndex int
				,@PageSize int
AS
/* ---------- TEST CODE --------

	DECLARE @PageIndex int= 0
			,@PageSize int= 10

	EXECUTE [dbo].[UserProfiles_SelectAll_V3]
			@PageIndex
			,@PageSize

*/
BEGIN 

	DECLARE @offset int =  @pageIndex * @pageSize

			SELECT	 up.UserId
					,up.AvatarUrl as ProfileImage
					,up.FirstName
					,up.LastName
					,u.Email 					
					,ur.RoleId				
					,s.Name 
					,up.DateCreated
					,up.DateModified
					,TotalCount = Count(1)OVER()

		FROM dbo.UserProfiles as up INNER JOIN dbo.Users as u
							on up.Id = u.Id
									INNER JOIN dbo.UserRoles as ur
							on up.UserId = ur.RoleId
									INNER JOIN dbo.States as s
							on up.UserId = s.Id

		-- joins
		ORDER BY up.UserId
	
		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY




END