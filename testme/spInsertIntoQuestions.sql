USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spInsertIntoQuestions]    Script Date: 1/2/2014 2:01:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael Cp. Penrod
-- Create date: 30 Dec 2013
-- Description:	Used to insert a new record into tblQuestions.
-- =============================================
ALTER PROCEDURE [dbo].[spInsertIntoQuestions]
	@QuestionTitle nvarchar(100),
	@QuestionSubject nvarchar(MAX),
	@Difficulty int,
	@UserID int,
	@TestID int
AS
BEGIN
	IF 
		exists(
			SELECT 1 FROM dbo.tblQuestions
			WHERE QuestionTitle = @QuestionTitle and UserID = @UserID
		)
		BEGIN
			SELECT 'This title already exists for another question!'
			AS DBErrorMessage
			RETURN
		END
	ELSE IF	
		exists(
			SELECT 1 FROM dbo.tblQuestions
			WHERE QuestionSubject = @QuestionSubject and UserID = @UserID
		)
		BEGIN
			SELECT 'This question already exists!'
			AS DBErrorMessage
			RETURN
		END
	ELSE
		Declare @LastModifiedByID int = @UserID

		Insert Into dbo.tblQuestions (
			QuestionTitle,
			QuestionSubject,
			Difficulty,
			UserID,
			TestID,
			LastModifiedByID
		) Values (
			@QuestionTitle,
			@QuestionSubject,
			@Difficulty,
			@UserID,
			@TestID,
			@LastModifiedByID
		)
END
