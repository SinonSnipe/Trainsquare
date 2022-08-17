USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopTypes_SelectAll]    Script Date: 8/15/2022 12:11:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Select All WorkshopTypes ,,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShopTypes_SelectAll]
		

/*
	

	Execute dbo.WorkShopTypes_SelectAll 

*/

as
BEGIN

	

	SELECT [Id]
			,[Name]

	FROM dbo.WorkShopTypes
	

END