USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Newsletters_Insert]    Script Date: 8/14/2022 11:44:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <04/01/2022>
-- Description:	<Newsletters Insert>
-- Code Reviewer: Elizabeth Phung


-- MODIFIED BY: 
-- MODIFIED DATE:
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER proc [dbo].[Newsletters_Insert]
				@Id int OUTPUT
				,@TemplateId int
				,@Name nvarchar(100)
				,@CoverPhoto nvarchar(255)
				,@DateToPublish datetime2(7)
				,@DateToExpire datetime2(7)
				,@CreatedBy int
				


AS

/*

Declare @Id int = 0

Declare
				@TemplateId int = 1
				,@Name nvarchar(100) = 'News 4/6/2022'
				,@CoverPhoto nvarchar(255) = 'Need photo here'
				,@DateToPublish datetime2(7) = '2022-04-10'
				,@DateToExpire datetime2(7) = '2022-10-10'
				,@CreatedBy int = 1
	

Execute dbo.Newsletters_Insert

				@Id OUT
				,@TemplateId
				,@Name
				,@CoverPhoto
				,@DateToPublish
				,@DateToExpire
				,@CreatedBy
			

				Execute dbo.Newsletters_Select_ById @Id
			



*/


BEGIN
	

INSERT INTO [dbo].[Newsletters]
           ([TemplateId]
           ,[Name]
           ,[CoverPhoto]
           ,[DateToPublish]
           ,[DateToExpire]
           ,[CreatedBy])
     VALUES
           (@TemplateId
			,@Name
			,@CoverPhoto
			,@DateToPublish
			,@DateToExpire
			,@CreatedBy)

SET @Id = SCOPE_IDENTITY()


	           

END