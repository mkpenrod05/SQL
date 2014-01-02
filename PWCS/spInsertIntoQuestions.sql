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
-- Author:		Michael Cp. Penrod
-- Create date: 30 Dec 2013
-- Description:	Used to insert a new record into tblQuestions.
-- =============================================
CREATE PROCEDURE dbo.spInsertIntoQuestions
	@QuestionTitle nvarchar(100),
	@QuestionSubject nvarchar(MAX),
	@Difficulty int,
	@UserID int,
	@TestID int
AS
BEGIN
	
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
GO
