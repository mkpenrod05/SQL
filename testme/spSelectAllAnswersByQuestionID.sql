
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 03 Jan 2014
-- Description:	Used to select all records from tblAnswers for a specific QuestionID.
-- =============================================
CREATE PROCEDURE dbo.spSelectAllAnswersByQuestionID
	@QuestionID int
AS
BEGIN
	Select *
	From dbo.tblAnswers
	Where (QuestionID = @QuestionID)
END
GO
