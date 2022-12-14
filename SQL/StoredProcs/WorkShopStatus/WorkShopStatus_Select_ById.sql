USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopStatus_Select_ById]    Script Date: 8/15/2022 12:09:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Select  WorkShopStatus by Id,,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShopStatus_Select_ById]
		@Id int

/*
	Declare @Id int =

	Execute dbo.WorkShopStatus_Select_ById @Id 

*/

as
BEGIN

	Select [Id]
			,[Name]
	FROM dbo.WorkShopStatus
	WHERE Id = @Id 

END 