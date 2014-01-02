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
-- Description:	Used to insert a new record into tblCategories
-- =============================================
CREATE PROCEDURE dbo.spInsertIntoCategories 
	--@Active bit, --Set in the table by default on Insert
	@CategoryName nvarchar(50),
	@UserID int
	--@AddedDate datetime, --Set in the table by default on Insert
	--@LastModifiedByID int, --Set below to the same value as the UserID
	--@LastModifiedDate datetime --Set below to the current date and time
AS
BEGIN
	
	DECLARE @LastModifiedByID int
	DECLARE @LastModifiedDate datetime

	SET @LastModifiedByID = @UserID
	SET @LastModifiedDate = GETDATE()

	INSERT INTO dbo.tblCategories (
		CategoryName,
		UserID,
		LastModifiedByID,
		LastModifiedDate 
	) VALUES (
		@CategoryName,
		@UserID,
		@LastModifiedByID,
		@LastModifiedDate
	)
END
GO
