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
-- Description:	Inserts a new record into tblAuditLog
-- =============================================
CREATE PROCEDURE dbo.spInsertIntoAuditLog
	@AffectedTable nvarchar(50),
	@AffectedColumn nvarchar(50),
	@AffectedRecordID int,
	@ActionType nvarchar(50),
	@OldValue nvarchar(MAX),
	@NewValue nvarchar(MAX),
	@LastModifiedByID int,
	@LastModifiedDate datetime
AS
BEGIN
	INSERT INTO dbo.tblAuditLog (
		AffectedTable,
		AffectedColumn,
		AffectedRecordID,
		ActionType,
		OldValue,
		NewValue,
		LastModifiedByID,
		LastModifiedDate
	) VALUES (
		@AffectedTable,
		@AffectedColumn,
		@AffectedRecordID,
		@ActionType,
		@OldValue,
		@NewValue,
		@LastModifiedByID,
		@LastModifiedDate
	)
END
GO
