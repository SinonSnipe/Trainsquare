USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[BlogTypes_SelectAll]    Script Date: 8/9/2022 2:26:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--AUTHOR: FRANK VILARDI
--CREATE DATE: 3/24/2022
--DESCRIPTION: The categories of the blogs. 
--These will be application specific so you can generate different types that would make sense for the given application.

--CODE REVIEWER: Elizabeth Phung
--MODIFIED BY: 
--MODIFIED DATE: 
--CODE REVIEWER:
--NOTE:

ALTER proc [dbo].[BlogTypes_SelectAll] 										
as

/*



Execute [dbo].[BlogTypes_SelectAll] 
										
*/

BEGIN


SELECT Id
		,Name
		
		FROM dbo.BlogTypes

		

END