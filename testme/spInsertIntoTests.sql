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
-- Create date: 29 Dec 2013
-- Description:	Inserts a record into tblTests
-- =============================================
Alter PROCEDURE dbo.spInsertIntoTests
	@UserID int,
	@CategoryID int,
	@TestName nvarchar(100)
AS
BEGIN
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
GO
