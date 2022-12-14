USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_Insert]    Script Date: 8/14/2022 1:40:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







ALTER proc [dbo].[Surveys_Insert]
			@Name nvarchar(100)
			,@Description nvarchar(2000)
			,@ImageUrl varchar(255)
			,@StatusId int
			,@SurveyTypeId int
			,@CreatedBy int
			,@Id int OUTPUT

/*-------------------------------TEST--------------------------------

Declare @Id int = 0;

Declare @Name nvarchar(100)            ='How to become Dev'
		,@Description nvarchar(2000)   ='How to become Dev Description'
		,@ImageUrl varchar(255)		   ='https://th.bing.com/th/id/OIP.sGmnmR9wEXXxFjBDT-Dw_gHaEK?pid=ImgDet&rs=1'
		,@StatusId int                 ='1'
		,@SurveyTypeId int             ='1'
		,@CreatedBy int                ='1'

Execute dbo.Surveys_Insert          @Name
									,@Description
									,ImageUrl
									,@StatusId
									,@SurveyTypeId
									,@CreatedBy
									,@Id OUTPUT

Select *
from dbo.Surveys

*/

as



BEGIN 


				INSERT INTO dbo.Surveys
						   ([Name]
						   ,[Description]
						   ,[ImageUrl]
						   ,[StatusId]
						   ,[SurveyTypeId]
						   ,[CreatedBy])

				VALUES		(@Name
							,@Description
							,@ImageUrl
							,@StatusId
							,@SurveyTypeId
							,@CreatedBy)

				SET @Id = SCOPE_IDENTITY()


END