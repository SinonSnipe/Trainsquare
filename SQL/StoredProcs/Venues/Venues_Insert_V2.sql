USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Venues_Insert_V2]    Script Date: 8/14/2022 2:21:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Matthew Golben 
-- Create date: 05/09/2022
-- Description: Inserting for Venues to include Location Data
-- Code Reviewer: Jared Williams
-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================
ALTER   proc [dbo].[Venues_Insert_V2] 
				 @Name nvarchar(255)
				,@Description nvarchar(4000) 
				,@Url nvarchar(255) 
				,@CreatedBy int 
				,@ImageUrl nvarchar(255)
					,@LocationType nvarchar(50)
					,@LineOne nvarchar(255)
					,@LineTwo nvarchar(255)
					,@City nvarchar(255)
					,@Zip nvarchar(50)
					,@State nvarchar(10)
					,@Latitude float
					,@Longitude float
					,@Id int OUTPUT
				
				
AS


/*---Test Code---


		EXEC dbo.Venues_SelectAll_V2

		DECLARE @Id int = 0; 

			   
			DECLARE
				@Name nvarchar(255) = 'Insert Procedure Version 2'
				,@Description nvarchar(4000) = 'Dont be suspicious, dont be suspicious' 
				,@Url nvarchar(255) = 'This is the test URL' 
				,@CreatedBy int = 260 
				,@ImageUrl nvarchar(255) = 'https://upload.wikimedia.org/wikipedia/en/6/6d/Teenage_Mutant_Ninja_Turtles_%28Kevin_Eastman%27s_art%29.jpg'
					,@LocationType nvarchar(50) = 'Business'
					,@LineOne nvarchar(255) = '111 Not Real Road'
					,@LineTwo nvarchar(255) = 'Apt B'
					,@City nvarchar(255) = 'Fake City'
					,@Zip nvarchar(50) = '14365'
					,@State nvarchar(10) = 'AE'
					,@Latitude float = 80.4121
					,@Longitude float = -90.5903

		EXEC dbo.Venues_Insert_V2
				@Name
				,@Description
				,@Url
				,@CreatedBy
				,@ImageUrl
					,@LocationType 
					,@LineOne
					,@LineTwo
					,@City
					,@Zip
					,@State
					,@Latitude
					,@Longitude
				,@Id OUTPUT

				
		
		EXEC dbo.Venues_SelectAll_V2




*/


BEGIN 

		DECLARE @LocationTypeId int = (SELECT Id FROM dbo.LocationTypes WHERE [Name] = @LocationType)
		DECLARE @StateId int = (SELECT Id FROM dbo.States WHERE [Name] = @State)

					INSERT INTO [dbo].[Locations]
							   ([LocationTypeId]
							   ,[LineOne]
							   ,[LineTwo]
							   ,[City]
							   ,[Zip]
							   ,[StateId]
							   ,[Latitude]
							   ,[Longitude]
							   ,[CreatedBy])
						 VALUES
							   (@LocationTypeId
								,@LineOne
								,@LineTwo
								,@City
								,@Zip
								,@StateId
								,@Latitude
								,@Longitude
								,@CreatedBy)

				DECLARE @LocationId int = SCOPE_IDENTITY() 


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
								,@CreatedBy
								,@ImageUrl) 

				SET @Id = SCOPE_IDENTITY() 
		
END
