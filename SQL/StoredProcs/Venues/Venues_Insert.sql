USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_Insert]    Script Date: 8/14/2022 2:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Jared Williams
-- Create date: 04/04/2022
-- Description: Insert proc for Venues
-- Code Reviewer: Sagan Jackson
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER proc [dbo].[Venues_Insert] 
				@Id int OUTPUT 
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
			    @Id int
				,@Name nvarchar(255) = 'Test VenueV2'
				,@Description nvarchar(4000) = 'Test DescriptionV2' 
				,@LocationId int = 1 
				,@Url nvarchar(255) = 'Test url goes hereV2' 
				,@CreatedBy int = 1 
				,@ModifiedBy int = 1
				,@ImageUrl nvarchar(255) = 'https://www.pymnts.com/wp-content/uploads/2018/02/starbuckslandlords.jpg'
				

		EXEC dbo.Venues_Insert
				@Id OUTPUT
				,@Name
				,@Description
				,@LocationId
				,@Url
				,@CreatedBy
				,@ModifiedBy
				,@ImageUrl
				
		
		SELECT *
		FROM dbo.Venues
*/
BEGIN 
		INSERT INTO dbo.Venues 
				(Name 
				,Description
				,LocationId 
				,Url 
				,CreatedBy 
				,ModifiedBy
				,ImageUrl) 
		VALUES 
				(@Name 
				,@Description 
				,@LocationId 
				,@Url 
				,@CreatedBy 
				,@ModifiedBy
				,@ImageUrl) 

		SET @Id = SCOPE_IDENTITY() 
		
END
