USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateQuestionsByRecordID]    Script Date: 1/2/2014 10:18:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 02 Jan 2013
-- Description:	Used to update tblQuestions by a record ID.
-- =============================================
ALTER PROCEDURE [dbo].[spUpdateQuestionsByRecordID]
	@RecordID int,
	@Active bit,
	@QuestionTitle nvarchar(100),
	@QuestionSubject nvarchar(max),
	@Difficulty int
AS
BEGIN
	if 
		exists(
			Select 1 
			From dbo.tblQuestions
			Where ID = @RecordID 
				and Active = @Active 
				and QuestionTitle = @QuestionTitle
				and QuestionSubject = @QuestionSubject
				and Difficulty = @Difficulty
		) 
		begin
			Select 'No update required, the values selected have not been modified.' 
				As DBErrorMessage
			return
		end
	else
		Declare @LastModifiedDate datetime
		Set @LastModifiedDate = GETDATE()

		Update dbo.tblQuestions
		Set Active = @Active,
			QuestionTitle = @QuestionTitle,
			QuestionSubject = @QuestionSubject,
			Difficulty = @Difficulty,
			LastModifiedDate = @LastModifiedDate
		Where ID = @RecordID
END
