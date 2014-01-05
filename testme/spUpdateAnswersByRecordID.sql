
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2013
-- Description:	Used to update tblAnswers by a record ID.
-- =============================================
CREATE PROCEDURE dbo.spUpdateAnswersByRecordID
	@RecordID int,
	@Active bit,
	@AnswerSubject nvarchar(max),
	@IsCorrectAnswer bit
AS
BEGIN
	if 
		exists(
			Select 1 
			From dbo.tblAnswers
			Where (ID = @RecordID 
				and Active = @Active 
				and AnswerSubject = @AnswerSubject
				and IsCorrectAnswer = @IsCorrectAnswer)
		) 
		begin
			Select 'No update required, the values selected have not been modified.' 
				As DBErrorMessage
			return
		end
	else
		Declare @LastModifiedDate datetime
		Set @LastModifiedDate = GETDATE()

		Update dbo.tblAnswers
		Set Active = @Active,
			AnswerSubject = @AnswerSubject,
			IsCorrectAnswer = @IsCorrectAnswer,
			LastModifiedDate = @LastModifiedDate
		Where ID = @RecordID
END
GO
