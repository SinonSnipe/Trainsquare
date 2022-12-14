USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[Surveys_Update]    Script Date: 8/14/2022 1:40:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







ALTER proc [dbo].[Surveys_Update]
			@Name nvarchar(100)
			,@Description nvarchar(2000)
			,@ImageUrl varchar(255)
			,@StatusId int
			,@SurveyTypeId int
			,@CreatedBy int
			,@Id int

/*---------------------TEST-----------------------

Declare @Id int = 81;

Declare @Name nvarchar(100)            ='How to become Dev part 2'
		,@Description nvarchar(2000)   ='How to become Dev Description part 2'
		,@ImageUrl varchar(255)		   ='https://www.alpenwild.com/images/trip/gallery/915_sth0051554_1-min.jpg'
		,@StatusId int                 ='1'
		,@SurveyTypeId int             ='1'
		,@CreatedBy int                ='1'

Select *
from dbo.Surveys
Where Id = @Id

Execute dbo.Surveys_Update          @Name
									,@Description
									,@ImageUrl
									,@StatusId
									,@SurveyTypeId
									,@CreatedBy
									,@Id

Select *
from dbo.Surveys
Where Id = @Id

*/


as


BEGIN


			Declare @datNow datetime2 = getutcdate()

			UPDATE dbo.Surveys
			SET [Name] = @Name
				,[Description] = @Description
				,[ImageUrl] = @ImageUrl
				,[StatusId] = @StatusId
				,[SurveyTypeId] = @SurveyTypeId
				,[CreatedBy] = @CreatedBy
			WHERE Id = @Id


END