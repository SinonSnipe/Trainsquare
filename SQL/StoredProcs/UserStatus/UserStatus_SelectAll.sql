USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[UserStatus_SelectAll]    Script Date: 8/14/2022 2:14:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Author: Amezcua, Abel
-- Create date: 03/23/2022
-- Description:	A select all proc for userStatus
-- Code Reviewer: Charles Oh


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 





ALTER PROC [dbo].[UserStatus_SelectAll]

AS
/*

	EXECUTE [dbo].[UserStatus_SelectAll]

*/
BEGIN


	SELECT [Id]
		  ,[Name]
	  FROM [dbo].[UserStatus]


END
