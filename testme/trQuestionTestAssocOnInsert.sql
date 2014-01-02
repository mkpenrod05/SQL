-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 31 Dec 2013
-- Description:	Adds a record to tblAuditLog after a new insert into tblQuestionTestAssoc.
-- =============================================
CREATE TRIGGER dbo.trQuestionTestAssocOnInsert
   ON dbo.tblQuestionTestAssoc
   AFTER INSERT
AS 
BEGIN
	Declare @ID int
	Declare @QuestionID int
	Declare @TestID int
	Declare @NewValue nvarchar(50)
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime = GETDATE()

	Select 
		@ID = ID, 
		@QuestionID = QuestionID,
		@TestID = TestID, 
		@LastModifiedByID = LastModifiedByID
	From inserted

	Set @NewValue = 'Question ID: ' + CAST(@QuestionID As nvarchar(50)) + ', Test ID: ' + CAST(@TestID As nvarchar(50))

	Execute spInsertIntoAuditLog 
		'tblQuestionTestAssoc', 
		'QuestionID',
		@ID, 
		'New Question-Test Association', 
		'', 
		@NewValue, 
		@LastModifiedByID, 
		@LastModifiedDate
END
GO
