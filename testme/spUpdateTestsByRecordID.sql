USE [testme]
GO
/****** Object:  StoredProcedure [dbo].[spUpdateTestsByRecordID]    Script Date: 1/2/2014 2:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Michael C. Penrod
-- Create date: 29 Dec 2013
-- Description:	Used to update tblTests by a record ID.
-- =============================================
ALTER PROCEDURE [dbo].[spUpdateTestsByRecordID]
	@RecordID int,
	@Active bit,
	@TestName nvarchar(100)

AS
BEGIN
	if 
		exists(
			Select 1 
			From dbo.tblTests
			Where ID = @RecordID and Active = @Active and TestName = @TestName
		) 
		begin
			Select 'No update required, the values selected have not been modified.' 
				As DBErrorMessage
			return
		end
	else
		Declare @LastModifiedDate datetime

		Set @LastModifiedDate = GETDATE()

		Update dbo.tblTests
		Set Active = @Active,
			TestName = @TestName,
			LastModifiedDate = @LastModifiedDate
		Where ID = @RecordID

END
