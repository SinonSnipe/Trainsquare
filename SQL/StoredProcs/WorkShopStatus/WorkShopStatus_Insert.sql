USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopStatus_Insert]    Script Date: 8/15/2022 12:09:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Insert WorkShopStatus ,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc [dbo].[WorkShopStatus_Insert]
		@Id int OUTPUT
		,@Name nvarchar(100)


/*
	Declare @Id int = 1
			,@Name nvarchar(100) = 'JOE'


	Execute dbo.WorkShopStatus_Insert @Id OUTPUT
								,@Name 


*/

as
BEGIN

	INSERT INTO dbo.WorkShopStatus
		([Name])

		VALUES
			(@Name)

		SET @Id = SCOPE_IDENTITY()

END