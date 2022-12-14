USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Newsletters_Update]    Script Date: 8/14/2022 11:45:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tawni Magie>
-- Create date: <05/10/2022>
-- Description:	<Newsletters_Update >
-- Code Reviewer:


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================


ALTER proc [dbo].[Newsletters_Update]
				@Id int
				,@TemplateId int
				,@Name nvarchar(100)
				,@CoverPhoto nvarchar(255)
				,@DateToPublish datetime2(7)
				,@DateToExpire datetime2(7)
				,@CreatedBy int



as

/*

Declare @Id int = 3;

Declare 

				@TemplateId int = 3
				,@Name nvarchar(100) = 'Spring Seasonal Newsletter'
				,@CoverPhoto nvarchar(255) = 'need screenshot of template here'
				,@DateToPublish datetime2(7) = '2022-04-13'
				,@DateToExpire datetime2(7) = '2022-10-13'
				,@CreatedBy int = 260

Execute dbo.Newsletters_Update

				@Id
				,@TemplateId
				,@Name
				,@CoverPhoto
				,@DateToPublish
				,@DateToExpire
				,@CreatedBy
				

EXECUTE [dbo].[Newsletters_Select_ById] @Id 




*/

Begin


DECLARE @DateNow datetime2(7) = getutcdate();

UPDATE		[dbo].[Newsletters]

SET 
			[TemplateId] = @TemplateId
			,[Name] = @Name
			,[CoverPhoto] = @CoverPhoto
			,[DateToPublish] = @DateToPublish
			,[DateToExpire] = @DateToExpire
			,[DateModified] = @DateNow
			,[CreatedBy] = @CreatedBy

Where		[Id] = @Id

End