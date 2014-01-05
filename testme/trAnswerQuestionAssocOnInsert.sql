
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2013
-- Description:	Adds a record to tblAuditLog after a new insert 
-- into tblAnswerQuestionAssoc.
-- =============================================
CREATE TRIGGER dbo.trAnswerQuestionAssocOnInsert
   ON dbo.tblAnswerQuestionAssoc
   AFTER INSERT
AS 
BEGIN
	Declare @ID int
	Declare @AnswerID int
	Declare @QuestionID int
	Declare @NewValue nvarchar(50)
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime = GETDATE()

	Select 
		@ID = ID, 
		@AnswerID = AnswerID,
		@QuestionID = QuestionID, 
		@LastModifiedByID = LastModifiedByID
	From inserted

	Set @NewValue = 'Answer ID: ' + CAST(@AnswerID As nvarchar(50)) + 
		', Question ID: ' + CAST(@QuestionID As nvarchar(50))

	Execute spInsertIntoAuditLog 
		'tblAnswerQuestionAssoc', 
		'AnswerID',
		@ID, 
		'New Answer-Question Association', 
		'', 
		@NewValue, 
		@LastModifiedByID, 
		@LastModifiedDate
END
GO
