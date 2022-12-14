USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_Update]    Script Date: 8/14/2022 2:21:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jared Williams
-- Create date: 04/04/2022
-- Description: Update proc for Venues
-- Code Reviewer:Sagan Jackson
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER proc [dbo].[Venues_Update]	
				 @Id int 
				,@Name nvarchar(255) 
				,@Description nvarchar(4000)
				,@LocationId int
				,@Url nvarchar(255) 
				,@CreatedBy int 
				,@ModifiedBy int
				,@ImageUrl nvarchar(255)
				
as 
/*---Test Code---	 
Declare
               @Id int = 10
			  ,@Name nvarchar(255) = 'Starbucks HQ'
              ,@Description nvarchar(4000)= 'Headquaters of Starbucks'
              ,@LocationId int = 1
              ,@Url nvarchar(255) = 'www.starbucksvenue.com'
              ,@CreatedBy int = 2
              ,@ModifiedBy int = 2
			  ,,@ImageUrl nvarchar(255) = 'url here'
            
EXEC dbo.Venues_Update
			 @Id 
			,@Name
			,@Description
			,@LocationId
			,@Url
			,@CreatedBy
			,@ModifiedBy
			,,@ImageUrl nvarchar(255)
			
SELECT *
FROM dbo.Venues
*/
BEGIN 
			UPDATE 
				dbo.Venues 
			SET 
				Name = @Name 
				,Description = @Description 
				,LocationId = @LocationId
				,Url = @Url 
				,CreatedBy = @CreatedBy 
				,ModifiedBy = @ModifiedBy
				,ImageUrl = @ImageUrl
			FROM dbo.Venues as v inner join dbo.Locations as l
				on v.LocationId = l.Id
				inner join dbo.Users as u
					on v.CreatedBy = u.Id
				inner join dbo.Users
					on v.ModifiedBy = u.Id
				
			Where v.Id = @Id 
END
