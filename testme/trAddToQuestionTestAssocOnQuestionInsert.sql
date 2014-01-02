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
-- Description:	Used to add a record to tblQuestionTestAssoc after a new question is added.
-- =============================================
CREATE TRIGGER dbo.trAddToQuestionTestAssocOnQuestionInsert
   ON  dbo.tblQuestions
   AFTER INSERT
AS 
BEGIN
	Declare @QuestionID int
	Declare @TestID int
	Declare @UserID int

	Select
		@QuestionID = ID,
		@TestID = TestID,
		@UserID = UserID
	From inserted

	Insert Into dbo.tblQuestionTestAssoc (
		QuestionID,
		TestID,
		LastModifiedByID
	) Values (
		@QuestionID,
		@TestID,
		@UserID
	)
END
GO
