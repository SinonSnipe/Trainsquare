USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopStatus_Update]    Script Date: 8/15/2022 12:09:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Update WorkShopStatus ,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShopStatus_Update]
		@Id int 
		,@Name nvarchar(100)


/*
	Declare @Id int = 4
			,@Name nvarchar(100) = 'Joe Alferez'


	Execute dbo.WorkShopStatus_Update @Id 
								,@Name 


*/

as
BEGIN


	UPDATE dbo.WorkShopStatus
	SET		[Name] = @Name

	WHERE Id = @Id 

END