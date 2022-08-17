USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[EntityTypes_SelectAll]    Script Date: 8/9/2022 4:07:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/24/2022,,>
-- Description: <Select all EntityTypes - Paginated,,>
-- Code Reviewer: Changwoo Lee

-- MODIFIED BY: Frank Vilardi
-- MODIFIED DATE:03/31/2022
-- Code Reviewer: Elizabeth Phung
-- Note: Removed pagination
-- =============================================


ALTER proc [dbo].[EntityTypes_SelectAll]
			

/*

	Execute [dbo].[EntityTypes_SelectAll] 

*/

as
BEGIN

	SELECT  [Id]
			,[Name]		
	FROM	[dbo].[EntityTypes]
		
END
