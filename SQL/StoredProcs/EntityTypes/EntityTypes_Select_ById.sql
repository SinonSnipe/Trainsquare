USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[EntityTypes_Select_ById]    Script Date: 8/9/2022 4:07:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================================================================
-- Author: <Author,,Charles Oh>
-- Create date: <03/23/2022,,>
-- Description: <Select EntityTypes by Id,,>
-- Code Reviewer: Changwoo Lee

-- MODIFIED BY: Charles Oh
-- MODIFIED DATE:03/23/2022
-- Code Reviewer: Changwoo Lee
-- Note:
-- ==========================================================================================================

ALTER proc [dbo].[EntityTypes_Select_ById]
			@Id int

/* ==========================================================================================================

	Declare @Id int = 2

	Execute [dbo].[EntityTypes_Select_ById] @Id

========================================================================================================== */

as
BEGIN

	SELECT  [Id]
			,[Name]
	FROM    [dbo].[EntityTypes]
	WHERE	Id = @Id

END
