USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Cart_SelectByUserId]    Script Date: 8/9/2022 2:30:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Rafael Lynch
-- Create date: 5/25/2022
-- Description: Get Base Cart By User Id
-- Code Reviewer: Jake Lowrance

-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer:
-- Note:
-- =============================================


ALTER PROCEDURE [dbo].[Cart_SelectByUserId] 
								@UserId INT
AS

/* ----- Test Code -----
	
	DECLARE	@UserId INT = 1

	EXECUTE [dbo].[Cart_SelectByUserId] 
								@UserId

----- End Test Code -----
*/

BEGIN
	
	SELECT Id
		  ,CustomerId

	FROM dbo.Cart
	WHERE CustomerId = @UserId

END
