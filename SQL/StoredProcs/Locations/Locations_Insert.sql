USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Locations_Insert]    Script Date: 8/9/2022 4:37:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Matthew Golben
-- Create date: 4/11/2022
-- Description: Basic procedure for Inserting to Locations Table 
-- Code Reviewer: Stephanie Zavala

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER   PROC [dbo].[Locations_Insert]
			@LocationType nvarchar(50)
           ,@LineOne nvarchar(255)
           ,@LineTwo nvarchar(255)
           ,@City nvarchar(255)
           ,@Zip nvarchar(50)
           ,@State nvarchar(10)
           ,@Latitude float
           ,@Longitude float
           ,@CreatedBy int
		   ,@Id int OUTPUT
AS

/*  ======== TEST CODE =========
	
	DECLARE @pageIndex int = 0
			,@pageSize int = 10

	EXECUTE dbo.Locations_SelectAll
				@pageIndex, @pageSize


		DECLARE @Id int = 0;

		DECLARE
			@LocationType nvarchar(50) = 'Recreation'
           ,@LineOne nvarchar(255) = 'L2 Dubai Mall'
           ,@LineTwo nvarchar(255) = ''
           ,@City nvarchar(255) = 'Duabi'
           ,@Zip nvarchar(50) = ''
           ,@State nvarchar(10) = 'DU'
           ,@Latitude float = 25.1975
           ,@Longitude float = 55.2785
           ,@CreatedBy int = 233
		   

		EXECUTE dbo.Locations_Insert
			@LocationType
			,@LineOne
			,@LineTwo
			,@City
			,@Zip
			,@State
			,@Latitude
			,@Longitude
			,@CreatedBy
			,@Id OUTPUT

		
		EXECUTE dbo.Locations_SelectAll
				@pageIndex, @pageSize

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

		SET @Id = SCOPE_IDENTITY()


END
