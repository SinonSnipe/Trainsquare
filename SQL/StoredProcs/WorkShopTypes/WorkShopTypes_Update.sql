USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopTypes_Update]    Script Date: 8/15/2022 12:11:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Update WorkshopTypes ,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShopTypes_Update]
		@Id int 
		,@Name nvarchar(100)


/*
	Declare @Id int = 4
			,@Name nvarchar(100) = 'Jordan Alferez'


	Execute dbo.WorkShopTypes_Update @Id 
								,@Name 


*/

as
BEGIN


	UPDATE dbo.WorkShopTypes
	SET		[Name] = @Name

	WHERE Id = @Id 

END