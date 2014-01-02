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
-- Create date: 30 Dec 2013
-- Description:	Inserts a record into tblAuditLog for an update to tblQuestions
-- =============================================
CREATE TRIGGER dbo.trQuestionsOnUpdate
   ON dbo.tblQuestions
   AFTER UPDATE
AS 
BEGIN
	--Declare the variables needed for the audit log stored procedure
	Declare @AffectedTable nvarchar(50)
	Declare @AffectedRecordID int
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime

	--Declare the variables needed to determine which values have been changed.
	Declare @ID int
	Declare @OldActive bit
	Declare @NewActive bit
	Declare @OldQuestionTitle nvarchar(100)
	Declare @NewQuestionTitle nvarchar(100)
	Declare @OldQuestionSubject nvarchar(MAX)
	Declare @NewQuestionSubject nvarchar(MAX)
	Declare @OldDifficulty int
	Declare @NewDifficulty int

	Set @AffectedTable = 'tblQUestions'
	Set @LastModifiedDate = GETDATE()

    -- Load the updated records into temporary table
    Select * Into #TempTable From inserted
     
    -- Loop thru the records in temp table
    While(Exists(Select ID from #TempTable))
    Begin   
        -- Select first row data from temp table
        Select Top(1) 
			@ID = ID, 
			@NewActive = Active, 
			@NewQuestionTitle = QuestionTitle,
			@NewQuestionSubject = QuestionSubject,
			@NewDifficulty = Difficulty,
			@LastModifiedByID = LastModifiedByID
        from #TempTable
           
        -- Select the corresponding row from deleted table
        Select 
			@OldActive = Active, 
			@OldQuestionTitle = QuestionTitle,
			@OldQuestionSubject = QuestionSubject,
			@OldDifficulty = Difficulty 
        from deleted where ID = @ID
		
		--Set the variables that could change from loop to loop
		Set @AffectedRecordID = @ID

        if(@OldActive <> @NewActive)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'Active', 
				@AffectedRecordID,
				'Question Status Update',
				@OldActive,
				@NewActive,
				@LastModifiedByID,
				@LastModifiedDate
		End

        if(@OldQuestionTitle <> @NewQuestionTitle)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'QuestionTitle', 
				@AffectedRecordID,
				'Question Title Update',
				@OldQuestionTitle,
				@NewQuestionTitle,
				@LastModifiedByID,
				@LastModifiedDate
		End
		
        if(@OldQuestionSubject <> @NewQuestionSubject)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'QuestionSubject', 
				@AffectedRecordID,
				'Question Subject Update',
				@OldQuestionSubject,
				@NewQuestionSubject,
				@LastModifiedByID,
				@LastModifiedDate
		End   

		
        if(@OldDifficulty <> @NewDifficulty)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'Difficulty', 
				@AffectedRecordID,
				'Question Difficulty Update',
				@OldDifficulty,
				@NewDifficulty,
				@LastModifiedByID,
				@LastModifiedDate
		End

        -- Delete the row from temp table, so we can move to the next row
        Delete from #TempTable where ID = @ID
    
	End --While loop
END
GO
