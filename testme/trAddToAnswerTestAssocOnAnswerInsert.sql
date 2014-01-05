
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2013
-- Description:	Used to add a record to tblAnswerQuestionAssoc after 
-- a new answer is added.
-- =============================================
ALTER TRIGGER dbo.trAddToAnswerTestAssocOnAnswerInsert
   ON dbo.tblAnswers
   AFTER INSERT
AS 
BEGIN
	Declare @QuestionID int
	Declare @AnswerID int
	Declare @UserID int

	Select
		@QuestionID = QuestionID,
		@AnswerID = ID,
		@UserID = UserID
	From inserted

	Insert Into dbo.tblAnswerQuestionAssoc(
		AnswerID,
		QuestionID,
		LastModifiedByID
	) Values (
		@AnswerID,
		@QuestionID,
		@UserID
	)
END
GO
