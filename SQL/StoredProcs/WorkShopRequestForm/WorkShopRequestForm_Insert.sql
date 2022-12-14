USE [Trainsquare]
GO
/****** Object:  StoredProcedure [dbo].[WorkShopRequestForm_Insert]    Script Date: 8/15/2022 12:07:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[WorkShopRequestForm_Insert]
@InstructorId int OUTPUT,
@Name nvarchar(50),
@Email nvarchar(50),
@Topic nvarchar(50),
@ShortDescription nvarchar(200)


AS


/*------TEST CODE-----------
Declare @InstructorId int = 0
		,@Name nvarchar(50) =  'new'
		,@Email nvarchar(50)  = 'drew@example.com'
		,@Topic nvarchar(50) = 'Intro to Frontend Languages'
		,@ShortDescription nvarchar(200)  = 'I would like to learn the differences and unique features for some Frontend languages like C#, python, or GoLang and I think it would make for a great workshop series!'
		
	
Execute dbo.WorkShopRequestForm_Insert
	         @InstructorId 
			 ,@Name
			,@Email  
			,@Topic
			,@ShortDescription  




Select *
From dbo.WorkShopRequestForm 
*/

Begin

INSERT INTO [dbo].[WorkshopRequestForm]
           ([Name]
		   ,[Email]
           ,[Topic]
           ,[ShortDescription]
          )
     VALUES
			
			(@Name  
			,@Email
			,@Topic 
			,@ShortDescription 
			) 
			
	SET      @InstructorId = SCOPE_IDENTITY()
End






