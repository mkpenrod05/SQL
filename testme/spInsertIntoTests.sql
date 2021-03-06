USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spInsertIntoTests]    Script Date: 1/2/2014 1:58:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 29 Dec 2013
-- Description:	Inserts a record into tblTests
-- =============================================
ALTER PROCEDURE [dbo].[spInsertIntoTests]
	@UserID int,
	@CategoryID int,
	@TestName nvarchar(100)
AS
BEGIN
	IF 
		exists(
			SELECT 1 FROM dbo.tblTests
			WHERE TestName = @TestName and UserID = @UserID
		)
		BEGIN
			SELECT 'A test with this name already exists!'
			AS DBErrorMessage
			RETURN
		END
	ELSE
		Insert Into dbo.tblTests (
			UserID,
			CategoryID,
			TestName,
			LastModifiedByID
		) Values (
			@UserID,
			@CategoryID,
			@TestName,
			@UserID
		)
END
