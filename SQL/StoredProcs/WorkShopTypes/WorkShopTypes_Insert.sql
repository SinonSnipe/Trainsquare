USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopTypes_Insert]    Script Date: 8/15/2022 12:11:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Insert WorkshopTypes ,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[WorkShopTypes_Insert]
		@Id int OUTPUT
		,@Name nvarchar(100)


/*
	Declare @Id int 
			,@Name nvarchar(100) = 'Jordan'


	Execute dbo.WorkShopTypes_Insert @Id OUTPUT
								,@Name 


*/

as
BEGIN

	INSERT INTO dbo.WorkShopTypes
		([Name])

		VALUES
			(@Name)

		SET @Id = SCOPE_IDENTITY()

END