USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopTypes_Select_ById]    Script Date: 8/15/2022 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Select  WorkshopTypes by Id,,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShopTypes_Select_ById]
		@Id int

/*
	Declare @Id int = 2

	Execute dbo.WorkShopTypes_Select_ById @Id 

*/

as
BEGIN

	Select [Id]
			,[Name]
	FROM dbo.WorkShopTypes
	WHERE Id = @Id 

END 
