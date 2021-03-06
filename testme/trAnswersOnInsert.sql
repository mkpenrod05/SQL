USE [testme]
GO
/****** Object:  Trigger [dbo].[trAnswersOnInsert]    Script Date: 1/3/2014 2:32:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2013
-- Description:	Inserts a record into tblAuditLog for a new insert into tblAnswers
-- =============================================
ALTER TRIGGER [dbo].[trAnswersOnInsert]
   ON [dbo].[tblAnswers]
   AFTER INSERT
AS 
BEGIN
	Declare @ID int
	Declare @NewValue nvarchar(50)
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime = GETDATE()

	Select @ID = ID, 
		@NewValue = AnswerSubject, 
		@LastModifiedByID = LastModifiedByID
	From inserted

	Execute spInsertIntoAuditLog 
		'tblAnswers', 
		'AnswerSubject', 
		@ID, 
		'New Answer Inserted', 
		'', 
		@NewValue, 
		@LastModifiedByID, 
		@LastModifiedDate
END
