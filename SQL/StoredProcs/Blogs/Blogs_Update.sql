USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Blogs_Update]    Script Date: 8/9/2022 2:26:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Alicia Moreno
-- Create date: 4/02/2022
-- Description: Upadate Proc for Blogs
-- Code Reviewer:Zachary Musgrave

-- MODIFIED BY: Alicia Moreno
-- MODIFIED DATE: 4/4/2022
-- Code Reviewer:
-- Note:
-- =============================================


ALTER proc	[dbo].[Blogs_Update]
					@Id int
				   ,@BlogTypeId int
				   ,@AuthorId int
				   ,@Title nvarchar(50)
				   ,@Subject nvarchar(50)
				   ,@Content nvarchar (MAX)
				   ,@IsPublished bit
				   ,@ImageUrl nvarchar(255)
				   ,@DatePublished datetime2
				   ,@StatusId int


/*-----TEST CODE-------


	DECLARE			@Id int = 29

	DECLARE			@BlogTypeId int = 2
				   ,@AuthorId int = 260
				   ,@Title nvarchar(50) = 'Photography Concepts'
				   ,@Subject nvarchar(50) = 'Hobby'
				   ,@Content nvarchar (MAX) = 'This introduction to photography is written for beginners, with several tips and suggestions to take your skills as far as possible. However, writing an introduction to photography is like writing an introduction to words; as amazing and important as it is, photography can be almost limitlessly complex. What separates inspiring photographs from ordinary ones, and how can you improve the quality of your own work?'
				   ,@IsPublished bit = 1
				   ,@ImageUrl nvarchar(255) = 'https://tinyurl.com/2p8wjhr7'
				   ,@DatePublished datetime2 = '2021-12-12'
				   ,@StatusId int = 3
	

	Select *
	FROM dbo.Blogs
	WHERE Id = @Id

	Execute		[dbo].[Blogs_Update]		@Id
										   ,@BlogTypeId
										   ,@AuthorId
										   ,@Title
										   ,@Subject
										   ,@Content
										   ,@IsPublished
										   ,@ImageUrl
										   ,@DatePublished
										   ,@StatusId
									
	Select *
	FROM dbo.Blogs
	WHERE Id = @Id


*/

AS


BEGIN


	Declare @datNow datetime2 = getutcdate()

	UPDATE [dbo].[Blogs]
	   SET [BlogTypeId]   = @BlogTypeId
		  ,[Title]         = @Title
		  ,[Subject]       = @Subject
		  ,[Content]       = @Content
		  ,[IsPublished]   = @IsPublished
		  ,[ImageUrl]      = @ImageUrl
		  ,[DatePublished]  = @DatePublished
		  ,[StatusId]	   = @StatusId


	 WHERE Id = @Id

END