-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 29 Dec 2013
-- Description:	Inserts a record into the audit log after an insert occurs on the categories table.
-- =============================================
CREATE TRIGGER dbo.trCategoriesOnInsert 
   ON  dbo.tblCategories
   AFTER INSERT
AS 
BEGIN
	
	Declare @ID int
	Declare @NewValue nvarchar(50)
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime = GETDATE()

	Select @ID = ID, @NewValue = CategoryName, @LastModifiedByID = LastModifiedByID
	From inserted

	Execute spInsertIntoAuditLog 'tblCategories', 'CategoryName', @ID, 'New Category Inserted', '', @NewValue, @LastModifiedByID, @LastModifiedDate

END
GO
