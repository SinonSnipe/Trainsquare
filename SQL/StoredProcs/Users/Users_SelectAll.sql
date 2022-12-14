USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAll]    Script Date: 8/14/2022 2:12:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description: Select All proc for Users with joins with UserStatus
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 




ALTER PROC [dbo].[Users_SelectAll]
				@PageIndex int
				,@PageSize int
AS
/*
	DECLARE @PageIndex int= 1
			,@PageSize int= 10

	EXECUTE [dbo].[Users_SelectAll]
			@PageIndex
			,@PageSize
*/
BEGIN 

	DECLARE @offset int =  @pageIndex * @pageSize

		SELECT Id
		  ,[Email]
		  ,Roles = (
					SELECT r.Id as id
							,r.Name as role
					FROM dbo.Roles AS r inner join dbo.UserRoles AS ur
								on r.Id = ur.RoleId
					WHERE u.Id = ur.UserId
					FOR JSON AUTO
		  )
		  ,TotalCount = Count(1)OVER()
	  FROM [dbo].[Users] as u
	  ORDER BY u.Id
	
	  OFFSET @offSet Rows
	  Fetch Next @pageSize Rows ONLY




END