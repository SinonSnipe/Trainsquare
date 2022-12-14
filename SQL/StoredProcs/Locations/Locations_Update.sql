USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Locations_Update]    Script Date: 8/9/2022 4:37:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Matthew Golben
-- Create date: 4/11/2022
-- Description:	Basic procedure for Updating Locations Table 
-- Code Reviewer: Stephanie Zavala


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================



		ALTER   PROC [dbo].[Locations_Update]
				@Id int 
				,@LocationType nvarchar(50)
				,@LineOne nvarchar(255)
				,@LineTwo nvarchar(255)
				,@City nvarchar(255)
				,@Zip nvarchar(50)
				,@State nvarchar(10)
				,@Latitude float
				,@Longitude float
				,@ModifiedBy int
			   

AS

/*  ======== TEST CODE =========
	
		DECLARE @Id int = 8;

		EXECUTE dbo.Locations_Select_ById
					@Id

		DECLARE 
			@LocationType nvarchar(50) = 'Recreation'
           ,@LineOne nvarchar(255) = 'L2 Dubai Mall'
           ,@LineTwo nvarchar(255) = 'Downtown Dubai'
           ,@City nvarchar(255) = 'Dubai'
           ,@Zip nvarchar(50) = ''
           ,@State nvarchar(10) = 'DU'
           ,@Latitude float = 25.1975
           ,@Longitude float = 55.2785
           ,@ModifiedBy int = 233
		   

		EXECUTE dbo.Locations_Update
			@Id
			,@LocationType
			,@LineOne
			,@LineTwo
			,@City
			,@Zip
			,@State
			,@Latitude
			,@Longitude
			,@ModifiedBy

		
		EXECUTE dbo.Locations_Select_ById
							@Id
	

*/

BEGIN

	DECLARE @ThisDate datetime2 = getutcdate();

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
		 WHERE Id = @Id
END
