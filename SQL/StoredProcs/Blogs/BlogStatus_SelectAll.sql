USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[BlogStatus_SelectAll]    Script Date: 8/9/2022 2:26:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Alicia Moreno
-- Create date: 4/27/2022
-- Description: Blog status lookup reference table for BLOGS
-- Code Reviewer: ZACH MUSGRAVE

-- MODIFIED BY: 
-- MODIFIED DATE: 
-- Code Reviewer:
-- Note:
-- =============================================

ALTER proc [dbo].[BlogStatus_SelectAll]
as

/*



Execute [dbo].[BlogStatus_SelectAll] 
										
*/

BEGIN


SELECT Id
		,Name
		
		FROM dbo.BlogStatus

		

END
