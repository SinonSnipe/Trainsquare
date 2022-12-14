USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserProfiles_SelectAll_V2]    Script Date: 8/14/2022 2:01:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[UserProfiles_SelectAll_V2]
				@PageIndex int
				,@PageSize int
AS
/* ---------- TEST CODE --------

	DECLARE @PageIndex int= 0
			,@PageSize int= 10

	EXECUTE [dbo].[UserProfiles_SelectAll_V2]
			@PageIndex
			,@PageSize

*/
BEGIN 

	DECLARE @offset int =  @pageIndex * @pageSize

			SELECT	 [UserId]
					,[AvatarUrl] as ProfileImage
					,[FirstName]
					,[LastName]
					,Email = (
								SELECT u.Email as email
								FROM dbo.Users as u
								WHERE up.Id = u.Id
							)
					,Roles = (
								SELECT r.Name as role
								FROM dbo.Roles as r
								WHERE up.Id = r.Id
								FOR JSON AUTO
								)
					,Status = (
								SELECT us.Name as status
								FROM dbo.UserStatus as us
								WHERE up.Id = us.Id
					
					)
					,[DateCreated]
					,[DateModified]
					,TotalCount = Count(1)OVER()

		FROM [dbo].[UserProfiles] as up
		-- joins
		ORDER BY up.UserId
	
		OFFSET @offSet Rows
		Fetch Next @pageSize Rows ONLY




END