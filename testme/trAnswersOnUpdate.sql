
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2013
-- Description:	Inserts a record into tblAuditLog for an update to tblAnswers
-- =============================================
CREATE TRIGGER dbo.trAnswersOnUpdate
   ON dbo.tblAnswers
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
	Declare @OldAnswerSubject nvarchar(max)
	Declare @NewAnswerSubject nvarchar(max)
	Declare @OldIsCorrectAnswer bit
	Declare @NewIsCorrectAnswer bit

	Set @AffectedTable = 'tblAnswers'
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
			@NewAnswerSubject = AnswerSubject,
			@NewIsCorrectAnswer = IsCorrectAnswer,
			@LastModifiedByID = LastModifiedByID
        from #TempTable
           
        -- Select the corresponding row from deleted table
        Select 
			@OldActive = Active, 
			@OldAnswerSubject = AnswerSubject,
			@OldIsCorrectAnswer = IsCorrectAnswer
        from deleted where ID = @ID
		
		--Set the variables that could change from loop to loop
		Set @AffectedRecordID = @ID

        if(@OldActive <> @NewActive)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'Active', 
				@AffectedRecordID,
				'Answer Status Update',
				@OldActive,
				@NewActive,
				@LastModifiedByID,
				@LastModifiedDate
		End

        if(@OldAnswerSubject <> @NewAnswerSubject)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'AnswerSubject', 
				@AffectedRecordID,
				'Answer Subject Update',
				@OldAnswerSubject,
				@NewAnswerSubject,
				@LastModifiedByID,
				@LastModifiedDate
		End
		
        if(@OldIsCorrectAnswer <> @NewIsCorrectAnswer)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'IsCorrectAnswer', 
				@AffectedRecordID,
				'Is Correct Answer Update',
				@OldIsCorrectAnswer,
				@NewIsCorrectAnswer,
				@LastModifiedByID,
				@LastModifiedDate
		End   

        -- Delete the row from temp table, so we can move to the next row
        Delete from #TempTable where ID = @ID
    
	End --While loop
END
GO
