USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopStatus_SelectAll]    Script Date: 8/15/2022 12:09:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Matias Montijo>
-- Create date: <4/2/22,,>
-- Description: <Select All WorkShopStatus ,,>
-- Code Reviewer:

-- MODIFIED BY: Matias Montijo
-- MODIFIED DATE:4/2/22
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[WorkShopStatus_SelectAll]
		

/*
	

	Execute dbo.WorkShopStatus_SelectAll 

*/

as
BEGIN

	

	SELECT [Id]
			,[Name]

	FROM dbo.WorkShopStatus
	

END