-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2013
-- Description:	Inserts a record into tblAnswers for a given user and a given question.
-- =============================================
CREATE PROCEDURE dbo.spInsertIntoAnswers
	@UserID int,
	@QuestionID int,
	@AnswerSubject nvarchar(max),
	@IsCorrectAnswer bit
AS
BEGIN
	IF 
		exists(
			SELECT 1 FROM dbo.tblAnswers
			WHERE QuestionID = @QuestionID and AnswerSubject = @AnswerSubject
		)
		BEGIN
			SELECT 'This answer already exists for this question!'
			AS DBErrorMessage
			RETURN
		END
	ELSE
		Insert Into dbo.tblAnswers(
			UserID,
			QuestionID,
			AnswerSubject,
			IsCorrectAnswer,
			LastModifiedByID
		) Values (
			@UserID,
			@QuestionID,
			@AnswerSubject,
			@IsCorrectAnswer,
			@UserID
		)
END
GO
