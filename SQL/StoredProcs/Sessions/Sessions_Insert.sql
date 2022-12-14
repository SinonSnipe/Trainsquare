USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Sessions_Insert]    Script Date: 8/14/2022 1:30:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author:		Elizabeth Phung
-- Create date: 3/23/22
-- Description:	Inserts a single record into dbo.Sessions and outputs its new Id
-- Code Reviewer: Matthew Golben


-- MODIFIED BY: Elizabeth Phung
-- MODIFIED DATE: 4/7/22
-- Code Reviewer: Enrique Lozano
-- Note: 
ALTER proc [dbo].[Sessions_Insert]
					@Id int OUTPUT
					,@WorkshopId int
					,@TotalSlots int
					,@OpenSlots int
					,@Date datetime2(7)
					,@StartTime time(0)
					,@EndTime time(0)
					,@User int

as

/*

			Declare @Id int = 0
					,@WorkshopId int = 10
					,@TotalSlots int = 20
					,@OpenSlots int = 20
					,@Date datetime2(7) = '2022-04-10 00:00:00.0000000'
					,@StartTime time(0) = '12:00:00'
					,@EndTime time(0) = '13:00:00'
					,@CreatedBy int = 6

			Execute dbo.Sessions_Insert
						@Id output
						,@WorkshopId 
						,@TotalSlots
						,@OpenSlots
						,@Date 
						,@StartTime 
						,@EndTime 
						,@CreatedBy
			
			Select	Id
					,WorkShopId
					,TotalSlots
					,OpenSlots
					,[Date]
					,StartTime 
					,EndTime
					,DateCreated
					,CreatedBy
					,ModifiedBy
			From dbo.Sessions
			Where Id = @Id

*/

BEGIN
		
				Insert Into dbo.Sessions (WorkShopId
											,TotalSlots
											,OpenSlots
											,[Date]
											,StartTime 
											,EndTime
											,CreatedBy
											,ModifiedBy)
				Values (@WorkshopId 
						,@TotalSlots
						,@OpenSlots 
						,@Date 
						,@StartTime 
						,@EndTime 
						,@User
						,@User)
				Set @Id = SCOPE_IDENTITY()
END

