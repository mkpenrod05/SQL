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
-- Description:	Used to update tblTests by a record ID.
-- =============================================
CREATE PROCEDURE dbo.spUpdateTestsByRecordID
	@ID int,
	@Active bit,
	@UserID int,
	@TestName nvarchar(100)

AS
BEGIN
	
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime

	Set @LastModifiedByID = @UserID
	Set @LastModifiedDate = GETDATE()

	Update dbo.tblTests
	Set Active = @Active,
		TestName = @TestName,
		LastModifiedByID = @LastModifiedByID,
		LastModifiedDate = @LastModifiedDate
	Where ID = @ID

END
GO
