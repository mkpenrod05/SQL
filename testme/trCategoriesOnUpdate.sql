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
-- Description:	Inserts a record into the audit log after an update occurs on the categories table.
-- =============================================
ALTER TRIGGER dbo.trCategoriesOnUpdate 
   ON  dbo.tblCategories
   AFTER UPDATE
AS 
BEGIN
    
	--Declare the variables needed for the audit log stored procedure
	Declare @AffectedTable nvarchar(50) = 'tblCategories'
	Declare @AffectedRecordID int
	Declare @LastModifiedByID int
	Declare @LastModifiedDate datetime = GETDATE()
	
	--Declare the variables needed to determine which values have been changed.
	Declare @ID int
	Declare @OldActive bit, @NewActive bit
	Declare @OldCategoryName nvarchar(50), @NewCategoryName nvarchar(50)
	
    -- Load the updated records into temporary table
    Select * Into #TempTable From inserted
     
    -- Loop thru the records in temp table
    While(Exists(Select Id from #TempTable))
    Begin   
        -- Select first row data from temp table
        Select Top(1) 
			@ID = ID, 
			@NewActive = Active, 
			@NewCategoryName = CategoryName,
			@LastModifiedByID = LastModifiedByID
        from #TempTable
           
        -- Select the corresponding row from deleted table
        Select @OldActive = Active, 
			@OldCategoryName = CategoryName 
        from deleted where ID = @ID
		
		--Set the variables that could change from loop to loop
		Set @AffectedRecordID = @ID

        if(@OldActive <> @NewActive)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'Active', 
				@AffectedRecordID,
				'Category Status Update',
				@OldActive,
				@NewActive,
				@LastModifiedByID,
				@LastModifiedDate
		End

        if(@OldCategoryName <> @NewCategoryName)
        Begin
			Execute spInsertIntoAuditLog 
				@AffectedTable, 
				'CategoryName', 
				@AffectedRecordID,
				'Category Name Update',
				@OldCategoryName,
				@NewCategoryName,
				@LastModifiedByID,
				@LastModifiedDate
		End
		   
        -- Delete the row from temp table, so we can move to the next row
        Delete from #TempTable where ID = @ID
    
	End --While loop
END
GO
