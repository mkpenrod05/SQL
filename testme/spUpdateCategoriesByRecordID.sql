USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCategoriesByRecordID]    Script Date: 1/2/2014 2:07:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 29 Dec 2013
-- Description:	Used to update a record into tblCategories
-- =============================================
ALTER PROCEDURE [dbo].[spUpdateCategoriesByRecordID] 
	--@UserID int,
	@RecordID int,
	@Active bit,
	@CategoryName nvarchar(50)
	--@LastModifiedDate datetime
AS
BEGIN
	if 
		exists(
			Select 1 
			From dbo.tblCategories
			Where ID = @RecordID and Active = @Active and CategoryName = @CategoryName
		) 
		begin
			Select 'No update required, the values selected have not been modified.' 
				As DBErrorMessage
			return
		end
	else
		--DECLARE @LastModifiedByID int
		DECLARE @LastModifiedDate datetime
	
		--SET @LastModifiedByID = @UserID
		SET @LastModifiedDate = GETDATE()

		UPDATE dbo.tblCategories
		SET Active = @Active,
			CategoryName = @CategoryName,
			--LastModifiedByID = @UserID,
			LastModifiedDate = @LastModifiedDate
		WHERE ID = @RecordID and not exists(
			Select 1 From dbo.tblCategories
			Where ID = @RecordID and Active = @Active and CategoryName = @CategoryName
		)

END
