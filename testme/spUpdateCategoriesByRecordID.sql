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
-- Description:	Used to update a record into tblCategories
-- =============================================
CREATE PROCEDURE dbo.spUpdateCategoriesByRecordID 
	@UserID int,
	@RecordID int,
	@Active bit,
	@CategoryName nvarchar(50),
	@LastModifiedDate datetime
AS
BEGIN
	
	DECLARE @LastModifiedByID int
	SET @LastModifiedByID = @UserID

	UPDATE dbo.tblCategories
	SET Active = @Active,
		CategoryName = @CategoryName,
		LastModifiedByID = @UserID,
		LastModifiedDate = @LastModifiedDate
	WHERE ID = @RecordID
END
GO
