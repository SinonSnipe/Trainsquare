USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_Update_V2]    Script Date: 8/14/2022 2:22:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Matthew Golben
-- Create date: 05/10/2022
-- Description: Updates to both Venue and Location by Venue LocationId
-- Code Reviewer: Jared Williams
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER   proc [dbo].[Venues_Update_V2]	
				 @Id int 
				,@Name nvarchar(255) 
				,@Description nvarchar(4000)
				,@Url nvarchar(255) 
				,@ModifiedBy int
				,@ImageUrl nvarchar(255)
					,@LocationType nvarchar(50)
					,@LineOne nvarchar(255)
					,@LineTwo nvarchar(255)
					,@City nvarchar(255)
					,@Zip nvarchar(50)
					,@State nvarchar(10)
					,@Latitude float
					,@Longitude float

				
AS


/*---Test Code---	 

		EXEC dbo.Venues_SelectAll_V2

			DECLARE @Id int = 92;
            DECLARE
				@Name nvarchar(255) = 'Look Ma! Making Changes!'
				,@Description nvarchar(4000) = 'Dont be suspicious, dont be suspicious' 
				,@Url nvarchar(255) = 'This is the test URL Ya Turkey' 
				,@ModifiedBy int = 260 
				,@ImageUrl nvarchar(255) = 'https://upload.wikimedia.org/wikipedia/en/6/6d/Teenage_Mutant_Ninja_Turtles_%28Kevin_Eastman%27s_art%29.jpg'
					,@LocationType nvarchar(50) = 'Business'
					,@LineOne nvarchar(255) = '111 Not Real Road'
					,@LineTwo nvarchar(255) = 'Apt B'
					,@City nvarchar(255) = 'Fake City'
					,@Zip nvarchar(50) = '14365'
					,@State nvarchar(10) = 'AE'
					,@Latitude float = 80.4121
					,@Longitude float = -90.5903

            
			EXEC dbo.Venues_Update_v2
						 @Id 
						,@Name
						,@Description
						,@Url
						,@ModifiedBy
						,@ImageUrl 
								,@LocationType 
								,@LineOne 
								,@LineTwo 
								,@City 
								,@Zip 
								,@State 
								,@Latitude 
								,@Longitude 

			
			EXEC dbo.Venues_SelectAll_V2


*/



BEGIN 


	DECLARE @ThisDate datetime2 = getutcdate();


				UPDATE 
					dbo.Venues 
				SET 
					Name = @Name 
					,Description = @Description 
					,Url = @Url 
					,ModifiedBy = @ModifiedBy
					,DateModified = @ThisDate
					,ImageUrl = @ImageUrl
				
				Where Id = @Id 



	DECLARE @LocationId int = (SELECT LocationId FROM dbo.Venues WHERE Id = @Id)
	DECLARE @LocationTypeId int = (SELECT Id FROM dbo.LocationTypes WHERE [Name] = @LocationType)
	DECLARE @StateId int = (SELECT Id FROM dbo.States WHERE [Name] = @State)

			UPDATE [dbo].[Locations]
			   SET [LocationTypeId] = @LocationTypeId
				  ,[LineOne] = @LineOne
				  ,[LineTwo] = @LineTwo
				  ,[City] = @City
				  ,[Zip] = @Zip
				  ,[StateId] = @StateId
				  ,[Latitude] = @Latitude
				  ,[Longitude] = @Longitude
				  ,[DateModified] = @ThisDate
				  ,[ModifiedBy] = @ModifiedBy
			 WHERE Id = @LocationId


END

